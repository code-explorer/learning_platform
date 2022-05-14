// Helpful functions to get content

import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> fetchData(String url) async {
  http.Response response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response
    return response.body;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load file');
  }
}

Future<Map<String, dynamic>> getJsonData(String url) async {
  String jsonString = await fetchData(url);
  Map<String, dynamic> json = jsonDecode(jsonString);
  return json;
}
