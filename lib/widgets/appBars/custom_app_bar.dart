import 'package:flutter/material.dart';

/// Represents a reusable custom app bar, without the arrow back option
class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({required this.headerText, Key? key}) : super(key: key);
  final String headerText;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Theme.of(context).backgroundColor,
      title: Text(
        headerText,
        style: TextStyle(
          color: Colors.black.withOpacity(0.85),
          fontSize: 18,
          fontWeight: FontWeight.w600,
          letterSpacing: 1,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
