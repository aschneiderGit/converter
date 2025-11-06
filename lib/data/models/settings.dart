class Settings {
  final int? id;
  int lastTopCurrencyId;
  int lastBottomCurrencyId;
  String language;
  final DateTime dataTime;

  Settings({
    this.id,
    required this.lastTopCurrencyId,
    required this.lastBottomCurrencyId,
    required this.language,
    required this.dataTime,
  });

  factory Settings.fromMap(Map<String, dynamic> map) {
    final dateTime = map['data_time'] ?? 0;
    return Settings(
      id: map['id'],
      lastTopCurrencyId: map['last_top_currency_id'],
      lastBottomCurrencyId: map['last_bottom_currency_id'],
      language: map['language'],
      dataTime: DateTime.fromMillisecondsSinceEpoch(dateTime * 1000, isUtc: true),
    );
  }
}
