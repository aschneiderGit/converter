import 'package:converter/data/models/currency.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();
  static Database? _database;

  DatabaseHelper._instance();

  Future<Database> get db async {
    _database ??= await initDb();
    return _database!;
  }

  Future<Database> initDb() async {
    print("Initializing database...");
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'currencies.db');
    print("Initializing database... 2");
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    print("Creating currencies table...");
    await db.execute('''
    CREATE TABLE currencies (
      id INTEGER PRIMARY KEY,
      code TEXT,
      name TEXT,
      countryId INTEGER
    )
  ''');
    print("Currencies table created.");
  }

  Future<void> initializeCurrency() async {
    List<Currency> currencies = await getAllCurrency();
    if (currencies.isEmpty) {
      List<Currency> currencyToAdd = [
        Currency(code: 'EUR', name: 'Euros', countryId: 1),
        Currency(code: 'USD', name: 'American Dollars', countryId: 2),
        Currency(code: 'HKD', name: 'Hong Kong Dollars', countryId: 3),
        Currency(code: 'CHF', name: 'Swiss Franc', countryId: 4),
      ];
      Database db = await instance.db;

      try {
        for (Currency currency in currencyToAdd) {
          await db.insert('currencies', currency.toMap());
        }
      } catch (e) {
        throw ('Exception details:\n $e');
      }
    }
  }

  Future<List<Currency>> getAllCurrency() async {
    Database db = await instance.db;
    final List<Map<String, dynamic>> maps = await db.query('currencies');

    return List.generate(maps.length, (i) {
      return Currency(id: maps[i]['id'], code: maps[i]['code'], name: maps[i]['name'], countryId: maps[i]['countryId']);
    });
  }
}
