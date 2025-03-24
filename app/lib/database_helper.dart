import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';

class DatabaseHelper {
  static const _currentSchemaVersion = 4;

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
    return await openDatabase(
      await getPath(),
      version: _currentSchemaVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade, // Handle migrations between DB versions
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
        timestamp INTEGER NOT NULL,
        applicator_id INTEGER NOT NULL,
        customer_id INTEGER NOT NULL,
        customer_informed_of_rei INTEGER NOT NULL,
        field_name TEXT NOT NULL,
        wind_speed_before REAL,
        wind_speed_after REAL,
        wind_direction TEXT,
        temperature REAL
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

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Create the record table if it doesn't exist
      await db.execute('''
        CREATE TABLE IF NOT EXISTS record (
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
        CREATE TABLE IF NOT EXISTS record (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          timestamp INTEGER NOT NULL,
          applicator_id INTEGER NOT NULL,
          customer_id INTEGER NOT NULL,
          customer_informed_of_rei INTEGER NOT NULL,
          field_name TEXT NOT NULL
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
}
