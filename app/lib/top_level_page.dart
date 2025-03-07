import 'package:flutter/material.dart';
import 'coming_soon_dialog.dart';

class TopLevelPage extends StatelessWidget {
  const TopLevelPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: ListView(),
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
