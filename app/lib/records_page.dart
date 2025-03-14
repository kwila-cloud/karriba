import 'package:flutter/material.dart';
import 'top_level_page.dart';
import 'edit_record_page.dart';

class RecordsPage extends StatefulWidget {
  const RecordsPage({super.key});

  @override
  State<RecordsPage> createState() => _RecordsPageState();
}

class _RecordsPageState extends State<RecordsPage> {
  @override
  Widget build(BuildContext context) {
    return TopLevelPage(
      body: ListView(),
      onAddPressed: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const EditRecordPage()),
        );
        // TODO: Refresh the list after adding a new record
      },
    );
  }
}
