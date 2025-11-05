import 'dart:io';

import 'package:converter/core/utils/language.dart';
import 'package:converter/data/databases/currency_helper.dart';
import 'package:converter/data/databases/database_helper.dart';
import 'package:converter/data/models/amount.dart';
import 'package:converter/data/models/currency.dart';
import 'package:converter/data/models/settings.dart';
import 'package:converter/data/services/exchange_rate.dart';
import 'package:flutter/material.dart';

enum FieldType { top, bottom }

class ConverterProvider extends ChangeNotifier {
  Map<String, Currency> _allCurrencies = {};
  Map<FieldType, Amount?> _amounts = {FieldType.top: null, FieldType.bottom: null};
  FieldType _selectedField = FieldType.top;

  Amount? get topAmount => _amounts[FieldType.top];
  Amount? get bottomAmount => _amounts[FieldType.bottom];
  Map<FieldType, Amount?> get amounts => _amounts;
  Map<String, Currency> get allCurrencies => _allCurrencies;

  late Settings setting;
  FieldType get selectedField => _selectedField;

  bool _isLoading = true;
  bool _refreshing = false;
  bool _online = false;
  bool _notInstanciate = false;
  bool get isLoading => _isLoading;
  bool get refreshing => _refreshing;
  bool get online => _online;
  bool get notInstanciate => _notInstanciate;

  ConverterProvider() {
    init();
  }

  Future<void> init() async {
    _notInstanciate = false;
    _isLoading = true;
    _online = false;
    notifyListeners();
    ResultOfGettingRates res = await CurrencyHelper().initializeCurrency();
    _online = res != ResultOfGettingRates.offline;
    await fetchCurrenciesFromDB();
    if (!_notInstanciate) {
      initializeAmount();
    }
    await loadSettings();

    _isLoading = false;
    notifyListeners();
  }

  Future<ResultOfGettingRates> refresh() async {
    _refreshing = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1));
    ResultOfGettingRates res = await CurrencyHelper().initializeCurrency();
    res != ResultOfGettingRates.offline;
    if (res == ResultOfGettingRates.offline || res == ResultOfGettingRates.upToDate) {
      _refreshing = false;
      notifyListeners();
      return res;
    }
    await fetchCurrenciesFromDB();
    await loadSettings();
    _refreshing = false;
    notifyListeners();
    return res;
  }

  Future<void> loadSettings() async {
    setting = await DatabaseHelper().getSettings();
    amounts[FieldType.top]?.currency = await CurrencyHelper().getCurrencyById(setting.lastTopCurrencyId);
    amounts[FieldType.bottom]?.currency = await CurrencyHelper().getCurrencyById(setting.lastBottomCurrencyId);

    notifyListeners();
  }

  void addNumber(String number) {
    final String currentValue = amounts[_selectedField]?.value ?? '';
    if (number == '.' && currentValue.contains('.')) {
      amounts[_selectedField]?.value = currentValue;
    } else {
      amounts[_selectedField]?.value = currentValue + number;
    }
    convert();
  }

  void removeLastNumber() {
    final String currentValue = _amounts[_selectedField]?.value ?? '';
    if (currentValue.isNotEmpty) {
      _amounts[_selectedField]?.value = (currentValue.substring(0, currentValue.length - 1));
    }
    convert();
  }

  void eraseAmount() {
    _amounts[_selectedField]?.value = '';
    convert();
  }

  void changeSelectedField(FieldType newPosition) {
    _selectedField = newPosition;
    notifyListeners();
  }

  void changeCurrency(FieldType position, Currency? value) async {
    _amounts[position]?.currency = value!;
    saveCurrencySelected();
    convert();
  }

  void toggleAmount() {
    var currencyTop = _amounts[FieldType.top]?.currency;
    var currencyBot = _amounts[FieldType.bottom]?.currency;
    _amounts[FieldType.bottom]?.currency = currencyTop!;
    _amounts[FieldType.top]?.currency = currencyBot!;
    saveCurrencySelected();
    convert();
  }

  Future<void> saveCurrencySelected() async {
    setting.lastTopCurrencyId = _amounts[FieldType.top]!.currency.id!;
    setting.lastBottomCurrencyId = _amounts[FieldType.bottom]!.currency.id!;
    await DatabaseHelper().setSettings(setting);
  }

  Future<void> switchLanguage(BuildContext context) async {
    setting.language = getNextLocale(context).languageCode;
    await DatabaseHelper().setSettings(setting);
    notifyListeners();
  }

  void convert() {
    final source = _selectedField == FieldType.top ? FieldType.top : FieldType.bottom;
    final target = _selectedField == FieldType.top ? FieldType.bottom : FieldType.top;

    amounts[target] = amounts[source]?.convert(amounts[target]!.currency);
    notifyListeners();
  }

  Future<void> fetchCurrenciesFromDB() async {
    try {
      final data = await CurrencyHelper().getAllCurrency();
      if (data.isEmpty) {
        _notInstanciate = true;
      } else {
        _allCurrencies = data;
      }
    } catch (e) {
      throw ('Exception details:\n $e');
    } finally {
      notifyListeners();
    }
  }

  void initializeAmount() {
    _amounts = {
      FieldType.top: Amount(currency: _allCurrencies.values.first),
      FieldType.bottom: Amount(currency: _allCurrencies.values.last),
    };
    notifyListeners();
  }
}
