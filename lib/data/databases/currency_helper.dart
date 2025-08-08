import 'package:converter/data/databases/database_helper.dart';
import 'package:converter/data/models/currency.dart';
import 'package:sqflite/sqflite.dart';

class CurrencyHelper {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<void> initializeCurrency() async {
    List<Currency> allCurrencies = await getAllCurrency();
    if (allCurrencies.isEmpty) {
      List<Currency> currencyToAdd = [
        Currency(code: 'EUR', name: 'Euros', countryId: 1, rate: 0.5),
        Currency(code: 'USD', name: 'American Dollars', countryId: 2, rate: 1),
        Currency(code: 'HKD', name: 'Hong Kong Dollars', countryId: 3, rate: 4),
        Currency(code: 'CHF', name: 'Swiss Franc', countryId: 4, rate: 0.25),
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

  Future<List<Currency>> getAllCurrency() async {
    try {
      Database db = await _dbHelper.db;
      final List<Map<String, dynamic>> maps = await db.query(tableCurrencies);

      return List.generate(maps.length, (i) {
        return Currency(
          id: maps[i]['id'],
          code: maps[i]['code'],
          name: maps[i]['name'],
          rate: maps[i]['rate'],
          countryId: maps[i]['countryId'],
        );
      });
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
