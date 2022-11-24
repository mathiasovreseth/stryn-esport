import 'package:flutter/material.dart';
import 'package:stryn_esport/widgets/appBars/custom_app_bar.dart';
import 'package:stryn_esport/widgets/custom_bullet_list.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 50,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                  color: Colors.blue,
                ),
                child: const Text(
                  "Hovedmedlem",
                  style: TextStyle(
                    fontSize: 20.0,
                    letterSpacing: 1,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  left: 15,
                  top: 10,
                ),
                child: Text(
                  "Priser",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const BulletList(
                strings: [
                  "Test1",
                  "Test2",
                  "Test3",
                  "Test4",
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
