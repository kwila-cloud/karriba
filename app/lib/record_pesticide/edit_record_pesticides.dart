import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:karriba/pesticide/pesticide.dart';
import 'package:karriba/pesticide/pesticide_dao.dart';
import 'package:karriba/record_pesticide/record_pesticide.dart';
import 'package:karriba/record_pesticide/record_pesticide_dao.dart';

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
  List<RecordPesticide> _selectedPesticides = [];

  @override
  void initState() {
    super.initState();
    _loadPesticides();
  }

  Future<void> _loadPesticides() async {
    List<Pesticide> pesticides = await _pesticideDao.queryAllRows();
    List<RecordPesticide> selected = await _recordPesticideDao.queryByRecordId(
      widget.recordId,
    );
    setState(() {
      _allPesticides = pesticides;
      _selectedPesticides = selected;
    });
  }

  void _addPesticides(List<Pesticide> selectedPesticides) {
    setState(() {
      for (var pesticide in selectedPesticides) {
        if (!_selectedPesticides.any((rp) => rp.pesticideId == pesticide.id)) {
          _selectedPesticides.add(
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
        List<Pesticide> selected = List.from(_allPesticides.where(
              (p) => _selectedPesticides.any((rp) => rp.pesticideId == p.id),
        ));

        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: const EdgeInsets.all(16),
              height: 400,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Select Pesticides',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _allPesticides.length,
                      itemBuilder: (context, index) {
                        final pesticide = _allPesticides[index];
                        final isSelected =
                        selected.any((p) => p.id == pesticide.id);

                        return CheckboxListTile(
                          title: Text(pesticide.name),
                          value: isSelected,
                          contentPadding: EdgeInsets.zero,
                          onChanged: (checked) {
                            setModalState(() {
                              if (checked == true) {
                                selected.add(pesticide);
                              } else {
                                selected.removeWhere((p) => p.id == pesticide.id);
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
            );
          },
        );
      },
    );
  }

  Future<void> _removePesticide(int pesticideId) async {
    await _recordPesticideDao.delete(widget.recordId, pesticideId);
    setState(() {
      _selectedPesticides.removeWhere((rp) => rp.pesticideId == pesticideId);
    });
  }

  Future<void> _saveRecord() async {
    if (_formKey.currentState!.validate()) {
      await _recordPesticideDao.saveAll(_selectedPesticides);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
    onWillPop: () async => true,
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
                  itemCount: _selectedPesticides.length,
                  itemBuilder: (context, index) {
                    final recordPesticide = _selectedPesticides[index];
                    final pesticide = _allPesticides.firstWhere(
                          (p) => p.id == recordPesticide.pesticideId,
                    );

                    return Padding(
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
                              const ['fl oz', 'oz', 'lb'].map((unit) {
                                return DropdownMenuItem(
                                  value: unit,
                                  child: Text(unit),
                                );
                              }).toList(),
                              onChanged:
                                  (unit) => recordPesticide.rateUnit = unit!,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed:
                                () => _removePesticide(
                              recordPesticide.pesticideId,
                            ),
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
}
