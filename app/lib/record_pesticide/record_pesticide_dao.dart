import 'package:karriba/database_helper.dart';
import 'package:karriba/record_pesticide/record_pesticide.dart';
import 'package:sqflite/sqflite.dart';

class RecordPesticideDao {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  Future<bool> _exists(int recordId, int pesticideId) async {
    Database db = await dbHelper.database;
    final List<Map<String, dynamic>> result = await db.query(
      'record_pesticide',
      where: 'record_id = ? AND pesticide_id = ?',
      whereArgs: [recordId, pesticideId],
    );
    return result.isNotEmpty;
  }

  Future<int> save(RecordPesticide recordPesticide) async {
    Database db = await dbHelper.database;
    bool exists = await _exists(
      recordPesticide.recordId,
      recordPesticide.pesticideId,
    );

    if (exists) {
      return await db.update(
        'record_pesticide',
        recordPesticide.toMap(),
        where: 'record_id = ? AND pesticide_id = ?',
        whereArgs: [recordPesticide.recordId, recordPesticide.pesticideId],
      );
    } else {
      return await db.insert('record_pesticide', recordPesticide.toMap());
    }
  }

  Future<void> saveAll(List<RecordPesticide> recordPesticides) async {
    Database db = await dbHelper.database;
    Batch batch = db.batch();

    for (var recordPesticide in recordPesticides) {
      bool exists = await _exists(
        recordPesticide.recordId,
        recordPesticide.pesticideId,
      );
      if (exists) {
        batch.update(
          'record_pesticide',
          recordPesticide.toMap(),
          where: 'record_id = ? AND pesticide_id = ?',
          whereArgs: [recordPesticide.recordId, recordPesticide.pesticideId],
        );
      } else {
        batch.insert('record_pesticide', recordPesticide.toMap());
      }
    }
    await batch.apply();
  }

  Future<void> delete(int recordId, int pesticideId) async {
    Database db = await dbHelper.database;
    db.delete(
      'record_pesticide',
      where: 'record_id = ? AND pesticide_id = ?',
      whereArgs: [recordId, pesticideId],
    );
  }

  Future<List<RecordPesticide>> queryByRecordId(int recordId) async {
    Database db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'record_pesticide',
      where: 'record_id = ?',
      whereArgs: [recordId],
    );

    // Convert the List<Map<String, dynamic> into a List<RecordPesticide>.
    return List.generate(maps.length, (i) {
      return RecordPesticide(
        recordId: maps[i]['record_id'] as int,
        pesticideId: maps[i]['pesticide_id'] as int,
        rate: maps[i]['rate'] as double,
        rateUnit: maps[i]['rate_unit'] as String,
      );
    });
  }
}
