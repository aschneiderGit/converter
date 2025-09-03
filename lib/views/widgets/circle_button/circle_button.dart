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
    return Material(
      shape: CircleBorder(),
      color: secondary ? AppColors.secondary : AppColors.primary,
      child: InkWell(
        customBorder: const CircleBorder(),
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
