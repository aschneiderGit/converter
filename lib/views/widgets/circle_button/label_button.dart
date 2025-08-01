import 'package:converter/views/widgets/circle_button/circle_button.dart';
import 'package:flutter/material.dart';

CircleButton labelButton({
  required String label,
  VoidCallback? handleOnPressed,
  double fontSize = 32,
  bool secondary = false,
}) {
  return CircleButton(
    label: label,
    handleOnPressed: handleOnPressed,
    secondary: secondary,
    fontSize: fontSize,
  );
}
