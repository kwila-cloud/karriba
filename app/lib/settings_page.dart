import 'package:flutter/material.dart';
import 'coming_soon_dialog.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.import_export),
            title: const Text('Import Data'),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const ComingSoonDialog();
                },
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.import_export),
            title: const Text('Export Data'),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const ComingSoonDialog();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
