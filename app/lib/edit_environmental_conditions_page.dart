import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';

import 'record.dart';
import 'records_dao.dart';
import 'unsaved_changes_dialog.dart';

class EditEnvironmentalConditionsPage extends StatefulWidget {
  const EditEnvironmentalConditionsPage({super.key, required this.record});

  final Record record;

  @override
  State<EditEnvironmentalConditionsPage> createState() =>
      _EditEnvironmentalConditionsPageState();
}

class _EditEnvironmentalConditionsPageState
    extends State<EditEnvironmentalConditionsPage> {
  final _formKey = GlobalKey<FormState>();
  late Record _draftRecord;
  late Record _originalRecord;

  @override
  void initState() {
    _draftRecord = widget.record.copyWith();
    _originalRecord = widget.record.copyWith();
    super.initState();
  }

  bool get _hasChanges => _draftRecord != _originalRecord;

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async =>
            _hasChanges ? await showUnsavedChangesDialog(context) : true,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Edit Environmental Conditions'),
            actions: [
              IconButton(
                icon: const Iconify(Mdi.content_save),
                onPressed: () => _saveRecord(context),
              ),
            ],
          ),
          body: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Wind Speed Before Application (mph)',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d*$')),
                    ],
                    initialValue: _draftRecord.windSpeedBefore?.toString(),
                    onChanged: (value) {
                      _draftRecord = _draftRecord.copyWith(
                        windSpeedBefore: double.tryParse(value),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Wind Speed After Application (mph)',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d*$')),
                    ],
                    initialValue: _draftRecord.windSpeedAfter?.toString(),
                    onChanged: (value) {
                      _draftRecord = _draftRecord.copyWith(
                        windSpeedAfter: double.tryParse(value),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Wind Direction',
                      border: OutlineInputBorder(),
                    ),
                    initialValue: _draftRecord.windDirection,
                    onChanged: (value) {
                      _draftRecord = _draftRecord.copyWith(
                        windDirection: value,
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Temperature (°F)',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d*$')),
                    ],
                    initialValue: _draftRecord.temperature?.toString(),
                    onChanged: (value) {
                      _draftRecord = _draftRecord.copyWith(
                        temperature: double.tryParse(value),
                      );
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
