import 'package:converter/data/models/currency.dart';

class Amount {
  String value;
  Currency currency;

  Amount({this.value = '', required this.currency});

  double get valueAsDouble => double.tryParse(value) ?? 0.0;

  set setValue(String newValue) {
    value = newValue;
  }

  set setCurrency(Currency newCurrency) {
    currency = newCurrency;
  }

  Amount convert(Currency toCurrency) {
    RegExp regex = RegExp(r'(\.?0+)(?!.*\d)'); //remove useless 0
    String res = valueAsDouble == 0.0
        ? ''
        : (valueAsDouble * (toCurrency.rate / currency.rate)).toStringAsFixed(3).replaceAll(regex, '');
    return Amount(value: res, currency: toCurrency);
  }
}
