import 'package:converter/views/widgets/circle_button/circle_button.dart';
import 'package:flutter/material.dart';

CircleButton iconButton({
  required IconData icon,
  VoidCallback? handleOnTap,
  bool secondary = false,
}) {
  String text = String.fromCharCode(icon.codePoint);

  return CircleButton(
    label: text,
    handleOnTap: handleOnTap,
    secondary: secondary,
    fontSize: 40,
    fontFamily: icon.fontFamily,
    fontPackage: icon.fontPackage,
  );
}
