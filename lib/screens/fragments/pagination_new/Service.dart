import 'package:cpe_flutter/screens/fragments/pagination/weblist.dart';
import 'package:http/http.dart' as http;

class Service {
  static const String webListUrl = "https://my-cpe.com/api/v3/webinar/list";

  static Future<List<WebList>> getWebList(String authToken, String start, String limit, String topic_of_interest, String subject_area,
      String webinar_key_text, String webinar_type, String date_filter, String filter_price) async {
    try {
      final response = await http.post(
        webListUrl,
        headers: {
          'Accept': 'Application/json',
          'Authorization': '$authToken',
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

      if (response.statusCode == 200) {
        // final List<WebList> webList = webListFromJson(response.body);
        final List<WebList> webList = webListFromJson(response.body) as List<WebList>;
        return webList;
      } else {
        return List<WebList>();
      }
    } catch (e) {
      return List<WebList>();
    }
  }
}
