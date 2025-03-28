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

  late DateTime _selectedDate;
  late TimeOfDay _selectedStartTime;
  late TimeOfDay _selectedEndTime;

  @override
  void initState() {
    if (widget.record != null) {
      _selectedDate = widget.record!.startTimestamp;
      _selectedStartTime = TimeOfDay.fromDateTime(widget.record!.startTimestamp);
      _selectedEndTime = TimeOfDay.fromDateTime(widget.record!.endTimestamp);
    } else {
      final now = DateTime.now();
      _selectedDate = DateTime(now.year, now.month, now.day);
      _selectedStartTime = TimeOfDay.fromDateTime(DateTime.now());
      _selectedEndTime = TimeOfDay.fromDateTime(DateTime.now());
    }

    _draftRecord =
        widget.record ??
        Record(
          startTimestamp: DateTime(
            _selectedDate.year,
            _selectedDate.month,
            _selectedDate.day,
            _selectedStartTime.hour,
            _selectedStartTime.minute,
          ),
          endTimestamp: DateTime(
            _selectedDate.year,
            _selectedDate.month,
            _selectedDate.day,
            _selectedEndTime.hour,
            _selectedEndTime.minute,
          ),
          customerId: 0,
          applicatorId: 0,
          customerInformedOfRei: false,
          fieldName: '',
          crop: '',
          totalArea: 0,
          pricePerAcre: 0,
          sprayVolume: 0,
          notes: '',
        );
    _originalRecord = _draftRecord.copyWith();
    _title = widget.record == null ? 'New Record' : 'Edit Record';
    _loadDataDependenciesFuture = Future.wait([
      ApplicatorDao().queryAllRows(),
      CustomerDao().queryAllRows(),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<dynamic>>(
          future: _loadDataDependenciesFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final applicators = snapshot.data![0] as List<Applicator>;
              int? selectedApplicatorId = _draftRecord.applicatorId;
              if (!applicators.any((a) => a.id == selectedApplicatorId)) {
                selectedApplicatorId = null;
              }

              final customers = snapshot.data![1] as List<Customer>;
              int? selectedCustomerId = _draftRecord.customerId;
              if (!customers.any((c) => c.id == selectedCustomerId)) {
                selectedCustomerId = null;
              }

              bool customerInformedOfRei = _draftRecord.customerInformedOfRei;

              return Form(
                key: _formKey,
                child: Column(
                  spacing: 16,
                  children: [
                    Row(
                      children: [
                        Text('Date:'),
                        SizedBox(width: 16),
                        ElevatedButton(
                          onPressed: () async {
                            final DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: _selectedDate,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );
                            if (pickedDate != null &&
                                pickedDate != _selectedDate) {
                              setState(() {
                                _selectedDate = pickedDate;
                                _draftRecord = _draftRecord.copyWith(
                                  startTimestamp: DateTime(
                                    _selectedDate.year,
                                    _selectedDate.month,
                                    _selectedDate.day,
                                    _selectedStartTime.hour,
                                    _selectedStartTime.minute,
                                  ),
                                  endTimestamp: DateTime(
                                    _selectedDate.year,
                                    _selectedDate.month,
                                    _selectedDate.day,
                                    _selectedEndTime.hour,
                                    _selectedEndTime.minute,
                                  ),
                                );
                              });
                            }
                          },
                          child: Text(
                            '${_selectedDate.toLocal()}'.split(' ')[0],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Start Time:'),
                        SizedBox(width: 16),
                        ElevatedButton(
                          onPressed: () async {
                            final TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: _selectedStartTime,
                            );
                            if (pickedTime != null &&
                                pickedTime != _selectedStartTime) {
                              setState(() {
                                _selectedStartTime = pickedTime;
                                _draftRecord = _draftRecord.copyWith(
                                  startTimestamp: DateTime(
                                    _selectedDate.year,
                                    _selectedDate.month,
                                    _selectedDate.day,
                                    _selectedStartTime.hour,
                                    _selectedStartTime.minute,
                                  ),
                                );
                              });
                            }
                          },
                          child: Text(_selectedStartTime.format(context)),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text('End Time:'),
                        SizedBox(width: 16),
                        ElevatedButton(
                          onPressed: () async {
                            final TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: _selectedEndTime,
                            );
                            if (pickedTime != null &&
                                pickedTime != _selectedEndTime) {
                              setState(() {
                                _selectedEndTime = pickedTime;
                                _draftRecord = _draftRecord.copyWith(
                                  endTimestamp: DateTime(
                                    _selectedDate.year,
                                    _selectedDate.month,
                                    _selectedDate.day,
                                    _selectedEndTime.hour,
                                    _selectedEndTime.minute,
                                  ),
                                );
                              });
                            }
                          },
                          child: Text(_selectedEndTime.format(context)),
                        ),
                      ],
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
                        if (value == null) {
                          return;
                        }
                        setState(() {
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
                        if (value == null) {
                          return;
                        }
                        setState(() {
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
                    CheckboxListTile(
                      title: const Text('Customer Informed of REI'),
                      subtitle: const Text(
                        'The customer must be notified of the Restricted-Entry Interval.',
                      ),
                      value: customerInformedOfRei,
                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }
                        setState(() {
                          _draftRecord = _draftRecord.copyWith(
                            customerInformedOfRei: value,
                          );
                        });
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Field Name',
                        border: OutlineInputBorder(),
                      ),
                      initialValue: _draftRecord.fieldName,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a field name';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _draftRecord = _draftRecord.copyWith(
                            fieldName: value,
                          );
                        });
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Crop',
                        border: OutlineInputBorder(),
                      ),
                      initialValue: _draftRecord.crop,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a crop';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _draftRecord = _draftRecord.copyWith(crop: value);
                        });
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Total Area',
                        border: OutlineInputBorder(),
                      ),
                      initialValue: _draftRecord.totalArea.toString(),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the total area';
                        }
                        final number = num.tryParse(value);
                        if (number == null) {
                          return 'Please enter a valid number';
                        }
                        if (number.isNegative) {
                          return 'Please enter a non-negative number';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _draftRecord = _draftRecord.copyWith(
                            totalArea: double.tryParse(value) ?? 0,
                          );
                        });
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Price per Acre',
                        border: OutlineInputBorder(),
                      ),
                      initialValue: _draftRecord.pricePerAcre.toString(),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the price per acre';
                        }
                        final number = num.tryParse(value);
                        if (number == null) {
                          return 'Please enter a valid number';
                        }
                        if (number.isNegative) {
                          return 'Please enter a non-negative number';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _draftRecord = _draftRecord.copyWith(
                            pricePerAcre: double.tryParse(value) ?? 0,
                          );
                        });
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Spray Volume (GPA)',
                        border: OutlineInputBorder(),
                      ),
                      initialValue: _draftRecord.sprayVolume.toString(),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the spray volume';
                        }
                        final number = num.tryParse(value);
                        if (number == null) {
                          return 'Please enter a valid number';
                        }
                        if (number.isNegative) {
                          return 'Please enter a non-negative number';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _draftRecord = _draftRecord.copyWith(
                            sprayVolume: double.tryParse(value) ?? 0,
                          );
                        });
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Notes',
                        border: OutlineInputBorder(),
                        alignLabelWithHint: true,
                      ),
                      initialValue: _draftRecord.notes,
                      maxLines: 5,
                      onChanged: (value) {
                        setState(() {
                          _draftRecord = _draftRecord.copyWith(notes: value);
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
