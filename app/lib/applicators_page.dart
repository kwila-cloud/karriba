import 'package:flutter/material.dart';
import 'top_level_page.dart';
import 'new_applicator_page.dart';
import 'package:karriba/applicator.dart';
import 'applicator_dao.dart';

class ApplicatorsPage extends StatefulWidget {
  const ApplicatorsPage({super.key});

  @override
  State<ApplicatorsPage> createState() => _ApplicatorsPageState();
}

class _ApplicatorsPageState extends State<ApplicatorsPage> {
  late Future<List<Applicator>> _applicatorsFuture;
  final _applicatorDao = ApplicatorDao();

  @override
  void initState() {
    super.initState();
    _applicatorsFuture = _applicatorDao.queryAllRows();
  }

  Future<List<Applicator>> _queryApplicators() async {
    return await _applicatorDao.queryAllRows();
  }

  @override
  Widget build(BuildContext context) {
    return TopLevelPage(
      body: FutureBuilder<List<Applicator>>(
        future: _applicatorsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final applicators = snapshot.data!;
            return ListView.builder(
              itemCount: applicators.length,
              itemBuilder: (context, index) {
                final applicator = applicators[index];
                return ApplicatorTile(applicator: applicator);
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

class ApplicatorTile extends StatelessWidget {
  const ApplicatorTile({super.key, required this.applicator});

  final Applicator applicator;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(applicator.name),
      subtitle: Text(applicator.licenseNumber),
    );
  }
}
