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
    RegExp regex = RegExp(r'([.]*0)(?!.*\d)');
    return valueAsDouble == 0.0
        ? Amount(value: '', currency: toCurrency)
        : Amount(
            value: (valueAsDouble * (toCurrency.rate / currency.rate)).toString().replaceAll(regex, ''),
            currency: toCurrency,
          );
  }
}
