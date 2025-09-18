class Settings {
  final int? id;
  int lastTopCurrencyId;
  int lastBottomCurrencyId;
  final String language;
  final DateTime dataTime;

  Settings({
    this.id,
    required this.lastTopCurrencyId,
    required this.lastBottomCurrencyId,
    required this.language,
    required this.dataTime,
    last_,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'last_top_currency_id': lastTopCurrencyId,
      'last_bottom_currency_id': lastBottomCurrencyId,
      'language': language,
      'data_time': dataTime,
    };
  }

  factory Settings.fromMap(Map<String, dynamic> map) {
    return Settings(
      id: map['id'],
      lastTopCurrencyId: map['last_top_currency_id'],
      lastBottomCurrencyId: map['last_bottom_currency_id'],
      language: map['language'],
      dataTime: DateTime.fromMillisecondsSinceEpoch(map['data_time'] * 1000, isUtc: true),
    );
  }
}
