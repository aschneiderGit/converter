import 'dart:async';
import 'dart:io';

import 'package:converter/core/constants/currencies.dart';
import 'package:converter/core/utils/print.dart';
import 'package:converter/data/databases/database_helper.dart';
import 'package:converter/data/models/currency.dart';
import 'package:converter/data/models/settings.dart';
import 'package:converter/data/services/exchange_rate.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

class CurrencyHelper {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<ResultOfGettingRates> initializeCurrency() async {
    try {
      Map<String, dynamic> data = await ExchangeRateService().getLastestRate();
      int dataTime = data["data_time"];
      Settings settings = await _dbHelper.getSettings();
      if (DateTime.fromMillisecondsSinceEpoch(dataTime * 1000, isUtc: true) == settings.dataTime) {
        return ResultOfGettingRates.upToDate;
      }
      Map<String, dynamic> latestRate = data["rates"];
      Map<String, Currency> allCurrencies = await getAllCurrency();
      List<Currency> currencyToAdd = [];
      List<Currency> currencyToUpdate = [];
      for (String code in latestRate.keys) {
        if (allCurrencies[code] == null) {
          if (initCurrencies[code] != null) {
            currencyToAdd.add(
              Currency(code: code, name: initCurrencies[code]!["name"]!, rate: latestRate[code].toDouble()),
            );
          } else {
            if (kDebugMode) {
              printOnDebug('$code missing in the initCurrencies file');
            }
          }
        } else if (allCurrencies[code]?.rate != latestRate[code]) {
          Currency? dbCurrency = allCurrencies[code];
          dbCurrency?.rate = latestRate[code].toDouble();
          currencyToUpdate.add(dbCurrency!);
        }
      }

      Database db = await _dbHelper.db;

      try {
        for (Currency currency in currencyToAdd) {
          await db.insert(tableCurrencies, currency.toMap());
          if (kDebugMode) {
            printOnDebug("add ${currency.code} in the db");
          }
        }
        if (kDebugMode) {
          printOnDebug("total currencies add ${currencyToAdd.length} ");
        }
        for (Currency currency in currencyToUpdate) {
          await db.update(tableCurrencies, currency.toMap(), where: 'id = ?', whereArgs: [currency.id]);
          if (kDebugMode) {
            printOnDebug("update the rate of ${currency.code} in the db");
          }
        }
        if (kDebugMode) {
          printOnDebug("total currencies update ${currencyToUpdate.length} ");
        }
        await db.update(tableSettings, {"data_time": dataTime});
        return ResultOfGettingRates.updated;
      } catch (e) {
        throw ('Exception details:\n $e');
      }
    } on SocketException {
      if (kDebugMode) {
        printOnDebug("No internet connection. Loading from cache...");
      }
      return ResultOfGettingRates.offline;
    } on TimeoutException {
      if (kDebugMode) {
        printOnDebug("Request timed out. Loading from cache...");
      }
      return ResultOfGettingRates.offline;
    } catch (e) {
      throw ('Exception details:\n $e');
    }
  }

  Future<Map<String, Currency>> getAllCurrency() async {
    try {
      Database db = await _dbHelper.db;
      final List<Map<String, dynamic>> maps = await db.query(tableCurrencies, orderBy: 'name');

      final Map<String, Currency> currencies = {for (var row in maps) row['code']: Currency.fromMap(row)};

      return currencies;
    } catch (e) {
      throw 'Error when getting all currencies :\n $e';
    }
  }

  Future<Currency> getCurrencyById(int currencyId) async {
    try {
      Database db = await _dbHelper.db;
      final List<Map<String, dynamic>> currencies = await db.query(
        tableCurrencies,
        where: 'id = ?',
        whereArgs: [currencyId],
      );
      if (currencies.isNotEmpty) {
        if (currencies.length == 1) {
          Map<String, dynamic> currency = currencies.first;
          return Currency.fromMap(currency);
        } else {
          throw ('should only got one Currency per code ');
        }
      }
      throw ('no Currency found for the id: $currencyId');
    } catch (e) {
      throw ('Exception details:\n $e');
    }
  }
}
