import 'package:converter/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final VoidCallback? handleOnPressed;
  final String label;
  final double fontSize;
  final String? fontFamily;
  final String? fontPackage;
  final bool secondary;

  const CircleButton({
    super.key,
    required this.label,
    required this.fontSize,
    this.handleOnPressed,
    this.fontFamily,
    this.fontPackage,
    this.secondary = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: handleOnPressed,
      style: ButtonStyle(
        shape: WidgetStateProperty.all(CircleBorder()),
        backgroundColor: WidgetStateProperty.all(
          secondary ? Theme.of(context).secondary : Theme.of(context).primary,
        ),
        padding: WidgetStateProperty.all(const EdgeInsets.all(10)),
        overlayColor: WidgetStateProperty.all(
          secondary
              ? Theme.of(context).secondaryVariant
              : Theme.of(context).primaryVariant,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: secondary
              ? Theme.of(context).onSecondary
              : Theme.of(context).onPrimary,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          fontFamily: fontFamily,
          package: fontPackage,
        ),
      ),
    );
  }
}
