import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'dart:convert';

import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class DatabaseHelper {
  static const _currentSchemaVersion = 6;
  static const List<String> tables = [
    'applicator',
    'customer',
    'record',
    'pesticide',
    'record_pesticide',
  ];

  static getPath() async => join(await getDatabasesPath(), "karriba.db");

  // Make this a singleton class.
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only have a single app-wide reference to the database.
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    // Lazily instantiate the db the first time it is accessed.
    _database = await _initDatabase();
    return _database!;
  }

  // Open the database.
  Future<Database> _initDatabase() async {
    if (kIsWeb) {
      databaseFactory = databaseFactoryFfiWeb;
    }
    return await openDatabase(
      await getPath(),
      version: _currentSchemaVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade, // Handle migrations between DB versions
      onOpen: _onOpen,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE applicator (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        license_number TEXT NOT NULL
      )
      ''');
    await db.execute('''
      CREATE TABLE customer (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        street_address TEXT NOT NULL,
        city TEXT NOT NULL,
        state TEXT NOT NULL,
        zip_code TEXT NOT NULL
      )
      ''');
    await db.execute('''
      CREATE TABLE record (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        start_timestamp INTEGER NOT NULL,
        end_timestamp INTEGER NOT NULL,
        applicator_id INTEGER NOT NULL,
        customer_id INTEGER NOT NULL,
        customer_informed_of_rei INTEGER NOT NULL,
        field_name TEXT NOT NULL,
        crop TEXT NOT NULL,
        total_area REAL NOT NULL,
        price_per_acre REAL NOT NULL,
        spray_volume REAL NOT NULL,
        wind_speed_before REAL,
        wind_speed_after REAL,
        wind_direction TEXT,
        temperature REAL,
        notes TEXT NOT NULL
      )
      ''');
    await db.execute('''
      CREATE TABLE pesticide (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        registration_number TEXT NOT NULL
      )
      ''');
    await db.execute('''
      CREATE TABLE record_pesticide (
        record_id INTEGER NOT NULL,
        pesticide_id INTEGER NOT NULL,
        rate REAL NOT NULL,
        rate_unit TEXT NOT NULL,
        PRIMARY KEY (record_id, pesticide_id),
        FOREIGN KEY (record_id) REFERENCES record(id) ON DELETE CASCADE,
        FOREIGN KEY (pesticide_id) REFERENCES pesticide(id) ON DELETE CASCADE
      )
      ''');
  }

  Future _onOpen(Database db) async {
    // Enable foreign keys for sqlite so CASCADE deletion works.
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('''
      CREATE TABLE applicator (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        license_number TEXT NOT NULL
      )
      ''');
      await db.execute('''
      CREATE TABLE customer (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        street_address TEXT NOT NULL,
        city TEXT NOT NULL,
        state TEXT NOT NULL,
        zip_code TEXT NOT NULL
      )
      ''');
      await db.execute('''
        CREATE TABLE record (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          timestamp INTEGER NOT NULL,
          applicator_id INTEGER NOT NULL,
          customer_id INTEGER NOT NULL,
          customer_informed_of_rei INTEGER NOT NULL,
          field_name TEXT NOT NULL
        )
        ''');
    }
    if (oldVersion < 3) {
      // Add the environmental condition fields
      await db.execute('''
        ALTER TABLE record ADD COLUMN wind_speed_before REAL;
      ''');
      await db.execute('''
        ALTER TABLE record ADD COLUMN wind_speed_after REAL;
      ''');
      await db.execute('''
        ALTER TABLE record ADD COLUMN wind_direction TEXT;
      ''');
      await db.execute('''
        ALTER TABLE record ADD COLUMN temperature REAL;
      ''');
    }
    if (oldVersion < 4) {
      // Create the pesticides related tables if they don't exist
      await db.execute('''
        CREATE TABLE IF NOT EXISTS pesticide (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          registration_number TEXT NOT NULL
        )
        ''');
      await db.execute('''
        CREATE TABLE IF NOT EXISTS record_pesticide (
          record_id INTEGER NOT NULL,
          pesticide_id INTEGER NOT NULL,
          rate REAL NOT NULL,
          rate_unit TEXT NOT NULL,
          PRIMARY KEY (record_id, pesticide_id),
          FOREIGN KEY (record_id) REFERENCES record(id) ON DELETE CASCADE,
          FOREIGN KEY (pesticide_id) REFERENCES pesticide(id) ON DELETE CASCADE
        )
        ''');
    }
    if (oldVersion < 5) {
      await db.execute('''
        ALTER TABLE record ADD COLUMN crop TEXT NOT NULL DEFAULT '';
      ''');
      await db.execute('''
        ALTER TABLE record ADD COLUMN total_area REAL NOT NULL DEFAULT 0;
      ''');
      await db.execute('''
        ALTER TABLE record ADD COLUMN price_per_acre REAL NOT NULL DEFAULT 0;
      ''');
      await db.execute('''
        ALTER TABLE record ADD COLUMN spray_volume REAL NOT NULL DEFAULT 0;
      ''');
      await db.execute('''
        ALTER TABLE record ADD COLUMN notes TEXT NOT NULL DEFAULT '';
      ''');
    }
    if (oldVersion < 6) {
      await db.execute('''
        ALTER TABLE record RENAME COLUMN timestamp TO start_timestamp;
      ''');
      await db.execute('''
        ALTER TABLE record ADD COLUMN end_timestamp INTEGER NOT NULL DEFAULT 0;
      ''');
      await db.execute('''
        UPDATE record SET end_timestamp = start_timestamp WHERE end_timestamp = 0;
      ''');
    }
  }

  /* WARNING: this will replace the whole DB. All data will be lost. */
  Future<void> importDbFile(String pathToImport) async {
    final Database db = await database;
    // Get the path to the application's database directory
    String appDbPath = await getPath();

    // Close and delete the existing database
    await db.close();
    _database = null;
    await deleteDatabase(appDbPath);

    // Copy the selected database file to the application's database path
    await File(pathToImport).copy(appDbPath);
  }

  Future<String> exportToJson() async {
    final db = await database;
    Map<String, dynamic> jsonMap = {};

    jsonMap['version'] = _currentSchemaVersion;

    for (var table in tables) {
      final List<Map<String, dynamic>> tableData = await db.query(table);
      jsonMap[table] = tableData;
    }

    return jsonEncode(jsonMap);
  }

  /* WARNING: this will replace the whole DB. All data will be lost. */
  Future<bool> importFromJson(String jsonData) async {
    final Map<String, dynamic> jsonMap = jsonDecode(jsonData);

    final Iterable<String> importTables = jsonMap.keys.where(
      (t) => t != 'version',
    );

    final int importedVersion = jsonMap['version'] ?? 1;
    final int currentVersion = _currentSchemaVersion;

    Database? tempDb;

    try {
      // 1. Open a blank in-memory database
      tempDb = await openDatabase(inMemoryDatabasePath, version: 1);

      // 2. Migrate the in-memory database to the imported version
      await _onUpgrade(tempDb, 1, importedVersion);

      // 3. Insert data into the in-memory database
      for (var table in importTables) {
        final List<dynamic>? tableData = jsonMap[table];
        if (tableData != null) {
          for (var row in tableData) {
            await tempDb.insert(table, row);
          }
        }
      }

      // 4. Migrate the in-memory database to the current version
      await _onUpgrade(tempDb, importedVersion, currentVersion);

      // 5. Get a reference to the real database
      final db = await database;

      // 6. Copy the data from the in-memory database to the real database
      for (var table in tables) {
        final List<Map<String, dynamic>> tableData = await tempDb.query(table);
        // Clear the old data from the table
        await db.delete(table, where: null);
        // Insert the new data
        for (var row in tableData) {
          await db.insert(table, row);
        }
      }
      return true;
    } catch (e) {
      return false;
    } finally {
      // 7. Close the in-memory database
      await tempDb?.close();
    }
  }
}
