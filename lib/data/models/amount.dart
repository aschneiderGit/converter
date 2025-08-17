import 'package:converter/data/models/currency.dart';

class Amount {
  String value;
  Currency currency;

  Amount({this.value = '', required this.currency});

  double get valueAsDouble => value as double;

  set setValue(String newValue) {
    value = newValue;
  }

  set setCurrency(Currency newCurrency) {
    currency = newCurrency;
  }

  Amount convert(Currency toCurrency) {
    return Amount(value: (valueAsDouble * (currency.rate / toCurrency.rate)).toString(), currency: toCurrency);
  }
}
