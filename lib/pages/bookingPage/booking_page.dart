import 'package:flutter/material.dart';

import '../../widgets/appBars/custom_app_bar.dart';

class BookingPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => BookingPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        headerText: 'Book stasjoner',
      ),
    );
  }
}
