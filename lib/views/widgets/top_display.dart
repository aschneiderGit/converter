import 'package:converter/core/l10n/app_localizations.dart';
import 'package:converter/core/theme/app_colors.dart';
import 'package:converter/core/theme/app_text_style.dart';
import 'package:converter/core/utils/time.dart';
import 'package:converter/data/models/amount.dart';
import 'package:converter/data/models/currency.dart';
import 'package:converter/providers/converter_provider.dart';
import 'package:converter/views/widgets/amount_field.dart';
import 'package:converter/views/widgets/circle_button/icon_button.dart';
import 'package:converter/views/widgets/currency_dropdown.dart';
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
      padding: const EdgeInsets.only(left: 12.0, top: 24, right: 12),
      color: t.primary,
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                flex: 4,
                child: Column(
                  children: [
                    _currencyAmountRow(context, FieldType.top, amounts),
                    const SizedBox(height: 12),
                    _currencyAmountRow(context, FieldType.bottom, amounts),
                  ],
                ),
              ),
              SizedBox(width: 16),
              Flexible(
                flex: 1,
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

  Row _currencyAmountRow(BuildContext context, FieldType position, Map<FieldType, Amount?> amounts) {
    void changeCurrency(Currency? value) {
      context.read<ConverterProvider>().changeCurrency(position, value);
    }

    return Row(
      children: [
        Flexible(flex: 80, child: AmountField(position: position)),
        Flexible(
          flex: 22,
          child: SizedBox(
            height: 77,
            child: CurrencyDropdown(defaultCurrency: amounts[position]?.currency, currencyChanged: changeCurrency),
          ),
        ),
      ],
    );
  }
}
