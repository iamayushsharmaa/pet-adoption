import 'package:flutter/material.dart';

import 'light_theme.dart';
import 'dark_theme.dart';

class ThemeProvider {
  static ThemeData getTheme(bool isDarkMode) {
    return isDarkMode ? darkTheme : lightTheme;
  }
}
