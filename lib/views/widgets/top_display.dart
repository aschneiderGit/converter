import 'package:converter/core/l10n/app_localizations.dart';
import 'package:converter/core/theme/app_colors.dart';
import 'package:converter/core/theme/app_text_style.dart';
import 'package:converter/data/models/amount.dart';
import 'package:converter/data/models/currency.dart';
import 'package:converter/providers/converter_provider.dart';
import 'package:converter/views/widgets/amount_field.dart';
import 'package:converter/views/widgets/circle_button/icon_button.dart';
import 'package:converter/views/widgets/currency_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TopDisplay extends StatelessWidget {
  const TopDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final providerWatch = context.watch<ConverterProvider>();
    final providerRead = context.read<ConverterProvider>();

    if (providerWatch.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final amounts = providerWatch.amounts;
    final dataTime = providerWatch.dataTime;
    final DateFormat formatter = DateFormat('yyyy/MM/dd HH:mm:ss');

    return Container(
      padding: const EdgeInsets.only(left: 12.0, top: 24, right: 12),
      color: Theme.of(context).primary,
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
              const SizedBox(width: 16),
              Flexible(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.only(top: 32.0),
                  child: iconButton(icon: Icons.cached, secondary: true, handleOnPressed: providerRead.toggleAmount),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 32),
            height: 60,
            child: Center(
              child: Text(
                "${AppLocalizations.of(context)!.updateTime} ${formatter.format(dataTime!)}",
                style: Theme.of(context).textStyle.copyWith(fontSize: 14),
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
        Flexible(flex: 7, child: AmountField(position: position)),
        const SizedBox(width: 24),
        Flexible(
          flex: 3,
          child: SizedBox(
            height: 77,
            child: CurrencyDropdown(defaultCurrency: amounts[position]?.currency, currencyChanged: changeCurrency),
          ),
        ),
      ],
    );
  }
}
