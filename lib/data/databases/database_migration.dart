import 'package:converter/data/databases/database_helper.dart';
import 'package:sqflite/sqflite.dart';

createCurrencySelectionHistoryInSettings(Database db) async {
  try {
    print("add currency history column in $tableSettings table...");
    await db.execute('''
  ALTER TABLE $tableSettings
  ADD COLUMN last_top_currency_id INTEGER NOT NULL DEFAULT 1;
''');
    await db.execute('''
  ALTER TABLE $tableSettings
  ADD COLUMN last_bottom_currency_id INTEGER NOT NULL DEFAULT 2;
''');
  } catch (e) {
    throw ('Failed to add currency history column in $tableSettings table\n details:\n $e');
  }
}
