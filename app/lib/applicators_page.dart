import 'package:flutter/material.dart';
import 'top_level_page.dart';
import 'new_applicator_page.dart';

class ApplicatorsPage extends StatelessWidget {
  const ApplicatorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TopLevelPage(
      body: const Center(child: Text('Applicators Page Content')),
      onAddPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NewApplicatorPage()),
        );
      },
    );
  }
}
