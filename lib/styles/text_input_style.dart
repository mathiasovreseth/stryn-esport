import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

InputDecoration textFormDecoration(
    {required String hintText,
    required String suffixIcon,
    required String label,
    String? errorText,
    required BuildContext context}) {
  return InputDecoration(
    suffixIconConstraints: const BoxConstraints(),
    suffixIcon: Padding(
      padding: const EdgeInsets.only(right: 12),
      child: SvgPicture.asset(
        suffixIcon,
        color: Colors.black,
        width: 16,
        height: 16,
      ),
    ),
    labelText: label,
    labelStyle: Theme.of(context).primaryTextTheme.labelMedium,
    hintText: hintText,
    errorText: errorText,
  );
}
