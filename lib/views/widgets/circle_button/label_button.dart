import 'package:converter/core/theme/app_text_style.dart';
import 'package:converter/views/widgets/circle_button/circle_button.dart';
import 'package:flutter/material.dart';

CircleButton labelButton({
  required String label,
  required BuildContext context,
  VoidCallback? handleOnPressed,
  double size = 64,
  double fontSize = 20,
  bool secondary = false,
}) {
  return CircleButton(
    handleOnPressed: handleOnPressed,
    secondary: secondary,
    size: size,
    child: Text(label, style: Theme.of(context).textStyle.copyWith(fontSize: fontSize)),
  );
}
