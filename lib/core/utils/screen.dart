import 'package:converter/core/constants/deviceSize.dart';
import 'package:flutter/material.dart';

getScreenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - kToolbarHeight;
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
