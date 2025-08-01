import 'package:converter/core/theme/main_theme.dart';
import 'package:converter/views/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/l10n/app_localizations.dart';

void main() {
  runApp(const Converter());
}

class Converter extends StatelessWidget {
  const Converter({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //debugPaintSizeEnabled = true;
    return MaterialApp(
      title: 'Converter',
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'), // English
        Locale('fr'), // Spanish
      ],
      theme: mainTheme,
      home: Home(),
    );
  }
}
