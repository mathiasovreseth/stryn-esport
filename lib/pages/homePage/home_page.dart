import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../bookingPage/booking_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: HomePage());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => {
            //FirebaseAuth.instance.signOut(),
            Navigator.of(context).push(BookingPage.route())
          },
          child: const Text("Logg ut"),
        ),
      ),
    );
  }
}
