import 'package:converter/core/constants/deviceSize.dart';
import 'package:converter/core/l10n/app_localizations.dart';
import 'package:converter/core/theme/app_colors.dart';
import 'package:converter/core/utils/screen.dart';
import 'package:converter/providers/converter_provider.dart';
import 'package:converter/views/widgets/convert_display.dart';
import 'package:converter/views/widgets/keyboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    //debugPaintSizeEnabled = true;
    final provider = context.watch<ConverterProvider>();
    final deviceSize = context.watch<DeviceSize>();

    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return Localizations.override(
      context: context,
      locale: Locale(provider.setting.language),
      child: Builder(
        builder: (localCtx) => Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Theme.of(localCtx).background,
          appBar: AppBar(
            title: Padding(
              padding: EdgeInsets.only(bottom: 8), // adjust as needed
              child: Text(AppLocalizations.of(localCtx)!.appBar),
            ),
            toolbarHeight: getToolBarSize(context),
          ),
          body: switch (deviceSize) {
            DeviceSize.small || DeviceSize.extraSmall => Column(
              children: [
                Flexible(flex: 4, child: ConvertDisplay()),
                Flexible(flex: 5, child: Keyboard()),
              ],
            ),
            _ => Row(
              children: [
                Flexible(flex: 5, child: ConvertDisplay(inRow: true)),
                Flexible(flex: 6, child: Keyboard(inRow: true)),
              ],
            ),
          },
        ),
      ),
    );
  }
}
