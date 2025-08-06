import 'package:converter/core/theme/app_colors.dart';
import 'package:converter/core/theme/app_text_style.dart';
import 'package:converter/data/databases/database_helper.dart';
import 'package:converter/data/models/currency.dart';
import 'package:flutter/material.dart';

class CurrencyDropdown extends StatefulWidget {
  const CurrencyDropdown({super.key});

  @override
  State<CurrencyDropdown> createState() => _CurrencyDropdownState();
}

class _CurrencyDropdownState extends State<CurrencyDropdown> {
  List<Currency> currencies = [];
  Currency? currencySelected;

  @override
  void initState() {
    super.initState();
    _fetchCurrencies();
  }

  Future<void> _fetchCurrencies() async {
    final currenciesMaps = await DatabaseHelper.instance.getAllCurrency();
    print(currenciesMaps);
    setState(() {
      currencies = currenciesMaps;
      currencySelected = currencies.first;
    });
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
          },
          items: currencies.map<DropdownMenuItem<Currency>>((Currency value) {
            return DropdownMenuItem<Currency>(value: value, child: Text(value.code));
          }).toList(),
        ),
      ),
    );
  }
}
