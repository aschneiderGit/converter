import 'package:converter/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

ThemeData mainTheme = ThemeData().copyWith(
  primaryColor: AppColors.primary,
  textSelectionTheme: TextSelectionThemeData(cursorColor: AppColors.onPrimary),
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.secondaryVariant,
    titleTextStyle: TextStyle(color: AppColors.onSurface, fontSize: 20, fontWeight: FontWeight.bold),
  ),
  textTheme: TextTheme(),
  brightness: Brightness.light,

  dialogTheme: DialogThemeData(
    backgroundColor: AppColors.secondaryVariant, // dialog background
    titleTextStyle: TextStyle(color: AppColors.onSurface, fontWeight: FontWeight.bold, fontSize: 18),
    contentTextStyle: TextStyle(color: AppColors.onSurface, fontSize: 16),
    actionsPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),
);
