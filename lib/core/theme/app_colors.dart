import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color.fromARGB(255, 120, 184, 216);
  static const Color primaryVariant = Color.fromARGB(255, 5, 129, 190);
  static const Color secondary = Color.fromARGB(255, 247, 169, 2);
  static const Color secondaryVariant = Color.fromARGB(255, 240, 159, 10);
  static const Color background = Color.fromARGB(255, 185, 219, 236);
  static const Color backgroundVariant = Color.fromARGB(255, 139, 199, 230);
  static const Color surface = Color.fromARGB(255, 120, 184, 216);
  static const Color error = Color(0xFFD32F2F);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color onBackground = Color(0xFF000000);
  static const Color onBackgroundVariant = Color(0xFFFFFFFF);
  static const Color onSurface = Color(0xFFFFFFFF);
  static const Color onError = Color(0xFFFFFFFF);
}

extension ThemeDataExtension on ThemeData {
  Color get primary => AppColors.primary;
  Color get primaryVariant => AppColors.primaryVariant;
  Color get secondary => AppColors.secondary;
  Color get secondaryVariant => AppColors.secondaryVariant;
  Color get background => AppColors.background;
  Color get backgroundVariant => AppColors.backgroundVariant;
  Color get surface => AppColors.surface;
  Color get error => AppColors.error;
  Color get onPrimary => AppColors.onPrimary;
  Color get onSecondary => AppColors.onSecondary;
  Color get onBackground => AppColors.onBackground;
  Color get onBackgroundVariant => AppColors.onBackgroundVariant;
  Color get onSurface => AppColors.onSurface;
  Color get onError => AppColors.onError;
}
