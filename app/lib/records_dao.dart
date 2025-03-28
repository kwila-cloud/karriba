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
        record.crop,
        record.total_area,
        record.price_per_acre,
        record.spray_volume,
        record.wind_speed_before,
        record.wind_speed_after,
        record.wind_direction,
        record.temperature,
        record.notes
      FROM record
      INNER JOIN applicator ON record.applicator_id = applicator.id
      INNER JOIN customer ON record.customer_id = customer.id
      ORDER BY record.timestamp DESC
    ''');

    // Convert the List<Map<String, dynamic> into a List<Record>.
    return List.generate(maps.length, (i) {
      return Record(
        id: maps[i]['id'] as int?,
        timestamp: DateTime.fromMillisecondsSinceEpoch(
          maps[i]['timestamp'] as int,
        ),
        applicatorId: maps[i]['applicator_id'] as int,
        applicatorName: maps[i]['applicator_name'] as String,
        customerId: maps[i]['customer_id'] as int,
        customerName: maps[i]['customer_name'] as String,
        customerInformedOfRei:
            (maps[i]['customer_informed_of_rei'] as int) == 1,
        fieldName: maps[i]['field_name'] as String,
        crop: maps[i]['crop'] as String,
        totalArea: maps[i]['total_area'] as double,
        pricePerAcre: maps[i]['price_per_acre'] as double,
        sprayVolume: maps[i]['spray_volume'] as double,
        windSpeedBefore: maps[i]['wind_speed_before'] as double?,
        windSpeedAfter: maps[i]['wind_speed_after'] as double?,
        windDirection: maps[i]['wind_direction'] as String?,
        temperature: maps[i]['temperature'] as double?,
        notes: maps[i]['notes'] as String,
      );
    });
  }

  Future<Record?> get(int id) async {
    Database db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'record',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Record(
        id: maps[0]['id'] as int?,
        timestamp: DateTime.fromMillisecondsSinceEpoch(
          maps[0]['timestamp'] as int,
        ),
        applicatorId: maps[0]['applicator_id'] as int,
        customerId: maps[0]['customer_id'] as int,
        customerInformedOfRei:
            (maps[0]['customer_informed_of_rei'] as int) == 1,
        fieldName: maps[0]['field_name'] as String,
        crop: maps[0]['crop'] as String,
        totalArea: maps[0]['total_area'] as double,
        pricePerAcre: maps[0]['price_per_acre'] as double,
        sprayVolume: maps[0]['spray_volume'] as double,
        windSpeedBefore: maps[0]['wind_speed_before'] as double?,
        windSpeedAfter: maps[0]['wind_speed_after'] as double?,
        windDirection: maps[0]['wind_direction'] as String?,
        temperature: maps[0]['temperature'] as double?,
        notes: maps[0]['notes'] as String,
      );
    }
    return null;
  }
}
