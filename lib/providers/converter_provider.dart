import 'package:converter/data/databases/currency_helper.dart';
import 'package:converter/data/databases/database_helper.dart';
import 'package:converter/data/models/amount.dart';
import 'package:converter/data/models/currency.dart';
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

  DateTime? dataTime;
  FieldType get selectedField => _selectedField;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  ConverterProvider() {
    _init();
  }

  Future<void> _init() async {
    await CurrencyHelper().initializeCurrency();
    await fetchCurrencies();
    initializeAmount();
    await loadData();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadData() async {
    dataTime = await DatabaseHelper().getDataTime();
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

  void changeCurrency(FieldType position, Currency? value) {
    _amounts[position]?.currency = value!;
    // _amounts[FieldType.top]?.value = _amounts[FieldType.top]!.value;
    //_amounts[FieldType.bottom]?.value = _amounts[FieldType.bottom]!.value;
    convert();
  }

  void toggleAmount() {
    var currencyTop = _amounts[FieldType.top]?.currency;
    var currencyBot = _amounts[FieldType.bottom]?.currency;
    _amounts[FieldType.bottom]?.currency = currencyTop!;
    _amounts[FieldType.top]?.currency = currencyBot!;
    convert();
  }

  void convert() {
    final source = _selectedField == FieldType.top ? FieldType.top : FieldType.bottom;
    final target = _selectedField == FieldType.top ? FieldType.bottom : FieldType.top;

    amounts[target] = amounts[source]?.convert(amounts[target]!.currency);
    notifyListeners();
  }

  Future<void> fetchCurrencies() async {
    try {
      final data = await CurrencyHelper().getAllCurrency();
      _allCurrencies = data;
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
