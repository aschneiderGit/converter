import 'package:converter/data/databases/currency_helper.dart';
import 'package:converter/data/models/amount.dart';
import 'package:converter/data/models/currency.dart';
import 'package:flutter/material.dart';

enum FieldType { top, bottom }

class ConverterProvider extends ChangeNotifier {
  List<Currency> _allCurrencies = [];
  Map<FieldType, Amount?> _amounts = {FieldType.top: null, FieldType.bottom: null};
  FieldType _selectedField = FieldType.top;

  Amount? get topAmount => _amounts[FieldType.top];
  Amount? get bottomAmount => _amounts[FieldType.bottom];
  Map<FieldType, Amount?> get amounts => _amounts;
  FieldType get selectedField => _selectedField;

  ConverterProvider() {
    _init();
  }
  Future<void> _init() async {
    await fetchCurrencies();
    initializeAmount();
  }

  void addNumber(String number) {
    final String currentValue = _amounts[_selectedField]?.value ?? '';
    _amounts[_selectedField]?.value = currentValue + number;
    notifyListeners();
  }

  void removeLastNumber() {
    final String currentValue = _amounts[_selectedField]?.value ?? '';
    if (currentValue.isNotEmpty) {
      _amounts[_selectedField]?.value = (currentValue.substring(0, currentValue.length - 1));
    }
    notifyListeners();
  }

  void eraseAmount() {
    _amounts[_selectedField]?.value = '';
    notifyListeners();
  }

  void changeSelectedField(FieldType newPosition) {
    _selectedField = newPosition;
    notifyListeners();
  }

  void toggleAmount() {
    Map<FieldType, Amount?> newAmounts = {
      FieldType.top: _amounts[FieldType.bottom],
      FieldType.bottom: _amounts[FieldType.top],
    };
    _amounts = newAmounts;
    notifyListeners();
  }

  Future<void> fetchCurrencies() async {
    try {
      notifyListeners();
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
      FieldType.top: Amount(currency: _allCurrencies.first),
      FieldType.bottom: Amount(currency: _allCurrencies.last),
    };
  }
}
