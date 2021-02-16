import 'dart:convert';

import 'package:cpe_flutter/screens/fragments/pagination/model_webinar_list.dart';
import 'package:cpe_flutter/screens/fragments/pagination/weblist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SamplePagination extends StatefulWidget {
  @override
  _SamplePaginationState createState() => _SamplePaginationState();
}

class _SamplePaginationState extends State<SamplePagination> {
  bool isLoaderShowing = false;
  String _authToken = "";

  int arrCount = 0;
  var data;

  int start = 0;
  int end = 10;

  // List<modelWebList> webListMod = new List();
  // List<modelWebList> webListMod = new List();
  List<ModelWebinarList> webListModNew = new List();

  List<String> strTitles = new List();
  ScrollController _scrollController = new ScrollController();

  static const String webListUrl = "https://my-cpe.com/api/v3/webinar/list";

  Future<List<WebList>> getWebList(String authToken, String start, String limit, String topic_of_interest, String subject_area,
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
        // return webList;
      } else {
        return List<WebList>();
      }
    } catch (e) {
      return List<WebList>();
    }
  }

  Future<String> getDataWebinarList(String authToken, String start, String limit, String topic_of_interest, String subject_area,
      String webinar_key_text, String webinar_type, String date_filter, String filter_price) async {
    // String urls = URLs.BASE_URL + 'webinar/list';
    String urls = 'https://my-cpe.com/api/v3/webinar/list';

    final response = await http.post(
      urls,
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

    this.setState(() {
      // data = JSON.decode(response.body);
      data = jsonDecode(response.body);
      isLoaderShowing = false;
    });

    // print(data[1]["title"]);
    print('API response is : $data');
    arrCount = data['payload']['webinar'].length;
    print('Size for array is : $arrCount');

    // for (int i = 0; i < arrCount; i++) {
    for (int i = 0; i < 10; i++) {
      strTitles.add(data['payload']['webinar'][i]['webinar_title']);
      // webListMod.add(data);
      // webListModNew.add(data);
    }
    webListModNew = data;
    print('After adding data length for strTitles : ${strTitles.length}');
    // print('Size for new model data is : ${webListModNew.Payload.Webinar.length}');

    return "Success!";
  }

  @override
  void initState() {
    super.initState();
    // Take an API call for getting webinar list with static free selfstudy webinars..
    print('Yes we are calling sample_pagination.dart file here..');
    checkForSP();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        print('Scroll Controller is called here');
        start = start + 10;
        // end = end + 10;
        print('Page count start : $start :: end : $end');
        checkForSP();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: ListView.builder(
            controller: _scrollController,
            // itemCount: arrCount,
            itemCount: strTitles.length,
            itemBuilder: (context, index) {
              return ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: 50.0,
                ),
                child: Container(
                  margin: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                  padding: EdgeInsets.all(10.0),
                  color: Colors.blueGrey,
                  child: Center(
                    child: Text(
                      // '${data['payload']['webinar'][index]['webinar_title']}',
                      '${strTitles[index]}',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void checkForSP() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool checkValue = preferences.getBool("check");

    if (checkValue != null) {
      setState(() {
        isLoaderShowing = true;
      });
      if (checkValue) {
        String token = preferences.getString("spToken");
        _authToken = 'Bearer $token';
        print('Auth Token from SP is : $_authToken');

        // this.getDataWebinarList('$_authToken', '0', '10', '', '', '', '$strWebinarType', '', '$strFilterPrice');
        print('Request Parms : start : $start :: end : $end :: type : self_study :: price : 0');
        this.getDataWebinarList('$_authToken', '$start', '$end', '', '', '', 'self_study', '', '0');
        // print('init State isLive : $isLive');
        // print('init State isSelfStudy : $isSelfStudy');
      } else {
        // this.getDataWebinarList('$_authToken', '0', '10', '', '', '','$strWebinarType', '', '$strFilterPrice');
        this.getDataWebinarList('$_authToken', '$start', '$end', '', '', '', 'self_study', '', '0');
        // print('init State isLive : $isLive');
        // print('init State isSelfStudy : $isSelfStudy');
        print('Check value : $checkValue');
        preferences.clear();
      }
    }
  }
}
