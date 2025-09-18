import 'package:converter/core/l10n/app_localizations.dart';
import 'package:converter/core/theme/app_colors.dart';
import 'package:converter/core/theme/app_text_style.dart';
import 'package:converter/core/utils/time.dart';
import 'package:converter/providers/converter_provider.dart';
import 'package:converter/views/widgets/circle_button/icon_button.dart';
import 'package:converter/views/widgets/currency_amount_filed.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopDisplay extends StatelessWidget {
  const TopDisplay({super.key});

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
    final dataTime = providerWatch.dataTime;

    return Container(
      padding: const EdgeInsets.only(left: 12.0, top: 32, right: 12),
      color: t.primary,
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                flex: 6,
                child: Column(
                  children: [
                    CurrencyAmountField(context: context, position: FieldType.top, amounts: amounts),
                    const SizedBox(height: 32),
                    CurrencyAmountField(context: context, position: FieldType.bottom, amounts: amounts),
                  ],
                ),
              ),
              SizedBox(width: 16),
              Flexible(
                flex: 2,
                child: Container(
                  child: iconButton(
                    icon: Icons.cached,
                    secondary: true,
                    size: 80,
                    iconSize: 60,
                    handleOnPressed: providerRead.toggleAmount,
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 32),
            child: Center(
              child: RichText(
                text: TextSpan(
                  text: l.updateTime,
                  style: t.textStyle.copyWith(fontSize: 16),
                  children: <TextSpan>[
                    getTimeAgo(context, dataTime!),
                    TextSpan(text: l.updateTimeEnd, style: t.textStyle.copyWith(fontSize: 14)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
