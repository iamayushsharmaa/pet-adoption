import 'package:flutter/material.dart';

import 'app_colors.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColors.lightBackground,
  fontFamily: 'Poppins',
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.lightBackground,
    foregroundColor: AppColors.lightText,
    elevation: 0,
  ),
  inputDecorationTheme: const InputDecorationTheme(
    fillColor: Color(0xFFF7F7F7),
    filled: true,
    hintStyle: TextStyle(color: Colors.grey),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: AppColors.lightText),
    bodyMedium: TextStyle(color: AppColors.lightText),
  ),
  iconTheme: const IconThemeData(color: AppColors.lightText),
);
