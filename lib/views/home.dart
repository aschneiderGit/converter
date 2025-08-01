import 'package:converter/core/l10n/app_localizations.dart';
import 'package:converter/core/theme/app_colors.dart';
import 'package:converter/views/widgets/keyboard.dart';
import 'package:converter/views/widgets/top_display.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).background,
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.appBar)),
      body: Column(children: [TopDisplay(), Keyboard()]),
    );
  }
}
