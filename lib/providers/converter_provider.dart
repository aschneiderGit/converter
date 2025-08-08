import 'package:flutter/material.dart';

enum FieldType { top, bottom }

class ConverterProvider extends ChangeNotifier {
  Map<FieldType, String> _amounts = {FieldType.top: '', FieldType.bottom: ''};
  FieldType _selectedField = FieldType.top;

  String? get topAmount => _amounts[FieldType.top];
  String? get bottomAmount => _amounts[FieldType.bottom];
  FieldType get selectedField => _selectedField;

  void addNumber(String number) {
    final currentValue = _amounts[_selectedField] ?? '';
    _amounts[_selectedField] = currentValue + number;
    notifyListeners();
  }

  void removeLastNumber() {
    final currentValue = _amounts[_selectedField] ?? '';
    if (currentValue.isNotEmpty) _amounts[_selectedField] = currentValue.substring(0, currentValue.length - 1);
    notifyListeners();
  }

  void eraseAmount() {
    _amounts[_selectedField] = '';
    notifyListeners();
  }

  void changeSelectedField(FieldType newPosition) {
    _selectedField = newPosition;
    notifyListeners();
  }

  void toggleAmount() {
    Map<FieldType, String> newAmounts = {
      FieldType.top: _amounts[FieldType.bottom] ?? '',
      FieldType.bottom: _amounts[FieldType.top] ?? '',
    };
    _amounts = newAmounts;
    notifyListeners();
  }
}
