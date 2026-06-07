import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF2E7D32);
  static const Color primaryDark = Color(0xFF1B5E20);
  static const Color primaryLight = Color(0xFFA5D6A7);
  static const Color backgroundLight = Color(0xFFE8F5E9);
  
  static const Color white = Colors.white;
  static const Color transparent = Colors.transparent;
  static const Color error = Colors.redAccent;

  static const List<Color> backgroundGradient = [
    backgroundLight,
    primaryLight,
    primary,
  ];
}
