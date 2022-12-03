import 'package:flutter/material.dart';

/// Vertical spacing, defaults to 12
class VerticalSpacer extends StatelessWidget {
  const VerticalSpacer({Key? key, this.height = 12}) : super(key: key);
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}

/// Horizontal spacing, defaults to 8
class HorizontalSpacer extends StatelessWidget {
  const HorizontalSpacer({Key? key, this.width = 8}) : super(key: key);
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width);
  }
}
