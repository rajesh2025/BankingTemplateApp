import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Inter',
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF0A4D68), // TrustINBank blue
        primary: const Color(0xFF0A4D68),
        secondary: const Color(0xFF088395),
        surface: Colors.white,
      ),
    );
  }
}