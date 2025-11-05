import 'package:converter/core/constants/device_size.dart';
import 'package:converter/core/l10n/app_localizations.dart';
import 'package:converter/core/theme/app_colors.dart';
import 'package:converter/core/theme/app_text_style.dart';
import 'package:converter/core/utils/screen.dart';
import 'package:converter/data/models/currency.dart';
import 'package:converter/providers/converter_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CurrencyDropdown extends StatefulWidget {
  final Currency? defaultCurrency;
  final Function(Currency?) currencyChanged;

  const CurrencyDropdown({super.key, this.defaultCurrency, required this.currencyChanged});

  @override
  State<CurrencyDropdown> createState() => _CurrencyDropdownState();
}

class _CurrencyDropdownState extends State<CurrencyDropdown> {
  void _openCurrencyPicker(BuildContext context, List<Currency> currencies, bool isSmallDevice) {
    ThemeData t = Theme.of(context);
    final searchController = TextEditingController();
    List<Currency> filtered = List.from(currencies);
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      backgroundColor: t.surface,
      isScrollControlled: true,
      isDismissible: true,
      useSafeArea: isSmallDevice,
      builder: (context) {
        final ThemeData t = Theme.of(context);
        final AppLocalizations l = AppLocalizations.of(context)!;

        return StatefulBuilder(
          builder: (context, setState) {
            void filterCurrencies(String query) {
              setState(() {
                filtered = currencies
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
                        controller: searchController,
                        style: Theme.of(context).textStyle,
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
                              widget.currencyChanged(currency);
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
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ConverterProvider>();
    final deviceSize = context.watch<DeviceSize>();
    final bool isSmallDevice = deviceSize == DeviceSize.small || deviceSize == DeviceSize.extraSmall;
    final ThemeData t = Theme.of(context);
    final AppLocalizations l = AppLocalizations.of(context)!;

    if (provider.isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    final currencies = provider.allCurrencies.values.toList();
    if (currencies.isEmpty) {
      return Text(l.noCurrency);
    }

    final selected = widget.defaultCurrency ?? currencies.first;

    return GestureDetector(
      onTap: () => _openCurrencyPicker(context, currencies, isSmallDevice),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(color: t.primaryVariant, borderRadius: BorderRadius.circular(16)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(selected.code, style: t.textStyle.copyWith(color: t.secondary, fontSize: 15)),
            Icon(Icons.arrow_right, color: t.onBackgroundVariant),
          ],
        ),
      ),
    );
  }
}
