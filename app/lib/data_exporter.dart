import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:intl/intl.dart';

// AI!: remove the class. Just use a bare function
class DataExporter {
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
      Directory? downloadsDir;
      if (Platform.isAndroid) {
        downloadsDir = await getExternalStorageDirectory();
      } else {
        downloadsDir = await getApplicationDocumentsDirectory();
      }

      if (downloadsDir == null) {
        throw Exception('Could not get downloads directory');
      }

      String formattedDate = DateFormat(
        'yyyy-MM-dd_HH-mm-ss',
      ).format(DateTime.now());
      String exportPath =
          '${downloadsDir.path}/karriba_export_$formattedDate.db';

      // 4. Copy the database file
      File sourceFile = File(dbPath);
      await sourceFile.copy(exportPath);

      // 5. Show success message
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Data exported to $exportPath')));
    } catch (e) {
      // 6. Show error message
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error exporting data: $e')));
    }
  }
}
