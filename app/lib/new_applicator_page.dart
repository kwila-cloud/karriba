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
  final _nameController = TextEditingController();
  final _licenseNumberController = TextEditingController();

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
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _licenseNumberController,
                    decoration: const InputDecoration(
                      labelText: 'License Number',
                      border: OutlineInputBorder(),
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

  @override
  void dispose() {
    _nameController.dispose();
    _licenseNumberController.dispose();
    super.dispose();
  }

  Future<void> _saveApplicator(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final applicator = Applicator(
      name: _nameController.text,
      licenseNumber: _licenseNumberController.text,
    );

    final applicatorDao = ApplicatorDao();
    await applicatorDao.insert(applicator);

    Navigator.pop(context);
  }
}
