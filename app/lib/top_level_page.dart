import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';

class TopLevelPage extends StatelessWidget {
  const TopLevelPage({super.key, required this.body, this.onAddPressed});

  final Widget body;
  final VoidCallback? onAddPressed;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: body,
    floatingActionButton:
        onAddPressed != null
            ? FloatingActionButton(
              onPressed: onAddPressed,
              child: Iconify(Mdi.add),
            )
            : null,
  );
}
