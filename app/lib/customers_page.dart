import 'package:flutter/material.dart';
import 'top_level_page.dart';
import 'package:karriba/customer.dart';
import 'package:karriba/customer_dao.dart';
import 'edit_customer_page.dart';

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
    setState(() {
      _customersFuture = _customerDao.queryAllRows();
    });
  }

  @override
  Widget build(BuildContext context) {
    return TopLevelPage(
      appBar: AppBar(title: Text('Customers')),
      body: FutureBuilder<List<Customer>>(
        future: _customersFuture,
        builder: (context, snapshot) {
          final customers = snapshot.data;
          if (customers != null) {
            return ListView.builder(
              itemCount: customers.length,
              itemBuilder:
                  (context, index) => CustomerTile(
                    customer: customers[index],
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) =>
                                  EditCustomerPage(customer: customers[index]),
                        ),
                      );
                      // Refresh the list after editing a customer
                      _refreshCustomers();
                    },
                  ),
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
          MaterialPageRoute(builder: (context) => const EditCustomerPage()),
        );
        // Refresh the list after adding a new customer
        _refreshCustomers();
      },
    );
  }
}

class CustomerTile extends StatelessWidget {
  const CustomerTile({super.key, required this.customer, this.onTap});

  final Customer customer;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(customer.name),
      subtitle: Text('${customer.city}, ${customer.state}'),
      onTap: onTap,
    );
  }
}
