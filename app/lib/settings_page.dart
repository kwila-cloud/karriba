import 'package:flutter/material.dart';
import 'coming_soon_dialog.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AI!: use list of  ListItem instead of ElevatedButton
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ComingSoonDialog();
                  },
                );
              },
              child: Text('Import Data'),
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ComingSoonDialog();
                  },
                );
              },
              child: Text('Export Data'),
            ),
          ],
        ),
      ),
    );
  }
}
