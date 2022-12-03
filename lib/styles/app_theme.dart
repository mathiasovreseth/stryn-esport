import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData get customTheme {
  return ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color.fromRGBO(24, 144, 255, 1),
    backgroundColor: const Color.fromRGBO(243, 243, 243, 1),
    unselectedWidgetColor: Colors.white,
    canvasColor: Colors.transparent,
    scaffoldBackgroundColor: const Color.fromRGBO(243, 243, 243, 1),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryTextTheme: const TextTheme(
      labelSmall:
          TextStyle(color: Color.fromRGBO(24, 144, 255, 1), fontSize: 12),
      labelMedium:
          TextStyle(color: Color.fromRGBO(24, 144, 255, 1), fontSize: 14),
      labelLarge:
          TextStyle(color: Color.fromRGBO(24, 144, 255, 1), fontSize: 16),
    ),
    fontFamily: GoogleFonts.manrope().fontFamily,
    textTheme: const TextTheme(
      subtitle1: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      subtitle2: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
    ).apply(
      bodyColor: Colors.black.withOpacity(.85),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        //foregroundColor: Colors.white,
        side: const BorderSide(
          color: Colors.white,
        ),
      ),
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    inputDecorationTheme: InputDecorationTheme(
        fillColor: Colors.white,
        alignLabelWithHint: true,
        floatingLabelStyle: const TextStyle(fontSize: 14),
        labelStyle: const TextStyle(fontSize: 14),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        enabledBorder: inputBorder,
        focusedBorder: focusBorder,
        disabledBorder: inputBorder,
        errorBorder: errorBorder,
        focusedErrorBorder: errorBorder,
        filled: true,
        hintStyle:
            TextStyle(color: Colors.black.withOpacity(0.35), fontSize: 14)),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(const Color.fromRGBO(24, 144, 255, 1)),
          padding: MaterialStateProperty.all(
              const EdgeInsets.only(top: 12, bottom: 12)),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          )),
          textStyle: MaterialStateProperty.all(
              const TextStyle(color: Colors.white, fontSize: 16))),
    ),
  );
}

OutlineInputBorder get inputBorder {
  return const OutlineInputBorder(
      //Outline border type for TextFeild
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(
        color: Colors.white,
        width: 1,
      ));
}

OutlineInputBorder get focusBorder {
  return const OutlineInputBorder(
      //Outline border type for TextFeild
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(
        color: Color.fromRGBO(24, 144, 255, 1),
        width: 1,
      ));
}

OutlineInputBorder get errorBorder {
  return const OutlineInputBorder(
      //Outline border type for TextFeild
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(
        color: Colors.red,
        width: 1,
      ));
}
