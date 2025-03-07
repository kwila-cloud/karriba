import 'package:flutter/material.dart';
import 'coming_soon_dialog.dart';

class FlightsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Flights Page'),
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
