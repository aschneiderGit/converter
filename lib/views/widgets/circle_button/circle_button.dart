import 'package:converter/core/constants/device_size.dart';
import 'package:converter/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final VoidCallback? handleOnPressed;
  final Widget child;
  final double size;
  final bool secondary;

  const CircleButton({super.key, required this.child, this.handleOnPressed, this.size = 64, this.secondary = false});

  @override
  Widget build(BuildContext context) {
    ThemeData t = Theme.of(context);
    final isAtLeastMediumScreen = MediaQuery.of(context).size.width > small;
    final ShapeBorder shape = isAtLeastMediumScreen
        ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(1000))
        : const CircleBorder();

    return Material(
      shape: shape,
      color: secondary ? t.secondary : t.primary,
      child: InkWell(
        customBorder: shape,
        onTap: handleOnPressed,
        child: SizedBox(
          width: size,
          height: size,
          child: Center(child: child),
        ),
      ),
    );
  }
}
