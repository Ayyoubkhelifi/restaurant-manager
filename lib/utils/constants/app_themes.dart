import 'package:flutter/material.dart';
import 'package:restaurant/utils/constants/app_color.dart';

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    surface: Colors.grey.shade300,
    primary: Colors.grey.shade500,
    secondary: Colors.grey.shade200,
    tertiary: Colors.white,
    inversePrimary: Colors.grey.shade900,
  ),
  appBarTheme: AppBarTheme(
    color: AppColor.primaryColor,
    foregroundColor: Colors.white,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: AppColor.primaryColor,
    foregroundColor: Colors.white,
  ),
);
ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.dark(
    // surface: Colors.grey.shade900,
    surface: Color(0xFF050F09),
    primary: Colors.grey.shade600,
    secondary: Colors.grey.shade700,
    tertiary: Colors.grey.shade800,
    inversePrimary: Colors.grey.shade300,
  ),
  appBarTheme: AppBarTheme(
    color: Color(0xFF050F09),
    foregroundColor: AppColor.primaryColor,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: AppColor.primaryColor,
    foregroundColor: Colors.white,
  ),
);
