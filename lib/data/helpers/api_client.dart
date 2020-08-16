import 'dart:convert';
import '../constants.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  final http.Client client;

  ApiClient({this.client}) : assert(client != null);

  Future<dynamic> fetchJson(String endPoint) async {
    final url = '$baseURL$endPoint';
    final resp = await client.get(url);

    if (resp.statusCode != OK_RESPONSE) {
      throw Exception('fetchJson error occured: ${resp.statusCode.toString()}');
    }

    return jsonDecode(resp.body);
  }
}
