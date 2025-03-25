import 'package:karriba/database_helper.dart';
import 'package:karriba/pesticide/pesticide.dart';
import 'package:sqflite/sqflite.dart';

class PesticideDao {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  Future<int> save(Pesticide pesticide) async {
    Database db = await dbHelper.database;
    if (pesticide.id == null) {
      return await db.insert('pesticide', pesticide.toMap());
    } else {
      return await db.update(
        'pesticide',
        pesticide.toMap(),
        where: 'id = ?',
        whereArgs: [pesticide.id],
      );
    }
  }

  Future<List<Pesticide>> queryAllRows() async {
    Database db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('pesticide');

    // Convert the List<Map<String, dynamic> into a List<Pesticide>.
    return List.generate(maps.length, (i) {
      return Pesticide(
        id: maps[i]['id'] as int?,
        name: maps[i]['name'] as String,
        registrationNumber: maps[i]['registration_number'] as String,
      );
    });
  }

  Future<Pesticide?> get(int id) async {
    Database db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'pesticide',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Pesticide(
        id: maps[0]['id'] as int?,
        name: maps[0]['name'] as String,
        registrationNumber: maps[0]['registration_number'] as String,
      );
    } else {
      return null;
    }
  }
}
