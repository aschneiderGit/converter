import 'package:converter/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

extension ThemeDataExtension on ThemeData {
  TextStyle get textStyle => TextStyle(color: AppColors.onBackgroundVariant, fontWeight: FontWeight.bold);
}
