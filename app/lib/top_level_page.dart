import 'package:flutter/material.dart';
import 'coming_soon_dialog.dart';

class TopLevelPage extends StatelessWidget {
  const TopLevelPage({super.key, required this.body});

  final Widget body;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: body,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) => ComingSoonDialog(),
            );
          },
          child: Icon(Icons.add),
        ),
      );
}
