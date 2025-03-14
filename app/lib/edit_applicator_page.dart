import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:karriba/applicator.dart';
import 'package:karriba/applicator_dao.dart';
import 'unsaved_changes_dialog.dart';

class EditApplicatorPage extends StatefulWidget {
  const EditApplicatorPage({super.key, this.applicator});

  final Applicator? applicator;

  @override
  State<EditApplicatorPage> createState() => _EditApplicatorPageState();
}

class _EditApplicatorPageState extends State<EditApplicatorPage> {
  final _formKey = GlobalKey<FormState>();
  late Applicator _draftApplicator;
  late String _title;

  @override
  void initState() {
    _draftApplicator =
        widget.applicator ?? Applicator(name: '', licenseNumber: '');
    _title = widget.applicator == null ? 'New Applicator' : 'Edit Applicator';
    super.initState();
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
    onWillPop: () async => await showUnsavedChangesDialog(context),
    child: Scaffold(
      appBar: AppBar(
        title: Text(_title),
        actions: [
          IconButton(
            icon: Iconify(Mdi.content_save),
            onPressed: () => _saveApplicator(context),
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
                initialValue: _draftApplicator.name,
                onSaved:
                    (value) =>
                        _draftApplicator = _draftApplicator.copyWith(
                          name: value,
                        ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'License Number',
                  border: OutlineInputBorder(),
                ),
                initialValue: _draftApplicator.licenseNumber,
                onSaved:
                    (value) =>
                        _draftApplicator = _draftApplicator.copyWith(
                          licenseNumber: value,
                        ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a license number';
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

  Future<void> _saveApplicator(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    final applicatorDao = ApplicatorDao();
    await applicatorDao.save(_draftApplicator);

    Navigator.pop(context);
  }
}
