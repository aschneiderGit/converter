import 'dart:io';

import 'package:converter/core/constants/alert_dialog_endpoint.dart';
import 'package:converter/core/constants/device_size.dart';
import 'package:converter/core/l10n/app_localizations.dart';
import 'package:converter/core/theme/app_colors.dart';
import 'package:converter/core/utils/screen.dart';
import 'package:converter/providers/converter_provider.dart';
import 'package:converter/views/widgets/alert_dialog_widget.dart';
import 'package:converter/views/widgets/convert_display.dart';
import 'package:converter/views/widgets/keyboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final provider = context.watch<ConverterProvider>();

    if (!provider.isLoading && provider.notInstanciate && !provider.online) {
      Future.microtask(() {
        showDialog<AlertDialogEndpoint>(
          context: context,
          builder: (_) => AlertDialogWidget(
            title: 'Need internet connection',
            message:
                'For your first usage of the app you need an internet connection to fetch the initial value of the converter currency',
            showCancel: true,
            okText: 'Try to refetch data',
            cancelText: 'Quit the app',
          ),
        ).then((res) {
          if (res == AlertDialogEndpoint.ok) {
            provider.init();
          } else if (res == AlertDialogEndpoint.cancel) {
            exit(0);
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //debugPaintSizeEnabled = true;
    final provider = context.watch<ConverterProvider>();
    final deviceSize = context.watch<DeviceSize>();
    final ThemeData t = Theme.of(context);

    if (provider.isLoading) {
      return Center(child: CircularProgressIndicator(color: t.primaryColor));
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
