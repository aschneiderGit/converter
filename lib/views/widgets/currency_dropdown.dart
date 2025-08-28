import 'package:converter/core/theme/app_colors.dart';
import 'package:converter/core/theme/app_text_style.dart';
import 'package:converter/data/databases/currency_helper.dart';
import 'package:converter/data/models/currency.dart';
import 'package:flutter/material.dart';

class CurrencyDropdown extends StatefulWidget {
  final Currency? defaultCurrency;
  final Function(Currency?) currencyChanged;
  const CurrencyDropdown({super.key, this.defaultCurrency, required this.currencyChanged});

  @override
  State<CurrencyDropdown> createState() => _CurrencyDropdownState();
}

class _CurrencyDropdownState extends State<CurrencyDropdown> {
  Map<String, Currency> currencies = {};
  Currency? currencySelected;

  @override
  void initState() {
    super.initState();
    _fetchCurrencies();
  }

  Future<void> _fetchCurrencies() async {
    currencies = await CurrencyHelper().getAllCurrency();
    currencySelected = currencies[widget.defaultCurrency?.code] ?? currencies.values.first;
  }

  @override
  void didUpdateWidget(covariant CurrencyDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.defaultCurrency != widget.defaultCurrency) {
      currencySelected = currencies[widget.defaultCurrency?.code];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Theme.of(context).secondary, width: 2)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<Currency>(
          value: currencySelected,
          style: Theme.of(context).textStyle.copyWith(fontSize: 20),
          dropdownColor: Theme.of(context).background,
          isExpanded: true,
          onChanged: (Currency? value) {
            setState(() {
              currencySelected = value!;
            });
            widget.currencyChanged(value);
          },
          items: currencies.values.map<DropdownMenuItem<Currency>>((Currency value) {
            return DropdownMenuItem<Currency>(value: value, child: Text(value.code));
          }).toList(),
        ),
      ),
    );
  }
}
