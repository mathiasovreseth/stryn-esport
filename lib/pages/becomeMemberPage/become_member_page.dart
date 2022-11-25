import 'package:flutter/material.dart';
import 'package:stryn_esport/widgets/appBars/custom_app_bar.dart';
import 'package:stryn_esport/widgets/become_main_member.dart';
import 'package:stryn_esport/widgets/become_support_member.dart';

class BecomeMemberPage extends StatelessWidget {
  const BecomeMemberPage({super.key});

  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => const BecomeMemberPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        headerText: "Bli medlem",
      ),
      body: Column(
        children: const [
          BecomeSupportMemberWidget(),
          BecomeMainMemberWidget(),
          SizedBox(height: 8.0),
        ],
      ),
    );
  }
}



