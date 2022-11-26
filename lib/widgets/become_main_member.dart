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
                "Main Member",
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
                "Become member to rent stations",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 15,
                top: 10,
              ),
              child: Text(
                "Pricing",
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
                "Annual membership: NOK 995.-",
                "6 months membership: NOK 595.-",
                "3 months membership: NOK 295.-",
                "1 month membership: NOK 159.-",
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "Unfortunately, we don't have any payment options in the app. "
                "Please contact xxx to purchase or renew your membership",
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
