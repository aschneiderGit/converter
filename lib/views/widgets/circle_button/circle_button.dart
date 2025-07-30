import 'package:converter/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final VoidCallback? handleOnTap;
  final String label;
  final double fontSize;
  final String? fontFamily;
  final String? fontPackage;
  final bool secondary;

  const CircleButton({
    super.key,
    required this.label,
    required this.fontSize,
    this.handleOnTap,
    this.fontFamily,
    this.fontPackage,
    this.secondary = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handleOnTap,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: secondary ? AppColors.secondary : AppColors.primary,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: secondary ? AppColors.onSecondary : AppColors.onPrimary,
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              fontFamily: fontFamily,
              package: fontPackage,
            ),
          ),
        ),
      ),
    );
  }
}
