import 'package:converter/core/constants/deviceSize.dart';
import 'package:converter/core/l10n/app_localizations.dart';
import 'package:converter/core/theme/app_colors.dart';
import 'package:converter/views/widgets/keyboard.dart';
import 'package:converter/views/widgets/top_display.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    //debugPaintSizeEnabled = true;
    final deviceSize = context.watch<DeviceSize>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).background,
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.appBar), toolbarHeight: 45),
      body: switch (deviceSize) {
        DeviceSize.small || DeviceSize.extraSmall => Column(
          children: [
            Flexible(flex: 4, child: TopDisplay()),
            Flexible(flex: 5, child: Keyboard()),
          ],
        ),
        _ => Row(
          children: [
            Flexible(flex: 2, child: Keyboard()),
            Flexible(flex: 2, child: TopDisplay()),
          ],
        ),
      },
    );
  }
}
