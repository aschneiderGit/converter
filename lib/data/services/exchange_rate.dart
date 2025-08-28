import 'dart:convert';

import 'package:http/http.dart' as http;

class ExchangeRateService {
  Future<Map<String, dynamic>> getLastestRate() async {
    const String baseUrl = "https://open.er-api.com/v6/latest/USD";
    final url = Uri.parse(baseUrl);

    final response = await http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body) as Map<String, dynamic>;
      return data["rates"];
    } else {
      throw Exception("Failed to load rates: {response.statusCode}");
    }
  }
}
