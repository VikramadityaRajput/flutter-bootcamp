import 'dart:convert';

import 'package:http/http.dart' as http;

import 'api_keys.dart';

// The list of fiat currencies the user can pick from.
const List<String> currenciesList = [
  'AUD', 'BRL', 'CAD', 'CNY', 'EUR', 'GBP', 'HKD', 'IDR', 'ILS', 'INR',
  'JPY', 'MXN', 'NOK', 'NZD', 'PLN', 'RON', 'RUB', 'SEK', 'SGD', 'USD', 'ZAR',
];

// The cryptocurrencies we show a price for.
const List<String> cryptoList = ['BTC', 'ETH', 'LTC'];

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';

// Fetches the price of each crypto in the chosen currency from coinapi.io.
// If the request fails (e.g. 403 quota, no network), it falls back to a mock
// number so the UI still shows something.
class CoinData {
  Future<Map<String, String>> getCoinData(String selectedCurrency) async {
    Map<String, String> cryptoPrices = {};

    for (String crypto in cryptoList) {
      final requestURL =
          '$coinAPIURL/$crypto/$selectedCurrency?apikey=$kCoinApiKey';

      try {
        http.Response response = await http.get(Uri.parse(requestURL));
        if (response.statusCode == 200) {
          double rate = (jsonDecode(response.body)['rate'] as num).toDouble();
          cryptoPrices[crypto] = rate.toStringAsFixed(0);
          continue; // got a real price — on to the next crypto
        } else {
          // ignore: avoid_print
          print(
            'CoinAPI $crypto/$selectedCurrency: HTTP ${response.statusCode} — using mock',
          );
        }
      } catch (e) {
        // ignore: avoid_print
        print('CoinAPI request failed ($e) — using mock');
      }

      // Fallback so the app never shows blanks.
      cryptoPrices[crypto] = _mockPrice(crypto, selectedCurrency);
    }

    return cryptoPrices;
  }

  String _mockPrice(String crypto, String currency) {
    final base = crypto == 'BTC'
        ? 60000.0
        : crypto == 'ETH'
            ? 3000.0
            : 80.0;
    return (base * _mockFactor(currency)).toStringAsFixed(0);
  }

  double _mockFactor(String currency) {
    if (currency == 'USD') return 1.0;
    final sum = currency.codeUnits.fold<int>(0, (a, b) => a + b);
    return 0.5 + (sum % 200) / 100;
  }
}
