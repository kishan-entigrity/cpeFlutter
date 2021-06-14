import 'dart:convert';

import 'package:http/http.dart' as http;

class URLs {
  // static const String BASE_URL = 'https://my-cpe.com/api/v3/';
  static const String BASE_URL = 'https://my-cpe.com/api/v4/';
  // static const String BASE_URL = 'https://testing-website.in/api/v4/';
}

Future loginUser(String email, String password, String device_id, String device_token, String device_type) async {
  var urls = Uri.parse(URLs.BASE_URL + 'login');
  final response = await http.post(
    urls,
    headers: {'Accept': 'Application/json'},
    body: {'email': email, 'password': password, 'device_id': device_id, 'device_token': device_token, 'device_type': device_type},
  );
  var convertDataToJson = jsonDecode(response.body);
  return convertDataToJson;
}

Future emailExists(String email) async {
  var urls = Uri.parse(URLs.BASE_URL + 'check-email-exist');
  final response = await http.post(
    urls,
    headers: {'Accept': 'Application/json'},
    body: {'email': email},
  );
  var convertDataToJson = jsonDecode(response.body);
  return convertDataToJson;
}

Future versionCheck(String current_version, String device_type) async {
  var urls = Uri.parse(URLs.BASE_URL + 'get-version');
  final response = await http.post(
    urls,
    headers: {
      'Accept': 'Application/json',
      // 'Authorization': 'Bearer $authToken',
    },
    body: {'current_version': current_version, 'device_type': device_type},
  );

  var convertDataToJson = jsonDecode(response.body);
  return convertDataToJson;
}

Future changePassword(String authToken, String current_password, String new_password, String confirm_password) async {
  var urls = Uri.parse(URLs.BASE_URL + 'change-password');
  final response = await http.post(
    urls,
    headers: {
      'Accept': 'Application/json',
      'Authorization': 'Bearer $authToken',
    },
    body: {'current_password': current_password, 'new_password': new_password, 'confirm_password': confirm_password},
  );
  if (response.statusCode == 401) {
    // var convertDataToJson = jsonDecode(response.body);
    return 'err401';
  } else {
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }
}

Future video_duration(String authToken, String webinar_id, String play_time_duration, String presentation_length) async {
  var urls = Uri.parse(URLs.BASE_URL + 'webinar/video-duration');
  final response = await http.post(
    urls,
    headers: {
      'Accept': 'Application/json',
      'Authorization': 'Bearer $authToken',
    },
    body: {'webinar_id': webinar_id, 'play_time_duration': play_time_duration, 'presentation_length': presentation_length},
  );
  var convertDataToJson = jsonDecode(response.body);
  return convertDataToJson;
}

Future forgetPassword(String email) async {
  var urls = Uri.parse(URLs.BASE_URL + 'forgot-password');
  final response = await http.post(
    urls,
    headers: {
      'Accept': 'Application/json',
      // 'Authorization': 'Bearer $authToken',
    },
    body: {
      'email': email,
    },
  );
  var convertDataToJson = jsonDecode(response.body);
  return convertDataToJson;
}

