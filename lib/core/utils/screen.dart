import 'package:flutter/material.dart';

getScreenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - kToolbarHeight;
}
