import 'dart:io';
import 'dart:js' as js;
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:karriba/database_helper.dart';

Future<void> exportDatabase(BuildContext context) async {
  final String formattedDate = DateFormat(
    'yyyy-MM-dd_HH-mm-ss',
  ).format(DateTime.now());
  try {
    if (kIsWeb) {
      // Export to JSON on web
      String jsonData = await DatabaseHelper.instance.exportToJson();
      String fileName = 'karriba_export_$formattedDate.json';

      // Create a download
      js.context.callMethod('downloadFile', [fileName, jsonData]);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Data exported to $fileName')));
    } else {
      // Export to DB file on other platforms
      Directory? downloadsDir;
      if (Platform.isAndroid) {
        downloadsDir = Directory("/storage/emulated/0/Download");
      }
      // TODO: allow the user to select the download directory

      if (downloadsDir == null) {
        throw Exception("Data export is not yet supported on this platform.");
      }

      String exportPath =
          '${downloadsDir.path}/karriba_export_$formattedDate.db';

      File sourceFile = File(await DatabaseHelper.getPath());
      await sourceFile.copy(exportPath);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Data exported to $exportPath')));
    }
  } catch (e) {
    // Show error message
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Error exporting data: $e')));
  }
}
