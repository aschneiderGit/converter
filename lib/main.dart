import 'package:converter/core/constants/device_size.dart';
import 'package:converter/core/theme/main_theme.dart';
import 'package:converter/core/utils/screen.dart';
import 'package:converter/data/databases/database_helper.dart';
import 'package:converter/providers/converter_provider.dart';
import 'package:converter/views/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'core/l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.instance.initDb();

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ConverterProvider())],
      child: Converter(),
    ),
  );
}

class Converter extends StatelessWidget {
  const Converter({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceSize = getScreenSize(context);
    return Provider<DeviceSize>.value(
      value: deviceSize,
      child: MaterialApp(
        title: 'Converter',
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [Locale('en'), Locale('fr')],
        theme: mainTheme,
        home: Home(),
      ),
    );
  }
}
