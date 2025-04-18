import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:karriba/applicators_page.dart';
import 'package:karriba/pesticide/pesticides_page.dart';

import 'data_exporter.dart';
import 'data_importer.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        AppBar(title: Text('Settings')),
        ListTile(
          leading: const Iconify(Mdi.account_cowboy_hat),
          title: const Text('Applicators'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ApplicatorsPage()),
            );
          },
        ),
        ListTile(
          leading: const Iconify(Mdi.bottle_tonic),
          title: const Text('Pesticides'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PesticidesPage()),
            );
          },
        ),
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
