import 'package:flutter/material.dart';

class NewApplicatorPage extends StatelessWidget {
  const NewApplicatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Applicator')),
      body: const Center(child: Text('New Applicator Page')),
    );
  }
}
