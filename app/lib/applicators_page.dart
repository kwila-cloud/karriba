import 'package:flutter/material.dart';
import 'top_level_page.dart';
import 'new_applicator_page.dart';
import 'database_helper.dart';

class ApplicatorsPage extends StatefulWidget {
  const ApplicatorsPage({super.key});

  @override
  State<ApplicatorsPage> createState() => _ApplicatorsPageState();
}

class _ApplicatorsPageState extends State<ApplicatorsPage> {
  late Future<List<Map<String, dynamic>>> _applicatorsFuture;

  @override
  void initState() {
    super.initState();
    _applicatorsFuture = _queryApplicators();
  }

  Future<List<Map<String, dynamic>>> _queryApplicators() async {
    final dbHelper = DatabaseHelper.instance;
    return await dbHelper.queryAllRows();
  }

  @override
  Widget build(BuildContext context) {
    return TopLevelPage(
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _applicatorsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final applicators = snapshot.data!;
            return ListView.builder(
              itemCount: applicators.length,
              itemBuilder: (context, index) {
                final applicator = applicators[index];
                return Card(
                  child: ListTile(
                    title: Text(applicator[DatabaseHelper.columnName]),
                    subtitle:
                        Text(applicator[DatabaseHelper.columnLicenseNumber]),
                  ),
                );
              },
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
          MaterialPageRoute(builder: (context) => const NewApplicatorPage()),
        );
        // Refresh the list after adding a new applicator
        setState(() {
          _applicatorsFuture = _queryApplicators();
        });
      },
    );
  }
}
