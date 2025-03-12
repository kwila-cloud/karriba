import 'package:flutter/material.dart';
import 'package:karriba/customer.dart';
import 'package:karriba/customer_dao.dart';
import 'unsaved_changes_dialog.dart';

class NewCustomerPage extends StatefulWidget {
  const NewCustomerPage({super.key});

  @override
  State<NewCustomerPage> createState() => _NewCustomerPageState();
}

class _NewCustomerPageState extends State<NewCustomerPage> {
  final _formKey = GlobalKey<FormState>();
  Customer _draftCustomer = Customer(
    name: '',
    streetAddress: '',
    city: '',
    state: '',
    zipCode: '',
  );

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async => await showUnsavedChangesDialog(context),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('New Customer'),
            actions: [
              IconButton(
                icon: const Icon(Icons.save),
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
                    onSaved: (value) =>
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
                    onSaved: (value) => _draftCustomer =
                        _draftCustomer.copyWith(streetAddress: value),
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
                    onSaved: (value) =>
                        _draftCustomer = _draftCustomer.copyWith(city: value),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a city';
                      }
                      return null;
                    },
                  ),
                  Row(
                    spacing: 16,
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'State',
                            border: OutlineInputBorder(),
                          ),
                          onSaved: (value) =>
                              _draftCustomer = _draftCustomer.copyWith(state: value),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a state';
                            }
                            return null;
                          },
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Zip Code',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          onSaved: (value) =>
                              _draftCustomer = _draftCustomer.copyWith(zipCode: value),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a zip code';
                            }
                            if (value.length != 5) {
                              return 'Please enter a 5-digit zip code';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
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

    _formKey.currentState!.save();

    final customerDao = CustomerDao();
    await customerDao.insert(_draftCustomer);

    Navigator.pop(context);
  }
}
