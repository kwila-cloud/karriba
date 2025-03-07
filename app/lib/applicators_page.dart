import 'package:flutter/material.dart';
import 'coming_soon_dialog.dart';

class ApplicatorsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Applicators Page'),
      ),
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
