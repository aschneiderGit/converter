import 'package:converter/core/utils/print.dart';
import 'package:converter/data/databases/database_migration.dart';
import 'package:converter/data/models/settings.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final String tableCurrencies = 'currencies';
final String tableSettings = 'settings';
final int dbVersion = 2;

enum AppLanguage { fr, eng }

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();
  static Database? _database;

  factory DatabaseHelper() {
    return instance;
  }

  DatabaseHelper._instance();

  Future<Database> get db async {
    _database ??= await initDb();
    return _database!;
  }

  Future<Database> initDb() async {
    if (kDebugMode) {
      printOnDebug("Initializing database...");
    }
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'converter.db');
    return await openDatabase(
      path,
      version: dbVersion,
      onCreate: (Database db, int newVersion) async {
        for (int version = 0; version < newVersion; version++) {
          await _performDbByVersion(db, version + 1);
        }
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        for (int version = oldVersion; version < newVersion; version++) {
          await _performDbByVersion(db, version + 1);
        }
      },
    );
  }

  Future<Settings> getSettings() async {
    try {
      final db = await this.db;
      List<Map<String, dynamic>> setting = await db.query(tableSettings);
      return Settings.fromMap(setting.first);
    } catch (e) {
      throw ('Exception details:\n $e');
    }
  }

  Future<void> setSettings(Settings s) async {
    try {
      Database db = _database!;
      await db.update(tableSettings, {
        "last_top_currency_id": s.lastTopCurrencyId,
        "last_bottom_currency_id": s.lastBottomCurrencyId,
        "language": s.language,
      });
    } catch (e) {
      throw ('Exception details:\n $e');
    }
  }

  _performDbByVersion(Database db, version) async {
    switch (version) {
      case 1:
        await _onCreate(db, version);
        break;
      case 2:
        await createCurrencySelectionHistoryInSettings(db);
        break;
    }
  }

  Future _onCreate(Database db, int version) async {
    try {
      if (kDebugMode) {
        printOnDebug("Creating $tableCurrencies table...");
      }
      await db.execute('''
      CREATE TABLE $tableCurrencies (
      id INTEGER PRIMARY KEY,
      code TEXT NOT NULL UNIQUE,
      name TEXT NOT NULL,
      rate REAL NOT NULL
      )
      ''');
      printOnDebug("Creating $tableSettings table...");
      await db.execute('''
      CREATE TABLE $tableSettings (
      id INTEGER PRIMARY KEY,
      language TEXT ,
      data_time INT 
      )
      ''');
      await db.execute('''
      INSERT INTO $tableSettings (id, language, data_time)
      VALUES( 0, "${AppLanguage.fr.name}", NULL);
      ''');
      await db.execute('''
      CREATE TRIGGER ${tableSettings}_no_insert
      BEFORE INSERT ON $tableSettings
      WHEN (SELECT COUNT(*) FROM $tableSettings) >= 1
      BEGIN
          SELECT RAISE(FAIL, 'only one row!');
      END;
      ''');
      printOnDebug("Converter tables created.");
    } catch (e) {
      throw ('Failed the onCreate Database\n details:\n $e');
    }
  }
}
