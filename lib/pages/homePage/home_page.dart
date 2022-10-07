import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: HomePage());

  bool _willPop() {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Heisa"),
    );
  }
}
