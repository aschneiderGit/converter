import 'package:converter/views/widgets/circle_button/circle_button.dart';
import 'package:flutter/material.dart';

CircleButton iconButton({
  required IconData icon,
  VoidCallback? handleOnPressed,
  double fontSize = 40,
  bool secondary = false,
}) {
  String text = String.fromCharCode(icon.codePoint);

  return CircleButton(
    label: text,
    handleOnPressed: handleOnPressed,
    secondary: secondary,
    fontSize: fontSize,
    fontFamily: icon.fontFamily,
    fontPackage: icon.fontPackage,
  );
}
