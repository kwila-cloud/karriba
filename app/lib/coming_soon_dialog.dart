import 'package:flutter/material.dart';

class ComingSoonDialog extends StatelessWidget {
  const ComingSoonDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text("Coming Soon!"),
    content: Text("This feature is under development."),
    actions: [
      TextButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ],
  );
}
