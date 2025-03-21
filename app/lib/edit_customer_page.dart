import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:karriba/customer.dart';
import 'package:karriba/customer_dao.dart';
import 'unsaved_changes_dialog.dart';

class EditCustomerPage extends StatefulWidget {
  const EditCustomerPage({super.key, this.customer});

  final Customer? customer;

  @override
  State<EditCustomerPage> createState() => _EditCustomerPageState();
}

class _EditCustomerPageState extends State<EditCustomerPage> {
  final _formKey = GlobalKey<FormState>();
  late Customer _draftCustomer;
  late Customer _originalCustomer;
  late String _title;

  @override
  void initState() {
    _draftCustomer =
        widget.customer ??
        Customer(name: '', streetAddress: '', city: '', state: '', zipCode: '');
    _originalCustomer = _draftCustomer.copyWith();
    _title = widget.customer == null ? 'New Customer' : 'Edit Customer';
    super.initState();
  }

  bool get _hasChanges => _draftCustomer != _originalCustomer;

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
            onPressed: () => _saveCustomer(context),
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
                initialValue: _draftCustomer.name,
                onChanged:
                    (value) =>
                        _draftCustomer = _draftCustomer.copyWith(name: value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Street Address',
                  border: OutlineInputBorder(),
                ),
                initialValue: _draftCustomer.streetAddress,
                onChanged:
                    (value) =>
                        _draftCustomer = _draftCustomer.copyWith(
                          streetAddress: value,
                        ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a street address';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'City',
                  border: OutlineInputBorder(),
                ),
                initialValue: _draftCustomer.city,
                onChanged:
                    (value) =>
                        _draftCustomer = _draftCustomer.copyWith(city: value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a city';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'State',
                  border: OutlineInputBorder(),
                ),
                initialValue: _draftCustomer.state,
                onChanged:
                    (value) =>
                        _draftCustomer = _draftCustomer.copyWith(state: value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a state';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Zip Code',
                  border: OutlineInputBorder(),
                ),
                initialValue: _draftCustomer.zipCode,
                keyboardType: TextInputType.number,
                onChanged:
                    (value) =>
                        _draftCustomer = _draftCustomer.copyWith(
                          zipCode: value,
                        ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a zip code';
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

  Future<void> _saveCustomer(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final customerDao = CustomerDao();
    await customerDao.save(_draftCustomer);

    Navigator.pop(context);
  }
}
