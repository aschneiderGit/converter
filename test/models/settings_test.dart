import 'package:test/test.dart';
import 'package:converter/data/models/Settings.dart';

import '../helpers/date_time.dart';

void main() {
  test('settings toMap behaviour', () {
    var jsonSettings = {
      'id': 1,
      'last_top_currency_id': 1,
      'last_bottom_currency_id': 2,
      "language": "FR",
      "data_time": 976467600,
    };
    var fromMap = Settings.fromMap(jsonSettings);
    var currency = Settings(
      id: 1,
      lastTopCurrencyId: 1,
      lastBottomCurrencyId: 2,
      language: "FR",
      dataTime: DateTime(2000, 12, 10, 17),
    );

    expect(fromMap.id, equals(currency.id));
    expect(fromMap.lastBottomCurrencyId, equals(currency.lastBottomCurrencyId));
    expect(fromMap.lastTopCurrencyId, equals(currency.lastTopCurrencyId));
    expect(fromMap.language, equals(currency.language));
    expectSameDate(fromMap.dataTime, currency.dataTime);
  });
}
