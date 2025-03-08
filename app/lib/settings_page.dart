import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'coming_soon_dialog.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: const Iconify(Mdi.database_import),
            title: const Text('Import Data'),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => ComingSoonDialog(),
              );
            },
          ),
          ListTile(
            leading: const Iconify(Mdi.database_export),
            title: const Text('Export Data'),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => ComingSoonDialog(),
              );
            },
          ),
        ],
      ),
    );
  }
}
