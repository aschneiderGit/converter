import 'package:converter/data/models/currency.dart';

class Amount {
  final double value;
  final Currency currency;

  const Amount({required this.value, required this.currency});

  Amount convert(Currency toCurrency) {
    return Amount(value: value * (currency.rate / toCurrency.rate), currency: toCurrency);
  }
}
