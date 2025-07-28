import 'package:converter/views/widgets/circle_button/circle_button.dart';
import 'package:flutter/material.dart';

CircleButton labelButton({
  required String label,
  VoidCallback? handleOnTap,
  bool secondary = false,
}) {
  return CircleButton(
    label: label,
    handleOnTap: handleOnTap,
    secondary: secondary,
    fontSize: 32,
  );
}
