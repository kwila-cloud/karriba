import 'package:flutter/material.dart';
import 'package:karriba/applicator.dart';
import 'package:karriba/applicator_dao.dart';
import 'package:karriba/unsaved_changes_dialog.dart';

class NewApplicatorPage extends StatefulWidget {
  const NewApplicatorPage({super.key});

  @override
  State<NewApplicatorPage> createState() => _NewApplicatorPageState();
}

class _NewApplicatorPageState extends State<NewApplicatorPage> {
  final _formKey = GlobalKey<FormState>();
  Applicator _draftApplicator = Applicator(name: '', licenseNumber: '');

  @override
  Widget build(BuildContext context) => WillPopScope(
    onWillPop: () async => await showUnsavedChangesDialog(context),
    child: Scaffold(
      appBar: AppBar(
        title: const Text('New Applicator'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
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
                onSaved:
                    (value) =>
                        _draftApplicator = Applicator(
                          name: value!,
                          licenseNumber: _draftApplicator.licenseNumber,
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
                onSaved:
                    (value) =>
                        _draftApplicator = Applicator(
                          name: _draftApplicator.name,
                          licenseNumber: value!,
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

    final applicator = Applicator(
      name: _draftApplicator.name,
      licenseNumber: _draftApplicator.licenseNumber,
    );

    final applicatorDao = ApplicatorDao();
    await applicatorDao.insert(applicator);

    Navigator.pop(context);
  }
}
