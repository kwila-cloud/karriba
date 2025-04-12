import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:intl/intl.dart';
import 'package:karriba/data/database.dart';
import 'package:karriba/record_pesticide/edit_record_pesticides.dart';
import 'package:provider/provider.dart';

import 'edit_environmental_conditions_page.dart';
import 'edit_record_page.dart';
import 'pdf_generator.dart';
import 'top_level_page.dart';

class RecordsPage extends StatefulWidget {
  const RecordsPage({super.key});

  @override
  State<RecordsPage> createState() => _RecordsPageState();
}

class _RecordsPageState extends State<RecordsPage> {
  late Future<List<RecordViewData>> _recordsFuture;

  late AppDatabase _db;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _db = Provider.of<AppDatabase>(context);
      _refreshRecords();
    });
  }

  _refreshRecords() {
    setState(() {
      _recordsFuture = _db.recordView.all().get();
    });
  }

  @override
  Widget build(BuildContext context) {
    return TopLevelPage(
      body: FutureBuilder<List<RecordViewData>>(
        future: _recordsFuture,
        builder: (context, snapshot) {
          final records = snapshot.data;
          if (records != null) {
            return ListView.builder(
              itemCount: records.length,
              itemBuilder:
                  (context, index) => RecordTile(
                    record: records[index],
                    refresh: () => _refreshRecords(),
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
  const RecordTile({super.key, required this.record, required this.refresh});

  final RecordViewData record;
  final VoidCallback refresh;

  @override
  Widget build(BuildContext context) {
    String customerName = record.customerName ?? "Unknown Customer";
    String titleString = "$customerName - ${record.fieldName}";
    String subtitleString = record.applicatorName ?? "Unknown Applicator";
    String dateString = DateFormat.Md().format(record.startTimestamp);
    return ListTile(
      title: Text(titleString),
      subtitle: Text(subtitleString),
      trailing: Text(dateString),
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Wrap(
              children: <Widget>[
                ListTile(
                  title: Text(titleString),
                  subtitle: Text(subtitleString),
                  trailing: Text(dateString),
                ),
                ListTile(
                  leading: Iconify(Mdi.edit),
                  title: const Text('Edit'),
                  onTap: () async {
                    Navigator.pop(context);
                    // await Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => EditRecordPage(record: record),
                    //   ),
                    // );
                    refresh();
                  },
                ),
                ListTile(
                  leading: Iconify(Mdi.weather_windy),
                  title: const Text('Environmental Conditions'),
                  onTap: () async {
                    Navigator.pop(context);
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => EditEnvironmentalConditionsPage(
                              record: RecordData.fromJson(record.toJson()),
                            ),
                      ),
                    );
                    refresh();
                  },
                ),
                ListTile(
                  leading: Iconify(Mdi.bottle_tonic),
                  title: const Text('Pesticides'),
                  onTap: () async {
                    Navigator.pop(context);
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) =>
                                EditRecordPesticidesPage(recordId: record.id),
                      ),
                    );
                    refresh();
                  },
                ),
                ListTile(
                  leading: Iconify(Mdi.file_pdf),
                  title: const Text('Generate PDF'),
                  onTap: () async {
                    await PDFGenerator().generateAndSavePDF(
                      RecordData.fromJson(record.toJson()),
                    );
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text("PDF Generated!")));
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
