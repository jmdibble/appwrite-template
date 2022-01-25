import 'package:flutter/material.dart';

class Cols {
  static BoxDecoration customBG = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomCenter,
      stops: [0.01, 0.5, 1],
      colors: [
        primaryBlack,
        primaryBlue,
        primaryPurple,
      ],
    ),
  );

  static Color primaryBlack = Color(0xFF07070E);
  static Color primaryBlue = Color(0xFF151955);
  static Color primaryPurple = Color(0xFF53294C);
  static Color lightPurple = Color(0xFFA24B68);
  static Color brightPurple = Color(0xFF8324C6);
  static Color brightBlue = Color(0xFF0F24E0);
  static Color lightBlue = Color(0xFF344CCA);
  static Color lightGrey = Color(0xFFD5D5DB);
}
