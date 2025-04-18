import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:intl/intl.dart';
import 'package:karriba/record_pesticide/edit_record_pesticides.dart';

import '../edit_environmental_conditions_page.dart';
import 'edit_record_page.dart';
import '../pdf_generator.dart';
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

  final Set<int> _selectedRecordIds = {};

  bool get _isSelecting => _selectedRecordIds.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  @override
  void initState() {
    super.initState();
    _refreshRecords();
  }

  void _refreshRecords() {
    setState(() {
      _recordsFuture = _recordsDao.queryAllRows();
      _selectedRecordIds.clear();
    });
  }

  void _onRecordLongPress(Record record) {
    setState(() {
      _selectedRecordIds.add(record.id!);
    });
  }

  void _onRecordTap(Record record) {
    if (_isSelecting) {
      setState(() {
        if (_selectedRecordIds.contains(record.id)) {
          _selectedRecordIds.remove(record.id);
        } else {
          _selectedRecordIds.add(record.id!);
        }
      });
    } else {
      _showRecordActions(record);
    }
  }

  void _showRecordActions(Record record) {
    String customerName = record.customerName ?? "Unknown Customer";
    String titleString = "$customerName - ${record.fieldName}";
    String subtitleString = record.applicatorName ?? "Unknown Applicator";
    String dateString = DateFormat.Md().format(record.startTimestamp);

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
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditRecordPage(record: record),
                  ),
                );
                _refreshRecords();
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
                        (context) =>
                            EditEnvironmentalConditionsPage(record: record),
                  ),
                );
                _refreshRecords();
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
                            EditRecordPesticidesPage(recordId: record.id!),
                  ),
                );
                _refreshRecords();
              },
            ),
            ListTile(
              leading: Iconify(Mdi.file_pdf),
              title: const Text('Generate PDF'),
              onTap: () async {
                Navigator.pop(context);
                await PDFGenerator().generateAndSavePDF(record);
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text("PDF Generated!")));
              },
            ),
          ],
        );
      },
    );
  }

  void _exitSelection() {
    setState(() {
      _selectedRecordIds.clear();
    });
  }

  void _confirmDelete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Delete Records"),
            content: Text(
              "Are you sure you want to delete ${_selectedRecordIds.length} record(s)?",
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text("Cancel"),
              ),
              TextButton(
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                onPressed: () => Navigator.pop(context, true),
                child: const Text("Delete"),
              ),
            ],
          ),
    );

    if (confirmed == true) {
      await _recordsDao.deleteMultiple(_selectedRecordIds.toList());
      _refreshRecords();
    }
  }

  PreferredSizeWidget? _buildAppBar() {
    AppBar appBar = AppBar(title: Text('Records'));
    if (_isSelecting) {
      appBar = AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: _exitSelection,
        ),
        title: Text("${_selectedRecordIds.length} selected"),
        actions: [
          IconButton(icon: const Icon(Icons.delete), onPressed: _confirmDelete),
        ],
      );
    }
    return appBar;
  }

  Widget _buildBody() {
    return FutureBuilder<List<Record>>(
      future: _recordsFuture,
      builder: (context, snapshot) {
        final records = snapshot.data;
        if (records != null) {
          return ListView.builder(
            itemCount: records.length,
            itemBuilder: (context, index) {
              final record = records[index];
              return RecordTile(
                record: record,
                refresh: _refreshRecords,
                isSelected: _selectedRecordIds.contains(record.id),
                onTap: () => _onRecordTap(record),
                onLongPress: () => _onRecordLongPress(record),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget? _buildFloatingActionButton() {
    if (_isSelecting) return null;

    return FloatingActionButton(
      onPressed: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const EditRecordPage()),
        );
        _refreshRecords();
      },
      child: const Icon(Icons.add),
    );
  }
}

class RecordTile extends StatelessWidget {
  const RecordTile({
    super.key,
    required this.record,
    required this.refresh,
    this.isSelected = false,
    this.onTap,
    this.onLongPress,
  });

  final Record record;
  final VoidCallback refresh;
  final bool isSelected;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    String customerName = record.customerName ?? "Unknown Customer";
    String titleString = "$customerName - ${record.fieldName}";
    String subtitleString = record.applicatorName ?? "Unknown Applicator";
    String dateString = DateFormat.Md().format(record.startTimestamp);

    return ListTile(
      title: Text(titleString),
      subtitle: Text(subtitleString),
      trailing: isSelected ? const Icon(Icons.check_box) : Text(dateString),
      tileColor: isSelected ? Colors.grey[300] : null,
      onTap: onTap,
      onLongPress: onLongPress,
    );
  }
}
