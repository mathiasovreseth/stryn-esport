import 'package:flutter/material.dart';
import 'package:stryn_esport/widgets/custom_bullet_list.dart';

class BecomeMainMemberWidget extends StatelessWidget {
  const BecomeMainMemberWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 30,
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
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            const BulletList(
              strings: [
                "Årskontigent: 995.-",
                "6 måneder: 595.-",
                "3 måneder: 295.-",
                "1 måned: 159.-",
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "Vi har desverre ingen betalingsløsninger i appen, "
                    "så vennligst kontakt xxx angående nytt medlemskap",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

