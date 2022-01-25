import 'package:appwritetest/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData theme = ThemeData(
  colorScheme: ColorScheme.dark(primary: Cols.brightPurple),
  textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.white),
  textTheme: GoogleFonts.montserratTextTheme().apply(bodyColor: Cols.lightGrey),
);
