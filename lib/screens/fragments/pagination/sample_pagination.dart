import 'dart:convert';

import 'package:cpe_flutter/model/home_webinar_list/webinar_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SamplePagination extends StatefulWidget {
  @override
  _SamplePaginationState createState() => _SamplePaginationState();
}

class _SamplePaginationState extends State<SamplePagination> {
  var data;
  int arrCount = 0;
  // List<Webinar> list = new List();
  List<Webinar> list;
  var rest;

  // Future<String> getDataWebinarList(String authToken, String start, String limit, String topic_of_interest, String subject_area,
  Future<List<Webinar>> getDataWebinarList(String authToken, String start, String limit, String topic_of_interest, String subject_area,
      String webinar_key_text, String webinar_type, String date_filter, String filter_price) async {
    // String urls = URLs.BASE_URL + 'webinar/list';
    String urls = 'https://my-cpe.com/api/v3/webinar/list';

    final response = await http.post(
      urls,
      headers: {
        'Accept': 'Application/json',
        // 'Authorization': '$authToken',
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

    this.setState(() {
      // data = JSON.decode(response.body);
      data = jsonDecode(response.body);
      rest = data["payload"]["webinar"];

      list = rest.map<Webinar>((json) => Webinar.fromJson(json)).toList();
      // isLoaderShowing = false;
    });

    // print(data[1]["title"]);
    print('API response is : $data');
    arrCount = data['payload']['webinar'].length;
    print('Size for array is : $arrCount');
    print('Data for webinar $rest');
    print('Data for webinar List $list');
    print('Size for rest : ${list.length}');

    // return "Success!";
    return list;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataWebinarList('', '0', '10', '', '', '', 'self-study', '', '0');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.teal,
      ),
    );
  }
}
