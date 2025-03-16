import 'package:karriba/applicator.dart';
import 'package:karriba/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class ApplicatorDao {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  Future<int> save(Applicator applicator) async {
    Database db = await dbHelper.database;
    if (applicator.id == null) {
      return await db.insert('applicator', applicator.toMap());
    } else {
      return await db.update(
        'applicator',
        applicator.toMap(),
        where: 'id = ?',
        whereArgs: [applicator.id],
      );
    }
  }

  Future<List<Applicator>> queryAllRows() async {
    Database db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('applicator');

    // Convert the List<Map<String, dynamic> into a List<Applicator>.
    return List.generate(maps.length, (i) {
      return Applicator(
        id: maps[i]['id'] as int?,
        name: maps[i]['name'] as String,
        licenseNumber: maps[i]['license_number'] as String,
      );
    });
  }

  Future<Applicator?> get(int id) async {
    Database db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'applicator',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Applicator(
        id: maps[0]['id'] as int?,
        name: maps[0]['name'] as String,
        licenseNumber: maps[0]['license_number'] as String,
      );
    } else {
      return null;
    }
  }
}
