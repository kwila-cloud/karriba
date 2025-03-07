import 'package:flutter/material.dart';
import 'coming_soon_dialog.dart';

class CustomersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return ComingSoonDialog();
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
