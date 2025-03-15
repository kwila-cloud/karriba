import 'package:flutter/material.dart';
import 'top_level_page.dart';
import 'edit_record_page.dart';
import 'record.dart';
import 'records_dao.dart';
import 'package:intl/intl.dart';

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
              itemBuilder:
                  (context, index) => RecordTile(
                    record: records[index],
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) =>
                                  EditRecordPage(record: records[index]),
                        ),
                      ).then((_) => _refreshRecords());
                    },
                  ),
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
  const RecordTile({super.key, required this.record, this.onTap});

  final Record record;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    String dateString = DateFormat.yMd().format(record.timestamp);
    return GestureDetector(
      // AI!: move this to the onLongPress option of ListTile
      onLongPress: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Wrap(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.picture_as_pdf),
                  title: const Text('Generate PDF'),
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: Implement PDF generation
                  },
                ),
              ],
            );
          },
        );
      },
      child: ListTile(
        title: Text("${record.customerName} - ${record.fieldName}"),
        subtitle: Text(dateString),
        onTap: onTap,
      ),
    );
  }
}
