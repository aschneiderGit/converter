class Rate {
  final int? id;
  final String code;
  final double rate;

  const Rate({this.id, required this.code, required this.rate});

  Map<String, dynamic> toMap() {
    return {'id': id, 'code': code, 'rate': rate};
  }

  factory Rate.fromMap(Map<String, dynamic> map) {
    return Rate(id: map['id'], code: map['code'], rate: map['rate']);
  }
}
