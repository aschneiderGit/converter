import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final String tableCurrencies = 'currencies';
final String tableRates = 'rates';

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
    print("Initializing database... 2");
    return await openDatabase(path, version: 1, onCreate: _onCreate);
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
      print("Converter tables created.");
    } catch (e) {
      throw ('Failed the onCreate Database\n details:\n $e');
    }
  }
}
