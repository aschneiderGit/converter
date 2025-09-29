import 'package:flutter/material.dart';

getNextLocale(BuildContext context) {
  final List<Locale> locales = context.findAncestorWidgetOfExactType<MaterialApp>()!.supportedLocales.toList();
  if (locales.isEmpty) return null;
  final Locale currentLocale = Localizations.localeOf(context);
  final int currentIndex = locales.indexWhere((loc) => loc.languageCode == currentLocale.languageCode);
  if (currentIndex == -1) return locales.first.languageCode;
  final int nextIndex = (currentIndex + 1) % locales.length;

  return locales[nextIndex];
}
