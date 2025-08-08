import 'package:converter/core/l10n/app_localizations.dart';
import 'package:converter/core/theme/app_colors.dart';
import 'package:converter/core/theme/app_text_style.dart';
import 'package:converter/providers/amount_provider.dart';
import 'package:converter/views/widgets/amount_field.dart';
import 'package:converter/views/widgets/circle_button/icon_button.dart';
import 'package:converter/views/widgets/currency_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopDisplay extends StatelessWidget {
  const TopDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 2,
      child: Container(
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
                      currencyAmmountRow(FieldType.top),
                      SizedBox(height: 12),
                      currencyAmmountRow(FieldType.bottom),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                Flexible(
                  flex: 1,
                  child: Container(
                    margin: const EdgeInsets.only(top: 32.0),
                    child: iconButton(
                      icon: Icons.cached,
                      secondary: true,
                      fontSize: 55,
                      handleOnPressed: () => context.read<AmountProvider>().toggleAmount(),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 32),
              height: 60,
              child: Center(
                child: Text(
                  AppLocalizations.of(context)!.updateTime,
                  style: Theme.of(context).textStyle.copyWith(fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row currencyAmmountRow(FieldType position) {
    return Row(
      children: [
        Flexible(flex: 7, child: AmountField(position: position)),
        SizedBox(width: 24),
        Flexible(flex: 3, child: SizedBox(height: 77, child: CurrencyDropdown())),
      ],
    );
  }
}
