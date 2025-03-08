import 'package:flutter/material.dart';
import 'package:karriba/new_customer_page.dart';
import 'top_level_page.dart';

class CustomersPage extends StatelessWidget {
  const CustomersPage({super.key});

  @override
  Widget build(BuildContext context) => TopLevelPage(
    body: ListView(),
    onAddPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const NewCustomerPage()),
      );
    },
  );
}
