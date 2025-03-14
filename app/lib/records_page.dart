import 'package:flutter/material.dart';
import 'top_level_page.dart';
import 'edit_record_page.dart';
import 'record.dart';
import 'records_dao.dart';

class RecordsPage extends StatefulWidget {
  const RecordsPage({super.key});

  @override
  State<RecordsPage> createState() => _RecordsPageState();
}

class _RecordsPageState extends State<RecordsPage> {
  late Future<List<Record>> _recordsFuture;
  final _recordsDao = RecordsDao();

  @override
  void initState() {
    super.initState();
    _refreshRecords();
  }

  _refreshRecords() {
    setState(() {
      _recordsFuture = _recordsDao.queryAllRows();
    });
  }

  @override
  Widget build(BuildContext context) {
    return TopLevelPage(
      body: FutureBuilder<List<Record>>(
        future: _recordsFuture,
        builder: (context, snapshot) {
          final records = snapshot.data;
          if (records != null) {
            return ListView.builder(
              itemCount: records.length,
              itemBuilder: (context, index) => RecordTile(record: records[index]),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      onAddPressed: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const EditRecordPage()),
        ).then((_) => _refreshRecords());
      },
    );
  }
}

class RecordTile extends StatelessWidget {
  const RecordTile({super.key, required this.record});

  final Record record;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Record ID: ${record.id}'),
      subtitle: Text('Customer ID: ${record.customerId}, Applicator ID: ${record.applicatorId}'),
    );
  }
}
