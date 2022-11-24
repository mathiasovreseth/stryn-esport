import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stryn_esport/widgets/appBars/custom_app_bar.dart';

class BecomeMemberPage extends StatelessWidget {
  const BecomeMemberPage({super.key});

  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => const BecomeMemberPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        headerText: "Bli medlem",
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
      ),
    );
  }
}
