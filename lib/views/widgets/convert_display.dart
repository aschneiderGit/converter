import 'package:converter/core/l10n/app_localizations.dart';
import 'package:converter/core/theme/app_colors.dart';
import 'package:converter/core/theme/app_text_style.dart';
import 'package:converter/core/utils/time.dart';
import 'package:converter/data/services/exchange_rate.dart';
import 'package:converter/providers/converter_provider.dart';
import 'package:converter/views/widgets/alert_dialog_widget.dart';
import 'package:converter/views/widgets/animated_icon_widget.dart';
import 'package:converter/views/widgets/circle_button/icon_button.dart';
import 'package:converter/views/widgets/currency_amount_filed.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConvertDisplay extends StatefulWidget {
  final bool inRow;
  const ConvertDisplay({super.key, this.inRow = false});

  @override
  State<ConvertDisplay> createState() => _ConvertDisplayState();
}

class _ConvertDisplayState extends State<ConvertDisplay> {
  @override
  Widget build(BuildContext context) {
    final providerWatch = context.watch<ConverterProvider>();
    final providerRead = context.read<ConverterProvider>();
    final ThemeData t = Theme.of(context);
    final AppLocalizations l = AppLocalizations.of(context)!;

    if (providerWatch.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final amounts = providerWatch.amounts;
    final dataTime = providerWatch.setting.dataTime;

    return Container(
      padding: EdgeInsets.only(top: 24),
      color: t.primary,
      child: Column(
        children: [
          Row(
            children: () {
              final childrenArray = [
                Flexible(
                  flex: 6,
                  child: Column(
                    children: [
                      CurrencyAmountField(context: context, position: FieldType.top, amounts: amounts),
                      SizedBox(height: 16),
                      CurrencyAmountField(context: context, position: FieldType.bottom, amounts: amounts),
                    ],
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: iconButton(
                      icon: Icons.swap_vert,
                      secondary: true,
                      size: 75,
                      iconSize: 60,
                      handleOnPressed: providerRead.toggleAmount,
                    ),
                  ),
                ),
              ];
              return widget.inRow ? childrenArray.reversed.toList() : childrenArray;
            }(),
          ),
          Container(
            margin: EdgeInsets.only(top: widget.inRow ? 16 : 32),
            child: Row(
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
                              title: "Can't access to the Exchangerate API",
                              message: 'Check your connection internet, or the Exchangerate API status',
                              showCancel: false,
                            ),
                          );
                        case ResultOfGettingRates.updated:
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Data updated"),
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
                              content: Text("Data already up to date (it refresh only every 24h)"),
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
            ),
          ),
        ],
      ),
    );
  }
}
