import 'dart:convert';

import 'package:http/http.dart' as http;

// Makes a real network request to the given URL and returns the decoded JSON.
class NetworkHelper {
  NetworkHelper(this.url);

  final String url;

  Future<dynamic> getData() async {
    // Fire the HTTP GET and wait for the server to respond.
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // 200 = OK. The body is a JSON string; decode it into a Dart Map.
      String data = response.body;
      return jsonDecode(data);
    } else {
      // Non-200 means something went wrong:
      //   401 = API key not valid/active yet, 404 = city not found, etc.
      // ignore: avoid_print
      print('Weather request failed: HTTP ${response.statusCode}');
      return null;
    }
  }
}
