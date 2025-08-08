class Currency {
  final int? id;
  final String code;
  final String name;
  final int countryId;
  final double rate;

  const Currency({this.id, required this.code, required this.name, required this.countryId, required this.rate});

  Map<String, dynamic> toMap() {
    return {'id': id, 'code': code, 'name': name, 'countryId': countryId};
  }

  factory Currency.fromMap(Map<String, dynamic> map) {
    return Currency(
      id: map['id'],
      code: map['code'],
      name: map['name'],
      countryId: map['countryId'],
      rate: map['rate'],
    );
  }
}
