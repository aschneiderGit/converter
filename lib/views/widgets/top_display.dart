import 'package:converter/core/theme/app_colors.dart';
import 'package:converter/views/widgets/amount_field.dart';
import 'package:converter/views/widgets/circle_button/icon_button.dart';
import 'package:converter/views/widgets/currency_dropdown.dart';
import 'package:flutter/material.dart';

class TopDisplay extends StatelessWidget {
  const TopDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Container(
        padding: const EdgeInsets.only(left: 24.0, top: 12, right: 12),
        color: Theme.of(context).primary,
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  flex: 4,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [currencyAmmountRow(), currencyAmmountRow()],
                  ),
                ),
                SizedBox(width: 12),
                reverseButton(),
              ],
            ),
            Expanded(child: Container(color: Colors.redAccent)),
          ],
        ),
      ),
    );
  }

  Row currencyAmmountRow() {
    return Row(
      children: [
        Flexible(flex: 3, child: AmountField()),
        SizedBox(width: 24),
        Flexible(child: SizedBox(height: 65, child: CurrencyDropdown())),
      ],
    );
  }
}

class reverseButton extends StatelessWidget {
  const reverseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: SizedBox(child: iconButton(icon: Icons.cached, secondary: true)),
    );
  }
}
