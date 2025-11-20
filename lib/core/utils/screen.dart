import 'package:converter/core/constants/device_size.dart';
import 'package:flutter/material.dart';

getScreenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - kToolbarHeight;
}

double getToolBarSize(BuildContext context) {
  switch (getScreenSize(context)) {
    case DeviceSize.small || DeviceSize.extraSmall:
      return 35;
    default:
      return 25;
  }
}

DeviceSize getScreenSize(BuildContext context) {
  switch (MediaQuery.of(context).size.width) {
    case < small:
      return DeviceSize.extraSmall;
    case < medium:
      return DeviceSize.small;
    case < large:
      return DeviceSize.medium;
    default:
      return DeviceSize.large;
  }
}

getGridChildRatioFromConstraints(int crossAxisCount, double mainAxisSpacing, int childrenCount, constraints) {
  final int columns = crossAxisCount;
  final int rows = childrenCount ~/ crossAxisCount;

  final double width = constraints.maxWidth;
  final double height = constraints.maxHeight - mainAxisSpacing * (rows - 1);

  final double cellWidth = width / columns;
  final double cellHeight = height / rows;

  return (cellWidth / cellHeight);
}

getGridChildRatioDefaultWithHeightPadding(
  double defaultRatio,
  int crossAxisCount,
  double mainAxisSpacing,
  int childrenCount,
  constraints, {
  double heightPadding = 0.0,
}) {
  final int columns = crossAxisCount;
  final int rows = childrenCount ~/ crossAxisCount;

  final double width = constraints.maxWidth;
  final double height = constraints.maxHeight - mainAxisSpacing * (rows - 1) - constraints.maxWidth * heightPadding;

  final double cellWidth = width / columns;
  final double cellHeight = height / rows;

  if (cellWidth * rows < height) {
    return defaultRatio;
  } else {
    return (cellWidth / cellHeight);
  }
}
