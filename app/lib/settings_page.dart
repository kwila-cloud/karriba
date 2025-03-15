import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'coming_soon_dialog.dart';
import 'data_exporter.dart';

class SettingsPage extends StatelessWidget {
  final DataExporter dataExporter = DataExporter();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: const Iconify(Mdi.database_import),
            title: const Text('Import Data'),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => const ComingSoonDialog(),
              );
            },
          ),
          ListTile(
            leading: const Iconify(Mdi.database_export),
            title: const Text('Export Data'),
            onTap: () => dataExporter.exportDatabase(context),
          ),
        ],
      ),
    );
  }
}
