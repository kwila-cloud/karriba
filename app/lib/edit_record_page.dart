import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:karriba/record.dart';
import 'package:karriba/records_dao.dart';
import 'package:karriba/customer.dart';
import 'package:karriba/customer_dao.dart';
import 'package:karriba/applicator.dart';
import 'package:karriba/applicator_dao.dart';
import 'unsaved_changes_dialog.dart';

class EditRecordPage extends StatefulWidget {
  const EditRecordPage({super.key, this.record});

  final Record? record;

  @override
  State<EditRecordPage> createState() => _EditRecordPageState();
}

class _EditRecordPageState extends State<EditRecordPage> {
  final _formKey = GlobalKey<FormState>();
  late Record _draftRecord;
  late Record _originalRecord;
  late String _title;
  late Future<List<dynamic>> _loadDataDependenciesFuture;

  @override
  void initState() {
    _draftRecord =
        widget.record ??
        Record(
          timestamp: DateTime.now(),
          customerId: 0,
          applicatorId: 0,
          customerInformedOfRei: false,
        );
    _originalRecord = _draftRecord.copyWith();
    _title = widget.record == null ? 'New Record' : 'Edit Record';
    _loadDataDependenciesFuture = Future.wait([
      CustomerDao().queryAllRows(),
      ApplicatorDao().queryAllRows(),
    ]);
    super.initState();
  }

  bool get _hasChanges => _draftRecord != _originalRecord;

  @override
  Widget build(BuildContext context) => WillPopScope(
    onWillPop:
        () async =>
            _hasChanges ? await showUnsavedChangesDialog(context) : true,
    child: Scaffold(
      appBar: AppBar(
        title: Text(_title),
        actions: [
          IconButton(
            icon: Iconify(Mdi.content_save),
            onPressed: () => _saveRecord(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<dynamic>>(
          future: _loadDataDependenciesFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final customers = snapshot.data![0] as List<Customer>;
              final applicators = snapshot.data![1] as List<Applicator>;
              int? selectedCustomerId = _draftRecord.customerId;
              int? selectedApplicatorId = _draftRecord.applicatorId;
              bool customerInformedOfRei = _draftRecord.customerInformedOfRei;
              return Form(
                key: _formKey,
                child: Column(
                  spacing: 16,
                  children: [
                    DropdownButtonFormField<int>(
                      decoration: const InputDecoration(
                        labelText: 'Customer',
                        border: OutlineInputBorder(),
                      ),
                      items:
                          customers.map((customer) {
                            return DropdownMenuItem<int>(
                              value: customer.id,
                              child: Text(customer.name),
                            );
                          }).toList(),
                      value: selectedCustomerId,
                      onChanged: (value) {
                        setState(() {
                          selectedCustomerId = value;
                          _draftRecord = _draftRecord.copyWith(
                            customerId: value,
                          );
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a customer';
                        }
                        return null;
                      },
                    ),
                    DropdownButtonFormField<int>(
                      decoration: const InputDecoration(
                        labelText: 'Applicator',
                        border: OutlineInputBorder(),
                      ),
                      items:
                          applicators.map((applicator) {
                            return DropdownMenuItem<int>(
                              value: applicator.id,
                              child: Text(applicator.name),
                            );
                          }).toList(),
                      value: selectedApplicatorId,
                      onChanged: (value) {
                        setState(() {
                          selectedApplicatorId = value;
                          _draftRecord = _draftRecord.copyWith(
                            applicatorId: value,
                          );
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select an applicator';
                        }
                        return null;
                      },
                    ),
                    CheckboxListTile(
                      title: const Text('Customer Informed of REI'),
                      value: customerInformedOfRei,
                      onChanged: (value) {
                        setState(() {
                          customerInformedOfRei = value!;
                          _draftRecord = _draftRecord.copyWith(
                            customerInformedOfRei: value,
                          );
                        });
                      },
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    ),
  );

  Future<void> _saveRecord(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final recordsDao = RecordsDao();
    await recordsDao.save(_draftRecord);

    Navigator.pop(context);
  }
}
