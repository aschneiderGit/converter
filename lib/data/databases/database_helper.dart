import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final String tableCurrencies = 'currencies';
final String tableSettings = 'settings';
final int dbVersion = 1;

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
    print("Initializing database...");
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'converter.db');
    return await openDatabase(path, version: dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    try {
      print("Creating $tableCurrencies table...");
      await db.execute('''
      CREATE TABLE $tableCurrencies (
      id INTEGER PRIMARY KEY,
      code TEXT NOT NULL UNIQUE,
      name TEXT NOT NULL,
      rate REAL NOT NULL
      )
      ''');
      print("Creating $tableSettings table...");
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
      print("Converter tables created.");
    } catch (e) {
      throw ('Failed the onCreate Database\n details:\n $e');
    }
  }

  Future<DateTime> getDataTime() async {
    try {
      Database db = _database!;
      final List<Map<String, dynamic>> unixDataTime = await db.query(tableSettings, columns: ["data_time"]);
      DateTime dataTime = DateTime.fromMillisecondsSinceEpoch(unixDataTime.first["data_time"] * 1000, isUtc: true);
      return dataTime;
    } catch (e) {
      throw ('Exception details:\n $e');
    }
  }
}
