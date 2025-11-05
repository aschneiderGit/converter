import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

enum ResultOfGettingRates { updated, offline, upToDate }

class ExchangeRateService {
  Future<Map<String, dynamic>> getLastestRate() async {
    const String baseUrl = "https://open.er-api.com/v6/latest/USD";
    final url = Uri.parse(baseUrl);

    final response = await http
        .get(url)
        .timeout(Duration(seconds: 1), onTimeout: () => throw TimeoutException("Can't access the API"));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body) as Map<String, dynamic>;
      return {"rates": data["rates"], "data_time": data["time_last_update_unix"]};
    } else {
      throw Exception("Failed to load rates: {response.statusCode}");
    }
  }
}
