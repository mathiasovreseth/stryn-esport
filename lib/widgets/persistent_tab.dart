import 'package:flutter/material.dart';

/// keeps pages alive when changing tabs
class PersistantTab extends StatefulWidget {
  const PersistantTab({required this.child});

  final Widget child;

  @override
  PersistantTabState createState() => PersistantTabState();
}

class PersistantTabState extends State<PersistantTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
