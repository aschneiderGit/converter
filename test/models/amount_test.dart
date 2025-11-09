import 'package:test/test.dart';
import 'package:converter/data/models/currency.dart';
import 'package:converter/data/models/amount.dart';

void main() {
  group('Amount', () {
    final eur = Currency(id: 1, code: 'EUR', name: 'Euro', rate: 1.0);
    final usd = Currency(id: 2, code: 'USD', name: 'Dollar', rate: 1.2);

    test('valueAsDouble returns correct double', () {
      final amount = Amount(value: '10', currency: eur);
      expect(amount.valueAsDouble, equals(10.0));
    });

    test('valueAsDouble returns correct 0.0 if not a number or empty', () {
      final amountEmpty = Amount(value: '', currency: eur);
      final amountLetter = Amount(value: 'abc', currency: eur);
      expect(amountEmpty.valueAsDouble, equals(0.0));
      expect(amountLetter.valueAsDouble, equals(0.0));
    });

    test('setCurrency updates currency', () {
      final amount = Amount(value: '10', currency: eur);
      amount.setCurrency = usd;
      expect(amount.currency.code, equals('USD'));
      expect(amount.value, equals('10'));
    });

    test('convert changes currency and value correctly', () {
      final amount = Amount(value: '10', currency: eur);
      final converted = amount.convert(usd);

      final amountEmpty = Amount(value: '', currency: eur);
      final convertedEmpty = amountEmpty.convert(usd);

      expect(converted.currency.code, equals('USD'));
      expect(converted.valueAsDouble, equals(12.0));

      expect(convertedEmpty.currency.code, equals('USD'));
      expect(convertedEmpty.valueAsDouble, equals(0.0));
    });

    test('convert return only 3 digit after decimal', () {
      final amount = Amount(value: '1', currency: eur);
      final abc = Currency(id: 2, code: 'ABC', name: 'alpha', rate: 1.1111111111);
      final converted = amount.convert(abc);

      expect(converted.value, equals('1.111'));
    });

    test('convert remove useless 0 after decimal', () {
      final amount = Amount(value: '1', currency: eur);
      final xyz = Currency(id: 2, code: 'XYZ', name: 'end', rate: 1.2003);
      final converted = amount.convert(xyz);

      expect(converted.value, equals('1.2'));
    });
  });
}
