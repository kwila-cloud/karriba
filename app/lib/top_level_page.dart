import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'coming_soon_dialog.dart';

class TopLevelPage extends StatelessWidget {
  const TopLevelPage({super.key, required this.body, this.onAddPressed});

  final Widget body;
  final VoidCallback? onAddPressed;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: body,
    floatingActionButton: FloatingActionButton(
      onPressed: onAddPressed ?? () {
        showDialog(
          context: context,
          builder: (BuildContext context) => const ComingSoonDialog(),
        );
      },
      child: Iconify(Mdi.add),
    ),
  );
}
