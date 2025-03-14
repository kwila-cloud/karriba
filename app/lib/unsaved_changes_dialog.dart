import 'package:flutter/material.dart';

Future<bool> showUnsavedChangesDialog(BuildContext context) async {
  return await showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: const Text('Are you sure?'),
              content: const Text(
                'Are you sure you want to leave? You will lose unsaved changes.',
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  style: TextButton.styleFrom(foregroundColor: Colors.red),
                  child: const Text('Leave'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Stay'),
                ),
              ],
            ),
      ) ??
      false;
}
