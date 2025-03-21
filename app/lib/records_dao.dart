import 'package:sqflite/sqflite.dart';

import 'database_helper.dart';
import 'record.dart';

class RecordsDao {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  Future<int> save(Record record) async {
    Database db = await dbHelper.database;
    if (record.id == null) {
      return await db.insert('record', record.toMap());
    } else {
      return await db.update(
        'record',
        record.toMap(),
        where: 'id = ?',
        whereArgs: [record.id],
      );
    }
  }

  Future<List<Record>> queryAllRows() async {
    Database db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
      SELECT 
        record.id,
        record.timestamp,
        record.applicator_id,
        applicator.name as applicator_name,
        record.customer_id,
        customer.name AS customer_name,
        record.customer_informed_of_rei,
        record.field_name,
        record.wind_speed_before,
        record.wind_speed_after,
        record.wind_direction,
        record.temperature
      FROM record
      INNER JOIN applicator ON applicator.id = record.applicator_id
      INNER JOIN customer ON customer.id = record.customer_id
    ''');

    // Convert the List<Map<String, dynamic> into a List<Record>.
    return List.generate(maps.length, (i) {
      return Record(
        id: maps[i]['id'] as int?,
        timestamp: DateTime.fromMillisecondsSinceEpoch(maps[i]['timestamp'] as int),
        applicatorId: maps[i]['applicator_id'] as int,
        applicatorName: maps[i]['applicator_name'] as String,
        customerId: maps[i]['customer_id'] as int,
        customerName: maps[i]['customer_name'] as String,
        customerInformedOfRei: (maps[i]['customer_informed_of_rei'] as int) == 1,
        fieldName: maps[i]['field_name'] as String,
        windSpeedBefore: maps[i]['wind_speed_before'] as double?,
        windSpeedAfter: maps[i]['wind_speed_after'] as double?,
        windDirection: maps[i]['wind_direction'] as String?,
        temperature: maps[i]['temperature'] as double?,
      );
    });
  }
}
