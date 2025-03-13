import 'package:karriba/customer.dart';
import 'package:karriba/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class CustomerDao {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  Future<int> insert(Customer customer) async {
    Database db = await dbHelper.database;
    return await db.insert('customer', customer.toMap());
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
}
