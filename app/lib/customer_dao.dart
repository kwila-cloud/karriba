import 'package:karriba/customer.dart';
import 'package:karriba/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class CustomerDao {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  Future<int> save(Customer customer) async {
    Database db = await dbHelper.database;
    if (customer.id == null) {
      return await db.insert('customer', customer.toMap());
    } else {
      return await db.update(
        'customer',
        customer.toMap(),
        where: 'id = ?',
        whereArgs: [customer.id],
      );
    }
  }

  Future<List<Customer>> queryAllRows() async {
    Database db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('customer');

    // Convert the List<Map<String, dynamic> into a List<Customer>.
    return List.generate(maps.length, (i) {
      return Customer(
        id: maps[i]['id'] as int?,
        name: maps[i]['name'] as String,
        streetAddress: maps[i]['street_address'] as String,
        city: maps[i]['city'] as String,
        state: maps[i]['state'] as String,
        zipCode: maps[i]['zip_code'] as String,
      );
    });
  }

  Future<Customer?> get(int id) async {
    Database db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'customer',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Customer(
        id: maps[0]['id'] as int?,
        name: maps[0]['name'] as String,
        streetAddress: maps[0]['street_address'] as String,
        city: maps[0]['city'] as String,
        state: maps[0]['state'] as String,
        zipCode: maps[0]['zip_code'] as String,
      );
    } else {
      return null;
    }
  }
}
