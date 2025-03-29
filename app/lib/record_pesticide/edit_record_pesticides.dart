import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:karriba/pesticide/pesticide.dart';
import 'package:karriba/pesticide/pesticide_dao.dart';
import 'package:karriba/record_pesticide/record_pesticide.dart';
import 'package:karriba/record_pesticide/record_pesticide_dao.dart';
import 'package:karriba/unsaved_changes_dialog.dart';

class EditRecordPesticidesPage extends StatefulWidget {
  const EditRecordPesticidesPage({super.key, required this.recordId});

  final int recordId;

  @override
  State<EditRecordPesticidesPage> createState() =>
      _EditRecordPesticidesPageState();
}

class _EditRecordPesticidesPageState extends State<EditRecordPesticidesPage> {
  final _formKey = GlobalKey<FormState>();
  final PesticideDao _pesticideDao = PesticideDao();
  final RecordPesticideDao _recordPesticideDao = RecordPesticideDao();

  List<Pesticide> _allPesticides = [];
  List<RecordPesticide> _draftSelectedPesticides = [];
  List<RecordPesticide> _originalSelectedPesticides = [];

  bool get _hasChanges =>
      !listEquals(_draftSelectedPesticides, _originalSelectedPesticides);

  @override
  void initState() {
    super.initState();
    _loadPesticides();
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
    onWillPop:
        () async =>
            _hasChanges ? await showUnsavedChangesDialog(context) : true,
    child: Scaffold(
      appBar: AppBar(
        title: const Text('Edit Pesticides'),
        actions: [
          IconButton(
            icon: const Iconify(Mdi.content_save),
            onPressed: _saveRecord,
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
              Expanded(
                child: ListView.builder(
                  itemCount: _draftSelectedPesticides.length,
                  itemBuilder: (context, index) {
                    final recordPesticide = _draftSelectedPesticides[index];
                    final pesticide = _allPesticides.firstWhere(
                      (p) => p.id == recordPesticide.pesticideId,
                    );
                    return Padding(
                      // this key is required to make sure the form inputs
                      // don't get corrupted after the user removes a pesticide
                      key: Key(pesticide.id.toString()),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              pesticide.name,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Rate',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d*$'),
                                ),
                              ],
                              initialValue: recordPesticide.rate.toString(),
                              onChanged:
                                  (value) =>
                                      recordPesticide.rate =
                                          double.tryParse(value) ?? 0.0,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 2,
                            child: DropdownButtonFormField<String>(
                              value: recordPesticide.rateUnit,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              items:
                                  const ['fl oz', 'oz', 'lb']
                                      .map(
                                        (unit) => DropdownMenuItem(
                                          value: unit,
                                          child: Text(unit),
                                        ),
                                      )
                                      .toList(),
                              onChanged:
                                  (unit) => recordPesticide.rateUnit = unit!,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                _draftSelectedPesticides.removeWhere(
                                  (rp) => rp.pesticideId == pesticide.id,
                                );
                              });
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showPesticideSelectionSheet,
        child: const Icon(Icons.add),
      ),
    ),
  );

  Future<void> _loadPesticides() async {
    List<Pesticide> pesticides = await _pesticideDao.queryAllRows();
    List<RecordPesticide> selected = await _recordPesticideDao.queryByRecordId(
      widget.recordId,
    );
    setState(() {
      _allPesticides = pesticides;
      _draftSelectedPesticides = selected;
      // Do a deep copy
      _originalSelectedPesticides = selected.map((p) => p.copyWith()).toList();
    });
  }

  void _addPesticides(List<Pesticide> selectedPesticides) {
    setState(() {
      for (var pesticide in selectedPesticides) {
        if (!_draftSelectedPesticides.any(
          (rp) => rp.pesticideId == pesticide.id,
        )) {
          _draftSelectedPesticides.add(
            RecordPesticide(
              recordId: widget.recordId,
              pesticideId: pesticide.id ?? 0,
              rate: 0.0,
              rateUnit: 'fl oz',
            ),
          );
        }
      }
    });
  }

  void _showPesticideSelectionSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        List<Pesticide> options =
            _allPesticides
                .where(
                  (p) =>
                      !_draftSelectedPesticides.any(
                        (rp) => rp.pesticideId == p.id,
                      ),
                )
                .toList();
        List<Pesticide> selected = [];
        return StatefulBuilder(
          builder:
              (context, setModalState) => Container(
                padding: const EdgeInsets.all(16),
                height: 400,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Select Pesticides',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: options.length,
                        itemBuilder: (context, index) {
                          final pesticide = options[index];
                          final isSelected = selected.any(
                            (p) => p.id == pesticide.id,
                          );

                          return CheckboxListTile(
                            title: Text(pesticide.name),
                            value: isSelected,
                            contentPadding: EdgeInsets.zero,
                            onChanged: (checked) {
                              setModalState(() {
                                if (checked == true) {
                                  selected.add(pesticide);
                                } else {
                                  selected.removeWhere(
                                    (p) => p.id == pesticide.id,
                                  );
                                }
                              });
                            },
                          );
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          _addPesticides(selected);
                          Navigator.pop(context);
                        },
                        child: const Text('Confirm'),
                      ),
                    ),
                  ],
                ),
              ),
        );
      },
    );
  }

  Future<void> _saveRecord() async {
    if (_formKey.currentState!.validate()) {
      await _recordPesticideDao.saveAll(_draftSelectedPesticides);
      Iterable<int> originalSelectedPesticideIds = _originalSelectedPesticides
          .map((p) => p.pesticideId);
      Iterable<int> draftSelectedPesticideIds = _draftSelectedPesticides.map(
        (p) => p.pesticideId,
      );
      Iterable<int> removedPesticideIds = originalSelectedPesticideIds.where(
        (id) => !draftSelectedPesticideIds.contains(id),
      );
      for (int pesticideId in removedPesticideIds) {
        await _recordPesticideDao.delete(widget.recordId, pesticideId);
      }
      Navigator.pop(context);
    }
  }
}