Future contactUs(String email, String subject) async {
  var urls = Uri.parse(URLs.BASE_URL + 'contact-us/query');
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

Future registerWebinarAPI(String authToken, String webinar_id, String schedule_id) async {
  var urls = Uri.parse(URLs.BASE_URL + 'webinar/register-webinar');
  final response = await http.post(
    urls,
    headers: {
      'Accept': 'Application/json',
      'Authorization': authToken,
    },
    body: {'webinar_id': webinar_id, 'schedule_id': schedule_id},
  );

  var convertDataToJson = jsonDecode(response.body);
  return convertDataToJson;
}

Future evaluationFormLink(String authToken, String webinar_id) async {
  var urls = Uri.parse(URLs.BASE_URL + 'webinar/evaluation-form-request');
  final response = await http.post(
    urls,
    headers: {
      'Accept': 'Application/json',
      'Authorization': authToken,
    },
    body: {'webinar_id': webinar_id},
  );

  var convertDataToJson = jsonDecode(response.body);
  return convertDataToJson;
}

Future registerPaidWebinarAPI(String authToken, String webinar_id, String schedule_id, String card_id, String is_card, String card_number,
    String exp_month, String exp_year, String cvv, String new_card, String card_holder_name) async {
  var urls = Uri.parse(URLs.BASE_URL + 'webinar/register-webinar');
  final response = await http.post(
    urls,
    headers: {
      'Accept': 'Application/json',
      'Authorization': authToken,
    },
    body: {
      'webinar_id': webinar_id,
      'schedule_id': schedule_id,
      'card_id': card_id,
      'is_card': is_card,
      'card_number': card_number,
      'exp_month': exp_month,
      'exp_year': exp_year,
      'cvv': cvv,
      'new_card': new_card,
      'card_holder_name': card_holder_name,
    },
  );

  var convertDataToJson = jsonDecode(response.body);
  return convertDataToJson;
}

Future homeWebinarList(String authToken, String start, String limit, String topic_of_interest, String subject_area, String webinar_key_text,
    String webinar_type, String date_filter, String filter_price) async {
  var urls = Uri.parse(URLs.BASE_URL + 'webinar/list');

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

Future getViewProfile(String authToken) async {
  var urls = Uri.parse(URLs.BASE_URL + 'view-profile');
  final response = await http.get(urls, headers: {
    'Accept': 'Application/json',
    'Authorization': authToken,
  });
  if (response.statusCode == 401) {
    print('401 error code on the profile');
    // forceLogoutCall();
  }
  var convertDataToJson = jsonDecode(response.body);
  return convertDataToJson;
}

/*Future getJobTitle(String authToken) async {
  String urls = URLs.BASE_URL + 'job-title/list';
  final response = await http.get(urls, headers: {
    'Accept': 'Application/json',
    'Authorization': authToken,
  });
  var convertDataToJson = jsonDecode(response.body);
  return convertDataToJson;
}*/

Future getIntroScreens() async {
  var urls = Uri.parse(URLs.BASE_URL + 'intro_screen');
  final response = await http.get(
    urls,
    headers: {
      'Accept': 'Application/json',
    },
  );
  var convertDataToJson = jsonDecode(response.body);
  return convertDataToJson;
}

Future getFAQsAPI() async {
  var urls = Uri.parse(URLs.BASE_URL + 'cms/faq');
  final response = await http.get(
    urls,
    headers: {
      'Accept': 'Application/json',
    },
  );
  var convertDataToJson = jsonDecode(response.body);
  return convertDataToJson;
}

Future getPrivacyPolicy() async {
  var urls = Uri.parse(URLs.BASE_URL + 'cms/privacy_policy');
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
  var urls = Uri.parse(URLs.BASE_URL + 'cms/terms_condition');
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
  var urls = Uri.parse(URLs.BASE_URL + 'topic-of-interest/list');
  final response = await http.get(urls);
  var convertDataToJson = jsonDecode(response.body);
  return convertDataToJson;
}

Future getWebinarDetails(String authToken, String webinar_id) async {
  var urls = Uri.parse(URLs.BASE_URL + 'webinar/detail');
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

Future getCountryList() async {
  var urls = Uri.parse(URLs.BASE_URL + 'country');
  final response = await http.get(urls);
  var convertDataToJson = jsonDecode(response.body);
  return convertDataToJson;
}

Future getStateList(String country_id) async {
  var urls = Uri.parse(URLs.BASE_URL + 'state');
  final response = await http.post(
    urls,
    headers: {'Accept': 'Application/json'},
    body: {'country_id': country_id},
  );
  var convertDataToJson = jsonDecode(response.body);
  return convertDataToJson;
}

Future getCityList(String state_id) async {
  var urls = Uri.parse(URLs.BASE_URL + 'city');
  final response = await http.post(
    urls,
    headers: {'Accept': 'Application/json'},
    body: {'state_id': state_id},
  );
  var convertDataToJson = jsonDecode(response.body);
  return convertDataToJson;
}

Future getProfessionalCreds() async {
  var urls = Uri.parse(URLs.BASE_URL + 'user-type');
  final response = await http.get(urls);
  var convertDataToJson = jsonDecode(response.body);
  return convertDataToJson;
}
