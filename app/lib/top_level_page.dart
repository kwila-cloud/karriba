import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';

class TopLevelPage extends StatelessWidget {
  const TopLevelPage({
    super.key,
    this.appBar,
    required this.body,
    this.onAddPressed,
  });

  final PreferredSizeWidget? appBar;
  final Widget body;
  final VoidCallback? onAddPressed;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: appBar,
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
