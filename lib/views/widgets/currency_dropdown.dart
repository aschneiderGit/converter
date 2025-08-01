import 'package:converter/core/theme/app_colors.dart';
import 'package:converter/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class CurrencyDropdown extends StatefulWidget {
  const CurrencyDropdown({super.key});

  @override
  State<CurrencyDropdown> createState() => _CurrencyDropdownState();
}

class _CurrencyDropdownState extends State<CurrencyDropdown> {
  static const List<String> currencies = <String>['USD', 'EURO', 'HKD', 'RMB'];
  String currency = currencies.first;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Theme.of(context).secondary, width: 2)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: currency,
          style: Theme.of(context).textStyle.copyWith(fontSize: 20),
          dropdownColor: Theme.of(context).background,
          isExpanded: true,
          onChanged: (String? value) {
            setState(() {
              currency = value!;
            });
          },
          items: currencies.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
        ),
      ),
    );
  }
}
