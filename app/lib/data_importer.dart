import 'package:flutter/material.dart';
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
            title: const Text('Import Data'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'This will overwrite all existing data. Type "overwrite" to continue.',
                ),
                TextFormField(
                  controller: importCodeController,
                  onChanged: (text) {
                    setState(() {
                      importButtonEnabled = text == 'overwrite';
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
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      String? pathToImport = result.files.single.path;

      if (pathToImport != null) {
        try {
          await DatabaseHelper.instance.importDbFile(pathToImport);

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
