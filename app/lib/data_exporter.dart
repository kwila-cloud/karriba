import 'dart:io';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:karriba/database_helper.dart';
import 'package:path/path.dart';
import 'package:universal_html/html.dart' as html; // Import for web file saving

Future<void> exportDatabase(BuildContext context) async {
  final String formattedDate = DateFormat(
    'yyyy-MM-dd_HH-mm-ss',
  ).format(DateTime.now());
  String jsonData = await DatabaseHelper.instance.exportToJson();
  String fileName = 'karriba_export_$formattedDate.json';
  try {
    if (kIsWeb) {
      // Download the file
      final blob = html.Blob([jsonData], 'application/json');
      final url = html.Url.createObjectUrlFromBlob(blob);
      html.AnchorElement(href: url)
        ..setAttribute('download', fileName)
        ..click();
      html.Url.revokeObjectUrl(url);
    } else if (Platform.isAndroid) {
      // TODO: allow the user to select the download directory
      String downloadsDir = "/storage/emulated/0/Download";
      File file = File(join(downloadsDir, fileName));
      await file.writeAsString(jsonData);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Data exported to ${file.path}')));
    } else {
      throw Exception("Data export is not yet supported on this platform.");
    }
  } catch (e) {
    // Show error message
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Error exporting data: $e')));
  }
}
