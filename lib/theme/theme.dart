import 'package:appwritetest/theme/colors.dart';
import 'package:flutter/material.dart';

ThemeData theme = ThemeData(
  colorScheme: ColorScheme.dark(primary: Cols.brightPurple),
  textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.white),
  textTheme: TextTheme(
    bodyText1: TextStyle(color: Cols.lightGrey).apply(color: Cols.lightGrey),
    bodyText2: TextStyle(color: Cols.lightGrey).apply(color: Cols.lightGrey),
  ),
);
