import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'data_exporter.dart';
import 'data_importer.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          leading: const Iconify(Mdi.database_import),
          title: const Text('Import Data'),
          onTap: () {
            importDatabase(context);
          },
        ),
        ListTile(
          leading: const Iconify(Mdi.database_export),
          title: const Text('Export Data'),
          onTap: () => exportDatabase(context),
        ),
      ],
    );
  }
}
