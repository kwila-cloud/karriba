import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

Future<void> exportDatabase(BuildContext context) async {
  try {
    String databasesPath = await getDatabasesPath();
    String dbPath = '$databasesPath/karriba.db';

    Directory? downloadsDir;
    if (Platform.isAndroid) {
      downloadsDir = Directory("/storage/emulated/0/Download");
    }
    // TODO: allow the user to select the download directory

    if (downloadsDir == null) {
      throw Exception("Data export is not yet supported on this platform.");
    }

    String formattedDate = DateFormat(
      'yyyy-MM-dd_HH-mm-ss',
    ).format(DateTime.now());
    String exportPath = '${downloadsDir.path}/karriba_export_$formattedDate.db';

    File sourceFile = File(dbPath);
    await sourceFile.copy(exportPath);

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
