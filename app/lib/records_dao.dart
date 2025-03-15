import 'package:karriba/record.dart';
import 'package:karriba/database_helper.dart';
import 'package:sqflite/sqflite.dart';

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
        record.customer_id,
        record.applicator_id,
        record.customer_informed_of_rei,
        customer.name AS customer_name,
        record.field_name
      FROM record
      INNER JOIN customer ON record.customer_id = customer.id
    ''');

    // Convert the List<Map<String, dynamic> into a List<Record>.
    return List.generate(maps.length, (i) {
      return Record(
        id: maps[i]['id'] as int?,
        timestamp: DateTime.fromMillisecondsSinceEpoch(
          maps[i]['timestamp'] as int,
        ),
        customerId: maps[i]['customer_id'] as int,
        applicatorId: maps[i]['applicator_id'] as int,
        customerInformedOfRei:
            (maps[i]['customer_informed_of_rei'] as int) == 1,
        customerName: maps[i]['customer_name'] as String,
        fieldName: maps[i]['field_name'] as String?,
      );
    });
  }
}
