import 'package:flutter/material.dart';

import 'app_colors.dart';

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColors.darkBackground,
  fontFamily: 'Poppins',
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.darkBackground,
    foregroundColor: AppColors.darkText,
    elevation: 0,
  ),
  inputDecorationTheme: const InputDecorationTheme(
    fillColor: Color(0xFF1E1E1E),
    filled: true,
    hintStyle: TextStyle(color: Colors.grey),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: AppColors.darkText),
    bodyMedium: TextStyle(color: AppColors.darkText),
  ),
  iconTheme: const IconThemeData(color: AppColors.darkText),
);
