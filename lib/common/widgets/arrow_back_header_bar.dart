import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class ArrowBackHeader extends StatelessWidget {
  const ArrowBackHeader(
      {required this.onBackClick, required this.headerText, Key? key})
      : super(key: key);
  final void Function() onBackClick;
  final String headerText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      child: Stack(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () {
                  onBackClick();
                },
                child: SvgPicture.asset(
                  'assets/icons/arrow_left.svg',
                  color: Colors.black.withOpacity(0.85),
                  width: 24,
                  height: 24,
                ),
              )),
          Align(
              child: Text(
            headerText,
            style: TextStyle(
                color: Colors.black.withOpacity(0.85),
                fontSize: 18,
                fontWeight: FontWeight.w600),
          )),
        ],
      ),
    );
  }
}
