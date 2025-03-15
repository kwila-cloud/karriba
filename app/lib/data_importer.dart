import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:file_picker/file_picker.dart';
import 'package:karriba/database_helper.dart';

Future<void> importDatabase(BuildContext context) async {
  bool? importConfirmed = await showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      final importCodeController = TextEditingController();
      bool importButtonEnabled = false;

      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            title: const Text('Import Data?'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'This will overwrite all existing data. Type "import" to continue.',
                ),
                TextFormField(
                  controller: importCodeController,
                  decoration: const InputDecoration(
                    hintText: 'Type "import" here',
                  ),
                  onChanged: (text) {
                    setState(() {
                      importButtonEnabled = text == 'import';
                    });
                  },
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              ElevatedButton(
                onPressed:
                    importButtonEnabled
                        ? () {
                          Navigator.of(context).pop(true);
                        }
                        : null,
                child: const Text('Import'),
              ),
            ],
          );
        },
      );
    },
  );

  if (importConfirmed == true) {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['db'],
    );

    if (result != null) {
      String? pathToImport = result.files.single.path;

      if (pathToImport != null) {
        try {
          await _performDatabaseImport(pathToImport);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Data imported successfully!')),
          );
        } catch (e) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error importing data: $e')));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error: Could not get file path.')),
        );
      }
    } else {
      // User canceled the picker
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Import cancelled.')));
    }
  }
}

// AI!: this logic should be DatabaseHelper
Future<void> _performDatabaseImport(String pathToImport) async {
  final Database db = await DatabaseHelper.instance.database;
  // Get the path to the application's database directory
  String appDbPath = await DatabaseHelper.getPath();

  // Delete the existing database
  await db.close();
  await deleteDatabase(appDbPath);

  // Copy the selected database file to the application's database path
  await File(pathToImport).copy(appDbPath);

  // Re-open the database
  await DatabaseHelper.instance.database;
}
