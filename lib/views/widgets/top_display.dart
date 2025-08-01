import 'package:converter/core/theme/app_colors.dart';
import 'package:converter/views/widgets/amount_field.dart';
import 'package:converter/views/widgets/currency_dropdown.dart';
import 'package:flutter/material.dart';

class TopDisplay extends StatelessWidget {
  const TopDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        height: double.infinity,
        width: double.infinity,
        color: Theme.of(context).primary,
        child: Container(
          padding: const EdgeInsets.only(left: 24.0, right: 24.0),
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(flex: 3, child: AmountField()),
                  SizedBox(width: 32),
                  Flexible(
                    child: SizedBox(height: 65, child: CurrencyDropdown()),
                  ),
                ],
              ),
              Row(
                children: [
                  Flexible(flex: 3, child: AmountField()),
                  SizedBox(width: 32),
                  Flexible(
                    child: SizedBox(height: 65, child: CurrencyDropdown()),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
