import 'package:converter/data/databases/database_helper.dart';
import 'package:converter/data/models/currency.dart';
import 'package:sqflite/sqflite.dart';

class CurrencyHelper {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<void> initializeCurrency() async {
    Map<String, Currency> allCurrencies = await getAllCurrency();
    if (allCurrencies.isEmpty) {
      List<Currency> currencyToAdd = [
        Currency(code: 'EUR', name: 'Euros', rate: 0.5, countryId: 1),
        Currency(code: 'USD', name: 'American Dollars', rate: 1, countryId: 2),
        Currency(code: 'HKD', name: 'Hong Kong Dollars', rate: 4, countryId: 3),
        Currency(code: 'CHF', name: 'Swiss Franc', rate: 0.25, countryId: 4),
      ];
      Database db = await _dbHelper.db;

      try {
        for (Currency currency in currencyToAdd) {
          await db.insert(tableCurrencies, currency.toMap());
        }
      } catch (e) {
        throw ('Exception details:\n $e');
      }
    }
  }

  Future<Map<String, Currency>> getAllCurrency() async {
    try {
      Database db = await _dbHelper.db;
      final List<Map<String, dynamic>> maps = await db.query(tableCurrencies);

      final Map<String, Currency> currencies = {for (var row in maps) row['code']: Currency.fromMap(row)};

      return currencies;
    } catch (e) {
      throw 'Error when getting all currencies :\n $e';
    }
  }

  Future<Currency> getCurrencyByCode(String currencyCode) async {
    try {
      Database db = await _dbHelper.db;
      final List<Map<String, dynamic>> currencies = await db.query(
        tableCurrencies,
        where: 'code = ?',
        whereArgs: [currencyCode],
      );
      if (currencies.isNotEmpty) {
        if (currencies.length == 1) {
          Map<String, dynamic> currency = currencies.first;
          return Currency(
            id: currency['id'],
            name: currency['name'],
            code: currency['code'],
            rate: currency['rate'],
            countryId: currency['countryId'],
          );
        } else {
          throw ('should only got one CUrrency per code ');
        }
      }
      throw ('no Currency found for the code: $currencyCode');
    } catch (e) {
      throw ('Exception details:\n $e');
    }
  }
}
