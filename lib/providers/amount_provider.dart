import 'package:flutter/material.dart';

enum FieldType { top, bottom }

class AmountProvider extends ChangeNotifier {
  final Map<FieldType, String> _amounts = {FieldType.top: '', FieldType.bottom: ''};
  FieldType _selectedField = FieldType.top;

  String? get topAmount => _amounts[FieldType.top];
  String? get bottomAmount => _amounts[FieldType.bottom];
  FieldType get selectedField => _selectedField;

  void addNumber(String number) {
    final currentValue = _amounts[_selectedField] ?? '';
    _amounts[_selectedField] = currentValue + number;
    notifyListeners();
  }

  void changeSelectedField(FieldType newPosition) {
    _selectedField = newPosition;
    notifyListeners();
  }
}
