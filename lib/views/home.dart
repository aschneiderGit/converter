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
        if (!mounted) return;
        showDialog<AlertDialogEndpoint>(
          context: context,
          builder: (context) {
            final AppLocalizations l = AppLocalizations.of(context)!;
            return AlertDialogWidget(
              title: l.noConnectionAtInitTitle,
              message: l.noConnectionAtInitMessage,
              showCancel: true,
              okText: l.refecht,
              cancelText: l.quitApp,
            );
          },
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

  Widget lanscapeOrPortraitBody(deviceSize) {
    switch (deviceSize) {
      case DeviceSize.small || DeviceSize.extraSmall:
        return Column(
          children: [
            Flexible(flex: 4, child: ConvertDisplay()),
            Flexible(flex: 5, child: Keyboard()),
          ],
        );
      default:
        return Row(
          children: [
            Flexible(flex: 5, child: ConvertDisplay(inRow: true)),
            Flexible(flex: 6, child: Keyboard(inRow: true)),
          ],
        );
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
      child: SafeArea(
        top: false,
        bottom: true,
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
            body: lanscapeOrPortraitBody(deviceSize),
          ),
        ),
      ),
    );
  }
}
