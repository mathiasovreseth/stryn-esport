import 'package:flutter/material.dart';
import 'package:stryn_esport/widgets/custom_bullet_list.dart';

class BecomeSupportMemberWidget extends StatelessWidget {
  const BecomeSupportMemberWidget({
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
                "Støttemedlem",
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
                "Fordeler",
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
                "Medlemsrabatt på klubbstore",
                "Medlemsrabatt på arrangement",
              ],
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
                "Valgfritt beløp over kr 199.-",
              ],
            ),
          ],
        ),
      ),
    );
  }
}
