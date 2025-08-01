import 'package:converter/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

ThemeData mainTheme = ThemeData().copyWith(
  primaryColor: AppColors.primary,
  textSelectionTheme: TextSelectionThemeData(cursorColor: AppColors.onPrimary),
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.secondaryVariant,
    titleTextStyle: TextStyle(
      color: AppColors.onSurface,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  textTheme: TextTheme(),
  brightness: Brightness.light,
);
