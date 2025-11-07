import 'package:test/test.dart';
import 'package:converter/data/models/currency.dart';

void main() {
  test(' currency toMap behaviour', () {
    var jsonCurrency = {'id': 1, 'code': 'EUR', 'name': 'Euro', 'rate': 1.0};
    var fromMap = Currency.fromMap(jsonCurrency);
    var currency = Currency(id: 1, code: 'EUR', name: 'Euro', rate: 1.0);
    var map = currency.toMap();

    expect(fromMap.id, equals(currency.id));
    expect(fromMap.code, equals(currency.code));
    expect(fromMap.name, equals(currency.name));
    expect(fromMap.rate, equals(currency.rate));

    expect(jsonCurrency['id'], equals(map["id"]));
    expect(jsonCurrency["code"], equals(map["code"]));
    expect(jsonCurrency["name"], equals(map["name"]));
    expect(jsonCurrency["rate"], equals(map["rate"]));
  });
}
