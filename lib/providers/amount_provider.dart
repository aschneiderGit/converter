import 'package:flutter/material.dart';

class AmountProvider with ChangeNotifier {
  final Map<String, String> _amount = {'top': '123', 'bottom': '456'};

  String? get topAmount => _amount['top'];
  String? get bottomAmount => _amount['bottom'];

  void writeAmount(String position, String newValue) {
    _amount[position] = newValue;
    notifyListeners();
  }
}
