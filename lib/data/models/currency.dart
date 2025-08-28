class Currency {
  final int? id;
  final String code;
  final String name;
  double rate;

  Currency({this.id, required this.code, required this.name, required this.rate});

  set setRate(double newRate) {
    rate = newRate;
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'code': code, 'name': name, 'rate': rate};
  }

  factory Currency.fromMap(Map<String, dynamic> map) {
    return Currency(id: map['id'], code: map['code'], name: map['name'], rate: map['rate']);
  }
}
