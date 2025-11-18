import 'package:flutter/material.dart';

class AnimatedIconWidget extends StatefulWidget {
  final IconData icon;
  final bool condition;
  final Color color;
  final double size;
  final AnimatedWidget Function(Animation<double> animation, Widget child) animatedBuilder;

  const AnimatedIconWidget({
    super.key,
    required this.icon,
    required this.condition,
    required this.color,
    required this.animatedBuilder,
    this.size = 35,
  });

  @override
  State<AnimatedIconWidget> createState() => _AnimatedIconWidgetState();
}

class _AnimatedIconWidgetState extends State<AnimatedIconWidget> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    if (widget.condition) controller.repeat();
  }

  @override
  void didUpdateWidget(covariant AnimatedIconWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.condition && !oldWidget.condition) {
      controller.repeat(); // start spinning
    } else if (!widget.condition && oldWidget.condition) {
      controller.stop(); // stop spinning
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final icon = Icon(widget.icon, size: widget.size, color: widget.color);
    return widget.animatedBuilder(controller, icon);
  }
}
