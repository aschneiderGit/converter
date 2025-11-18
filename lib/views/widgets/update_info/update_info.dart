import 'package:converter/core/l10n/app_localizations.dart';
import 'package:converter/core/theme/app_colors.dart';
import 'package:converter/core/theme/app_text_style.dart';
import 'package:converter/core/utils/time.dart';
import 'package:converter/data/services/exchange_rate.dart';
import 'package:converter/providers/converter_provider.dart';
import 'package:converter/views/widgets/alert_dialog_widget.dart';
import 'package:converter/views/widgets/update_info/animated_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateInfo extends StatefulWidget {
  const UpdateInfo({super.key});

  @override
  State<UpdateInfo> createState() => _UpdateInfoState();
}

class _UpdateInfoState extends State<UpdateInfo> {
  @override
  Widget build(BuildContext context) {
    final providerWatch = context.watch<ConverterProvider>();
    final ThemeData t = Theme.of(context);
    final AppLocalizations l = AppLocalizations.of(context)!;

    final dataTime = providerWatch.setting.dataTime;

    return Row(
      mainAxisSize: MainAxisSize.min, // only as wide as content
      children: [
        GestureDetector(
          onTap: () async {
            final res = await providerWatch.refresh();
            if (mounted) {
              switch (res) {
                case ResultOfGettingRates.offline:
                  showDialog(
                    // ignore: use_build_context_synchronously
                    context: context,
                    builder: (_) => AlertDialogWidget(
                      title: l.canAcessDataTitle,
                      message: l.canAcessDataMessage,
                      showCancel: false,
                    ),
                  );
                case ResultOfGettingRates.updated:
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(l.dataUpdated),
                      duration: Duration(milliseconds: 1500),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.only(bottom: 10, left: 25, right: 25),
                    ),
                  );
                case ResultOfGettingRates.upToDate:
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(l.dataUpToDate),
                      duration: Duration(milliseconds: 1500),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.only(bottom: 10, left: 25, right: 25),
                    ),
                  );
              }
            }
          },
          child: AnimatedIconWidget(
            icon: Icons.cached,
            size: 35,
            color: t.secondary,
            condition: providerWatch.refreshing,
            animatedBuilder: (animation, child) => RotationTransition(turns: animation, child: child),
          ),
        ),
        SizedBox(width: 4),
        RichText(
          text: TextSpan(
            text: l.updateTime,
            style: t.textStyle.copyWith(fontSize: 16),
            children: <TextSpan>[
              getTimeAgo(context, dataTime),
              TextSpan(text: l.updateTimeEnd, style: t.textStyle.copyWith(fontSize: 16)),
            ],
          ),
        ),
        SizedBox(width: 4),
        Tooltip(
          message: 'UTC: ${dataTime.toString()}\n${l.attribution}',
          showDuration: Duration(seconds: 5),
          triggerMode: TooltipTriggerMode.tap,
          child: Icon(Icons.info_outline_rounded, size: 20, color: t.onPrimary),
        ),
      ],
    );
  }
}
