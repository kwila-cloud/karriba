import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:intl/intl.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';

Future<void> exportDatabase(BuildContext context) async {
  // 1. Check and request storage permission
  var status = await Permission.storage.status;
  if (!status.isGranted) {
    status = await Permission.storage.request();
    if (!status.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Storage permission required to export data.'),
        ),
      );
      return;
    }
  }

  try {
    // 2. Get the database path
    String databasesPath = await getDatabasesPath();
    String dbPath = '$databasesPath/karriba.db';

    // 3. Generate the export file path
    String formattedDate = DateFormat(
      'yyyy-MM-dd_HH-mm-ss',
    ).format(DateTime.now());
    String fileName = 'karriba_export_$formattedDate.db';

    final params = SaveFileDialogParams(
      sourceFilePath: dbPath,
      fileName: fileName,
    );

    final filePath = await FlutterFileDialog.saveFile(params: params);

    if (filePath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Export cancelled'),
        ),
      );
      return;
    }

    // 4. Copy the database file
    File sourceFile = File(dbPath);
    File destFile = File(filePath);
    await sourceFile.copy(filePath);

    // 5. Show success message
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Data exported to $filePath')));
  } catch (e) {
    // 6. Show error message
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Error exporting data: $e')));
  }
}
