import 'package:converter/core/l10n/app_localizations.dart';
import 'package:converter/core/theme/app_colors.dart';
import 'package:converter/core/theme/app_text_style.dart';
import 'package:converter/data/models/amount.dart';
import 'package:converter/data/models/currency.dart';
import 'package:converter/providers/converter_provider.dart';
import 'package:converter/views/widgets/currency_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CurrencyAmountField extends StatelessWidget {
  const CurrencyAmountField({super.key, required this.context, required this.position, required this.amounts});

  final BuildContext context;
  final FieldType position;
  final Map<FieldType, Amount?> amounts;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ConverterProvider>();
    final ThemeData t = Theme.of(context);
    final AppLocalizations l = AppLocalizations.of(context)!;

    final value = provider.amounts[position]?.value == '0' ? '' : provider.amounts[position]?.value;

    final controller = TextEditingController(text: value);

    final focusNode = FocusNode();
    focusNode.addListener(() {
      if (focusNode.hasFocus && position != context.read<ConverterProvider>().selectedField) {
        context.read<ConverterProvider>().changeSelectedField(position);
      }
    });

    void changeCurrency(Currency? value) {
      context.read<ConverterProvider>().changeCurrency(position, value);
    }

    return Padding(
      padding: EdgeInsets.only(left: 8),
      child: Column(
        children: [
          CurrencyDropdown(currencyChanged: changeCurrency, defaultCurrency: amounts[position]?.currency),
          Transform.translate(
            offset: Offset(0, -8),
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              style: t.textStyle.copyWith(fontSize: 45),
              keyboardType: TextInputType.none,
              inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: t.secondary, width: 2)),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: t.secondary, width: 2)),
                hintText: l.enterAmount,
                contentPadding: EdgeInsets.zero,
                hintStyle: t.textStyle.copyWith(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
