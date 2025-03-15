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
  // AI!: combine these into one _loadDataDependenciesFuture
  late Future<List<Customer>> _customersFuture;
  late Future<List<Applicator>> _applicatorsFuture;
  int? _selectedCustomerId;
  int? _selectedApplicatorId;
  bool _customerInformedOfRei = false;

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
    _customersFuture = CustomerDao().queryAllRows();
    _applicatorsFuture = ApplicatorDao().queryAllRows();
    _selectedCustomerId = _draftRecord.customerId;
    _selectedApplicatorId = _draftRecord.applicatorId;
    _customerInformedOfRei = _draftRecord.customerInformedOfRei;
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
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 16,
            children: [
              FutureBuilder<List<Customer>>(
                future: _customersFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final customers = snapshot.data!;
                    return DropdownButtonFormField<int>(
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
                      onChanged: (value) {
                        setState(() {
                          _selectedCustomerId = value;
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
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
              FutureBuilder<List<Applicator>>(
                future: _applicatorsFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final applicators = snapshot.data!;
                    return DropdownButtonFormField<int>(
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
                      onChanged: (value) {
                        setState(() {
                          _selectedApplicatorId = value;
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
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
              CheckboxListTile(
                title: const Text('Customer Informed of REI'),
                value: _customerInformedOfRei,
                onChanged: (value) {
                  setState(() {
                    _customerInformedOfRei = value!;
                    _draftRecord = _draftRecord.copyWith(
                      customerInformedOfRei: value,
                    );
                  });
                },
              ),
            ],
          ),
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
