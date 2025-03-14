import 'package:flutter/material.dart';
import 'top_level_page.dart';
import 'edit_applicator_page.dart';
import 'applicator.dart';
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
    _refreshApplicators();
  }

  _refreshApplicators() {
    _applicatorsFuture = _applicatorDao.queryAllRows();
  }

  @override
  Widget build(BuildContext context) {
    return TopLevelPage(
      body: FutureBuilder<List<Applicator>>(
        future: _applicatorsFuture,
        builder: (context, snapshot) {
          final applicators = snapshot.data;
          if (applicators != null) {
            return ListView.builder(
              itemCount: applicators.length,
              itemBuilder:
                  (context, index) => ApplicatorTile(
                    applicator: applicators[index],
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => EditApplicatorPage(
                                applicator: applicators[index],
                              ),
                        ),
                      );
                      setState(() {
                        _refreshApplicators();
                      });
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
          MaterialPageRoute(builder: (context) => const EditApplicatorPage()),
        );
        // Refresh the list after adding a new applicator
        setState(() {
          _refreshApplicators();
        });
      },
    );
  }
}

class ApplicatorTile extends StatelessWidget {
  const ApplicatorTile({super.key, required this.applicator, this.onTap});

  final Applicator applicator;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(applicator.name),
      subtitle: Text(applicator.licenseNumber),
      onTap: onTap,
    );
  }
}
