import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:karriba/applicator.dart';

class DatabaseHelper {
  static const _databaseName = "Karriba.db";
  static const _databaseVersion = 1;

  static const tableApplicators = 'applicators';
  static const columnId = 'id';
  static const columnName = 'name';
  static const columnLicenseNumber = 'license_number';

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

  // Open the database (and create it if it doesn't exist).
  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  // SQL code to create the database table.
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableApplicators (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnName TEXT NOT NULL,
        $columnLicenseNumber TEXT NOT NULL
      )
      ''');
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(Applicator applicator) async {
    Database db = await instance.database;
    return await db.insert(tableApplicators, applicator.toMap());
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Applicator>> queryAllRows() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(tableApplicators);

    // Convert the List<Map<String, dynamic> into a List<Applicator>.
    return List.generate(maps.length, (i) {
      return Applicator(
        id: maps[i]['id'] as int?,
        name: maps[i]['name'] as String,
        licenseNumber: maps[i]['license_number'] as String,
      );
    });
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int?> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM $tableApplicators'),
    );
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(Applicator applicator) async {
    Database db = await instance.database;
    return await db.update(
      tableApplicators,
      applicator.toMap(),
      where: '$columnId = ?',
      whereArgs: [applicator.id],
    );
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(
      tableApplicators,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }
}
