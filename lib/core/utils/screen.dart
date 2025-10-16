import 'package:converter/core/constants/deviceSize.dart';
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
    case < SMALL:
      return DeviceSize.extraSmall;
    case < MEDIUM:
      return DeviceSize.small;
    case < LARGE:
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
