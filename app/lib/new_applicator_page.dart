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
  String? _name;
  String? _licenseNumber;

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
                onSaved: (value) => _name = value,
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
                onSaved: (value) => _licenseNumber = value,
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
    // AI!: invert the block to use an early return
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final applicator = Applicator(
        name: _name!,
        licenseNumber: _licenseNumber!,
      );

      final applicatorDao = ApplicatorDao();
      await applicatorDao.insert(applicator);

      Navigator.pop(context);
    }
  }
}
