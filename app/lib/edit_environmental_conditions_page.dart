import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:karriba/data/database.dart';
import 'package:provider/provider.dart';

import 'unsaved_changes_dialog.dart';

class EditEnvironmentalConditionsPage extends StatefulWidget {
  const EditEnvironmentalConditionsPage({super.key, required this.record});

  final RecordData record;

  @override
  State<EditEnvironmentalConditionsPage> createState() =>
      _EditEnvironmentalConditionsPageState();
}

class _EditEnvironmentalConditionsPageState
    extends State<EditEnvironmentalConditionsPage> {
  final _formKey = GlobalKey<FormState>();
  late RecordData _draftRecord;
  late RecordData _originalRecord;

  @override
  void initState() {
    _draftRecord = widget.record.copyWith();
    _originalRecord = widget.record.copyWith();
    super.initState();
  }

  bool get _hasChanges => _draftRecord != _originalRecord;

  String? _formatTemperature(double? fahrenheit) {
    if (fahrenheit == null) {
      return null;
    }
    return fahrenheit.toStringAsFixed(1);
  }

  String? _formatWindSpeed(double? mph) {
    if (mph == null) {
      return null;
    }
    return mph.toStringAsFixed(1);
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
    onWillPop:
        () async =>
            _hasChanges ? await showUnsavedChangesDialog(context) : true,
    child: Scaffold(
      appBar: AppBar(
        title: const Text('Environmental Conditions'),
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
            spacing: 16,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Wind Speed Before Application (mph)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
                ],
                initialValue: _formatWindSpeed(_draftRecord.windSpeedBefore),
                onChanged: (value) {
                  setState(() {
                    _draftRecord = _draftRecord.copyWith(
                      windSpeedBefore: Value(double.tryParse(value)),
                    );
                  });
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Wind Speed After Application (mph)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
                ],
                initialValue: _formatWindSpeed(_draftRecord.windSpeedAfter),
                onChanged: (value) {
                  setState(() {
                    _draftRecord = _draftRecord.copyWith(
                      windSpeedAfter: Value(double.tryParse(value)),
                    );
                  });
                },
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Wind Direction',
                  border: OutlineInputBorder(),
                ),
                value: _draftRecord.windDirection,
                items:
                    const ['N', 'NE', 'E', 'SE', 'S', 'SW', 'W', 'NW']
                        .map(
                          (direction) => DropdownMenuItem(
                            value: direction,
                            child: Text(direction),
                          ),
                        )
                        .toList(),
                onChanged: (value) {
                  setState(() {
                    _draftRecord = _draftRecord.copyWith(
                      windDirection: Value(value),
                    );
                  });
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Temperature (°F)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
                ],
                initialValue: _formatTemperature(_draftRecord.temperature),
                onChanged: (value) {
                  setState(() {
                    _draftRecord = _draftRecord.copyWith(
                      temperature: Value(double.tryParse(value)),
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

    AppDatabase db = Provider.of<AppDatabase>(context);

    await (db.update(db.record)
      ..where((r) => r.id.equals(_draftRecord.id))).write(_draftRecord);

    Navigator.pop(context);
  }
}
