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

Future changePassword(String authToken, String current_password,
    String new_password, String confirm_password) async {
  String urls = URLs.BASE_URL + 'change-password';
  final response = await http.post(
    urls,
    headers: {
      'Accept': 'Application/json',
      'Authorization': 'Bearer $authToken',
    },
    body: {
      'current_password': current_password,
      'new_password': new_password,
      'confirm_password': confirm_password
    },
  );
  var convertDataToJson = jsonDecode(response.body);
  return convertDataToJson;
}

Future video_duration(String authToken, String webinar_id,
    String play_time_duration, String presentation_length) async {
  String urls = URLs.BASE_URL + 'webinar/video-duration';
  final response = await http.post(
    urls,
    headers: {
      'Accept': 'Application/json',
      'Authorization': 'Bearer $authToken',
    },
    body: {
      'webinar_id': webinar_id,
      'play_time_duration': play_time_duration,
      'presentation_length': presentation_length
    },
  );
  var convertDataToJson = jsonDecode(response.body);
  return convertDataToJson;
}

Future contactUs(String email, String subject) async {
  String urls = URLs.BASE_URL + 'contact-us/query';
  final response = await http.post(
    urls,
    headers: {
      'Accept': 'Application/json',
      // 'Authorization': 'Bearer $authToken',
    },
    body: {
      'Message': email,
      'Subject': subject,
    },
  );
  var convertDataToJson = jsonDecode(response.body);
  return convertDataToJson;
}

Future homeWebinarList(
    String authToken,
    String start,
    String limit,
    String topic_of_interest,
    String subject_area,
    String webinar_key_text,
    String webinar_type,
    String date_filter,
    String filter_price) async {
  String urls = URLs.BASE_URL + 'webinar/list';

  String updatedToken = '';
  if (authToken.length == 0) {
    // Considered as guest mode..
    updatedToken = '';
  } else {
    // Consider as auth user..
    updatedToken = 'Bearer $authToken';
  }
  final response = await http.post(
    urls,
    headers: {
      'Accept': 'Application/json',
      'Authorization': '$updatedToken',
    },
    body: {
      'start': start,
      'limit': limit,
      'topic_of_interest': topic_of_interest,
      'subject_area': subject_area,
      'webinar_key_text': webinar_key_text,
      'webinar_type': webinar_type,
      'date_filter': date_filter,
      'filter_price': filter_price,
    },
  );
  var convertDataToJson = jsonDecode(response.body);
  return convertDataToJson;
}

Future getPrivacyPolicy() async {
  String urls = URLs.BASE_URL + 'cms/privacy_policy';
  final response = await http.get(
    urls,
    headers: {
      'Accept': 'Application/json',
    },
  );
  var convertDataToJson = jsonDecode(response.body);
  return convertDataToJson;
}

Future getTermsAndConditions() async {
  String urls = URLs.BASE_URL + 'cms/terms_condition';
  final response = await http.get(
    urls,
    headers: {
      'Accept': 'Application/json',
    },
  );
  var convertDataToJson = jsonDecode(response.body);
  return convertDataToJson;
}

Future getTopicsOfInterest() async {
  String urls = URLs.BASE_URL + 'topic-of-interest/list';
  final response = await http.get(urls);
  var convertDataToJson = jsonDecode(response.body);
  return convertDataToJson;
}

Future getWebinarDetails(String authToken, String webinar_id) async {
  String urls = URLs.BASE_URL + 'webinar/detail';
  final response = await http.post(
    urls,
    headers: {
      'Accept': 'Application/json',
      'Authorization': 'Bearer $authToken',
    },
    body: {'webinar_id': webinar_id},
  );
  var convertDataToJson = jsonDecode(response.body);
  return convertDataToJson;
}
