import 'package:converter/core/constants/deviceSize.dart';
import 'package:flutter/material.dart';

getScreenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - kToolbarHeight;
}

DeviceSize getScreenSize(BoxConstraints constraints) {
  switch (constraints.maxWidth) {
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
