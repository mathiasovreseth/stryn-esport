import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class ArrowBackAppBar extends StatelessWidget with PreferredSizeWidget {
  const ArrowBackAppBar(
      {required this.onBackClick, required this.headerText, Key? key})
      : super(key: key);
  final void Function() onBackClick;
  final String headerText;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Theme.of(context).backgroundColor,
      leading: IconButton(
        icon: SvgPicture.asset(
          'assets/icons/arrow_left.svg',
          color: Colors.black.withOpacity(0.85),
          width: 24,
          height: 24,
        ),
        onPressed: onBackClick,
      ),
      title: Text(
        headerText,
        style: TextStyle(
            color: Colors.black.withOpacity(0.85),
            fontSize: 18,
            fontWeight: FontWeight.w600),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
