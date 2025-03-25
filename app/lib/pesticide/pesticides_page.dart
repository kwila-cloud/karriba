import 'package:flutter/material.dart';
import 'package:karriba/pesticide/edit_pesticide_page.dart';
import 'package:karriba/top_level_page.dart';

import 'pesticide.dart';
import 'pesticide_dao.dart';

class PesticidesPage extends StatefulWidget {
  const PesticidesPage({super.key});

  @override
  State<PesticidesPage> createState() => _PesticidesPageState();
}

class _PesticidesPageState extends State<PesticidesPage> {
  late Future<List<Pesticide>> _pesticidesFuture;

  final _pesticideDao = PesticideDao();

  @override
  void initState() {
    super.initState();
    _refreshPesticides();
  }

  _refreshPesticides() {
    setState(() {
      _pesticidesFuture = _pesticideDao.queryAllRows();
    });
  }

  @override
  Widget build(BuildContext context) {
    return TopLevelPage(
      appBar: AppBar(title: Text("Pesticides")),
      body: FutureBuilder<List<Pesticide>>(
        future: _pesticidesFuture,
        builder: (context, snapshot) {
          final pesticides = snapshot.data;
          if (pesticides != null) {
            return ListView.builder(
              itemCount: pesticides.length,
              itemBuilder:
                  (context, index) => PesticideTile(
                    pesticide: pesticides[index],
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => EditPesticidePage(
                                pesticide: pesticides[index],
                              ),
                        ),
                      );
                      // Refresh the list after editing an pesticide
                      _refreshPesticides();
                    },
                  ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      onAddPressed: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const EditPesticidePage()),
        );
        // Refresh the list after adding a new pesticide
        _refreshPesticides();
      },
    );
  }
}

class PesticideTile extends StatelessWidget {
  const PesticideTile({super.key, required this.pesticide, this.onTap});

  final Pesticide pesticide;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(pesticide.name),
      subtitle: Text(pesticide.registrationNumber),
      onTap: onTap,
    );
  }
}
