import 'package:converter/views/widgets/circle_button/circle_button.dart';
import 'package:flutter/material.dart';

CircleButton iconButton({
  required IconData icon,
  VoidCallback? handleOnPressed,
  double size = 64,
  double iconSize = 48,
  bool secondary = false,
}) {
  return CircleButton(
    handleOnPressed: handleOnPressed,
    secondary: secondary,
    size: size,
    child: Icon(icon, size: iconSize, color: Colors.white),
  );
}
