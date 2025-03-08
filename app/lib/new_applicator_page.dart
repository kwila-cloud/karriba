import 'package:flutter/material.dart';

class NewApplicatorPage extends StatelessWidget {
  const NewApplicatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await showDialog(
              context: context,
              builder:
                  (context) => AlertDialog(
                    title: const Text('Are you sure?'),
                    content: const Text(
                      'Are you sure you want to leave? You will lose unsaved changes.',
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text('Stay'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: const Text('Leave'),
                      ),
                    ],
                  ),
            ) ??
            false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('New Applicator'),
          actions: [
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {
                // TODO: actually save the form input
                Navigator.pop(context);
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            spacing: 16,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'License Number',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
