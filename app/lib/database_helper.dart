import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _currentSchemaVersion = 2;

  // Make this a singleton class.
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only have a single app-wide reference to the database.
  static Database? _database;
  static get path async => join(await getDatabasesPath(), "karriba.db");

  Future<Database> get database async {
    if (_database != null) return _database!;
    // Lazily instantiate the db the first time it is accessed.
    _database = await _initDatabase();
    return _database!;
  }

  // Open the database.
  Future<Database> _initDatabase() async {
    return await openDatabase(
      path,
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
        field_name TEXT NOT NULL
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
  }
}
