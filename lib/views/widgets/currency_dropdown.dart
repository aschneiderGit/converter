import 'package:converter/core/theme/app_colors.dart';
import 'package:converter/core/theme/app_text_style.dart';
import 'package:converter/data/models/currency.dart';
import 'package:converter/providers/converter_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CurrencyDropdown extends StatelessWidget {
  final Currency? defaultCurrency;
  final Function(Currency?) currencyChanged;

  const CurrencyDropdown({super.key, this.defaultCurrency, required this.currencyChanged});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ConverterProvider>();

    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final currencies = provider.allCurrencies;
    if (currencies.isEmpty) {
      return const Text("No currencies available");
    }

    final selected = currencies[defaultCurrency?.code] ?? currencies.values.first;

    return Container(
      padding: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Theme.of(context).secondary, width: 2)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<Currency>(
          value: selected,
          style: Theme.of(context).textStyle.copyWith(fontSize: 20),
          dropdownColor: Theme.of(context).background,
          isExpanded: true,
          onChanged: currencyChanged,
          items: currencies.values.map((currency) {
            return DropdownMenuItem(value: currency, child: Text(currency.code));
          }).toList(),
        ),
      ),
    );
  }
}
