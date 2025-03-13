import 'package:flutter/material.dart';
import 'package:karriba/customer.dart';
import 'package:karriba/customer_dao.dart';
import 'package:karriba/new_customer_page.dart';
import 'top_level_page.dart';

class CustomersPage extends StatefulWidget {
  const CustomersPage({super.key});

  @override
  State<CustomersPage> createState() => _CustomersPageState();
}

class _CustomersPageState extends State<CustomersPage> {
  late Future<List<Customer>> _customersFuture;
  final _customerDao = CustomerDao();

  @override
  void initState() {
    super.initState();
    _refreshCustomers();
  }

  _refreshCustomers() {
    _customersFuture = _customerDao.queryAllRows();
  }

  @override
  Widget build(BuildContext context) => TopLevelPage(
    body: FutureBuilder<List<Customer>>(
      future: _customersFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final customers = snapshot.data!;
          return ListView.builder(
            itemCount: customers.length,
            itemBuilder: (context, index) {
              final customer = customers[index];
              return CustomerTile(customer: customer);
            },
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    ),
    onAddPressed: () async {
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const NewCustomerPage()),
      );
      // Refresh the list after adding a new customer
      setState(() {
        _refreshCustomers();
      });
    },
  );
}

class CustomerTile extends StatelessWidget {
  const CustomerTile({super.key, required this.customer});

  final Customer customer;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(customer.name),
      subtitle: Text('${customer.city}, ${customer.state}'),
    );
  }
}
