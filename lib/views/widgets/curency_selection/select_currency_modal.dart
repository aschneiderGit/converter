import 'package:converter/core/l10n/app_localizations.dart';
import 'package:converter/core/theme/app_colors.dart';
import 'package:converter/core/theme/app_text_style.dart';
import 'package:converter/core/utils/screen.dart';
import 'package:converter/data/models/currency.dart';
import 'package:converter/views/widgets/curency_selection/currency_dropdown.dart';
import 'package:flutter/material.dart';

class SelectCurrencyModal extends StatefulWidget {
  final TextEditingController searchController;
  final List<Currency> currencies;
  final CurrencyDropdown currencyDropdown;

  const SelectCurrencyModal({
    super.key,
    required this.searchController,
    required this.currencies,
    required this.currencyDropdown,
  });

  @override
  State<SelectCurrencyModal> createState() => _SelectCurrencyModalState();
}

class _SelectCurrencyModalState extends State<SelectCurrencyModal> {
  @override
  Widget build(BuildContext context) {
    final ThemeData t = Theme.of(context);
    final AppLocalizations l = AppLocalizations.of(context)!;

    List<Currency> filtered = List.from(widget.currencies);
    void filterCurrencies(String query) {
      setState(() {
        filtered = widget.currencies
            .where(
              (c) =>
                  c.code.toLowerCase().contains(query.toLowerCase()) ||
                  (c.name.toLowerCase().contains(query.toLowerCase())),
            )
            .toList();
      });
    }

    return FractionallySizedBox(
      heightFactor: 0.95,
      child: SizedBox(
        height: getScreenHeight(context),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(color: t.primaryVariant, borderRadius: BorderRadius.circular(16)),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      child: Text(
                        AppLocalizations.of(context)!.cancel,
                        style: t.textStyle.copyWith(color: t.secondaryVariant, fontSize: 15),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Center(
                    child: Text(
                      l.selectCurrency,
                      style: Theme.of(context).textStyle.copyWith(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
              child: TextField(
                controller: widget.searchController,
                style: Theme.of(context).textStyle,
                autofocus: true,
                onChanged: filterCurrencies,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.searchCurrency,
                  prefixIcon: Icon(Icons.search, color: Colors.white),
                  hintStyle: Theme.of(context).textStyle,
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: t.secondary)),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: t.secondary)),
                  contentPadding: EdgeInsets.only(top: 8, bottom: 0),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filtered.length,
                itemBuilder: (context, index) {
                  final currency = filtered[index];
                  return ListTile(
                    title: Text(currency.code, style: t.textStyle.copyWith(fontSize: 20)),
                    subtitle: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: t.secondary, width: 1)),
                          ),
                          padding: EdgeInsets.only(bottom: 8),
                          child: Text(
                            currency.name,
                            style: t.textStyle.copyWith(fontSize: 15, fontWeight: FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      widget.currencyDropdown.currencyChanged(currency);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
