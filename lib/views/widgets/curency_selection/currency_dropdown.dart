import 'package:converter/core/constants/device_size.dart';
import 'package:converter/core/l10n/app_localizations.dart';
import 'package:converter/core/theme/app_colors.dart';
import 'package:converter/core/theme/app_text_style.dart';
import 'package:converter/data/models/currency.dart';
import 'package:converter/providers/converter_provider.dart';
import 'package:converter/views/widgets/curency_selection/select_currency_modal.dart';
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
  void _openCurrencyPicker(BuildContext context, List<Currency> currencies, bool isSmallDevice, String language) {
    ThemeData t = Theme.of(context);
    final searchController = TextEditingController();
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      backgroundColor: t.surface,
      isScrollControlled: true,
      isDismissible: true,
      useSafeArea: isSmallDevice,
      builder: (context) {
        return Localizations.override(
          context: context,
          locale: Locale(language),
          child: StatefulBuilder(
            builder: (context, setState) {
              return SelectCurrencyModal(
                searchController: searchController,
                currencyDropdown: widget,
                currencies: currencies,
              );
            },
          ),
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
      onTap: () => _openCurrencyPicker(context, currencies, isSmallDevice, provider.setting.language),
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
