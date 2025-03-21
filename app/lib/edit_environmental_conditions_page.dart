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

  // Conversion factors
  static const double mphToKph = 1.60934;
  static const double kphToMph = 0.621371;
  static const double fahrenheitToCelsius = (5 / 9);
  static const double celsiusToFahrenheit = (9 / 5);

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
                initialValue: _formatWindSpeed(
                  _draftRecord.windSpeedBefore == null
                      ? null
                      : _convertKphToMph(_draftRecord.windSpeedBefore!),
                ),
                onChanged: (value) {
                  _draftRecord = _draftRecord.copyWith(
                    windSpeedBefore:
                        value.isEmpty
                            ? null
                            : _convertMphToKph(double.tryParse(value) ?? 0.0),
                  );
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
                initialValue: _formatWindSpeed(
                  _draftRecord.windSpeedAfter == null
                      ? null
                      : _convertKphToMph(_draftRecord.windSpeedAfter!),
                ),
                onChanged: (value) {
                  _draftRecord = _draftRecord.copyWith(
                    windSpeedAfter:
                        value.isEmpty
                            ? null
                            : _convertMphToKph(double.tryParse(value) ?? 0.0),
                  );
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
                  _draftRecord = _draftRecord.copyWith(windDirection: value);
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
                initialValue: _formatTemperature(
                  _draftRecord.temperature == null
                      ? null
                      : _convertCelsiusToFahrenheit(_draftRecord.temperature!),
                ),
                onChanged: (value) {
                  _draftRecord = _draftRecord.copyWith(
                    temperature:
                        value.isEmpty
                            ? null
                            : _convertFahrenheitToCelsius(
                              double.tryParse(value) ?? 0.0,
                            ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    ),
  );

  double _convertMphToKph(double mph) => mph * mphToKph;

  double _convertKphToMph(double kph) => kph * kphToMph;

  double _convertFahrenheitToCelsius(double fahrenheit) =>
      (fahrenheit - 32) * fahrenheitToCelsius;

  double _convertCelsiusToFahrenheit(double celsius) =>
      (celsius * celsiusToFahrenheit) + 32;

  Future<void> _saveRecord(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final recordsDao = RecordsDao();
    await recordsDao.save(_draftRecord);

    Navigator.pop(context);
  }
}
