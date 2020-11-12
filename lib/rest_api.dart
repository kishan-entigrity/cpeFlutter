import 'dart:convert';

import 'package:http/http.dart' as http;

class URLs {
  static const String BASE_URL = 'https://my-cpe.com/api/v3/';
}

Future loginUser(String email, String password, String device_id,
    String device_token, String device_type) async {
  String urls = URLs.BASE_URL + 'login';
  final response = await http.post(
    urls,
    headers: {'Accept': 'Application/json'},
    body: {
      'email': email,
      'password': password,
      'device_id': device_id,
      'device_token': device_token,
      'device_type': device_type
    },
  );
  var convertDataToJson = jsonDecode(response.body);
  return convertDataToJson;
}
