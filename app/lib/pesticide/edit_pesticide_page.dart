import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:karriba/pesticide/pesticide.dart';
import 'package:karriba/pesticide/pesticide_dao.dart';
import 'package:karriba/unsaved_changes_dialog.dart';

class EditPesticidePage extends StatefulWidget {
  const EditPesticidePage({super.key, this.pesticide});

  final Pesticide? pesticide;

  @override
  State<EditPesticidePage> createState() => _EditPesticidePageState();
}

class _EditPesticidePageState extends State<EditPesticidePage> {
  final _formKey = GlobalKey<FormState>();
  late Pesticide _draftPesticide;
  late Pesticide _originalPesticide;
  late String _title;

  @override
  void initState() {
    _draftPesticide =
        widget.pesticide ?? Pesticide(name: '', registrationNumber: '');
    _originalPesticide = _draftPesticide.copyWith();
    _title = widget.pesticide == null ? 'New Pesticide' : 'Edit Pesticide';
    super.initState();
  }

  bool get _hasChanges => _draftPesticide != _originalPesticide;

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
            onPressed: () => _savePesticide(context),
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
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                initialValue: _draftPesticide.name,
                onChanged:
                    (value) =>
                        _draftPesticide = _draftPesticide.copyWith(name: value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Registration Number',
                  border: OutlineInputBorder(),
                ),
                initialValue: _draftPesticide.registrationNumber,
                onChanged:
                    (value) =>
                        _draftPesticide = _draftPesticide.copyWith(
                          registrationNumber: value,
                        ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a registration number';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    ),
  );

  Future<void> _savePesticide(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final pesticideDao = PesticideDao();
    await pesticideDao.save(_draftPesticide);

    Navigator.pop(context);
  }
}
