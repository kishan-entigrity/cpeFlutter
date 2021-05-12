import 'dart:convert';

import 'package:cpe_flutter/components/SpinKitSample1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../rest_api.dart';

class PaginationSample extends StatefulWidget {
  @override
  _PaginationSampleState createState() => _PaginationSampleState();
}

class _PaginationSampleState extends State<PaginationSample> {
  bool isLoaderShowing = false;
  String _authToken = "";

  int arrCount = 0;
  var data;

  int start = 0;
  int end = 10;

  String strWebinarType = "live";
  String strFilterPrice = "";
  String strWebinarTypeIntent = "";

  Future<String> getDataWebinarList(String authToken, String start, String limit, String topic_of_interest, String subject_area,
      String webinar_key_text, String webinar_type, String date_filter, String filter_price) async {
    var urls = Uri.parse(URLs.BASE_URL + 'webinar/list');
    // String urls = 'https://my-cpe.com/api/v3/webinar/list';

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

    return "Success!";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Take an API call for getting webinar list with static free selfstudy webinars..
    checkForSP();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.teal,
          child: Column(
            children: <Widget>[
              // TopBar(Colors.white, "Pagination Sample"),
              Expanded(
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      child: Container(
                        color: Colors.tealAccent,
                        child: Expanded(
                            // child: LoadMore(
                            /*child: LazyLoadScrollView(
                            onEndOfPage: checkForSPUpdate,
                            // isFinish: !data['payload']['is_last'],
                            // isFinish: start >= 60,
                            // onLoadMore: checkForSPUpdate,
                            // onLoadMore: _checkForSPupdate,
                            child: ListView.builder(
                              itemCount: arrCount,
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
                                        '${data['payload']['webinar'][index]['webinar_title']}',
                                        style: TextStyle(
                                          fontSize: 20.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),*/
                            ),
                      ),
                    ),
                    Positioned(
                      child: Visibility(
                        visible: isLoaderShowing ? true : false,
                        // visible: true,
                        child: SpinKitSample1(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _checkForSPupdate() async {
    print("onLoadMore");
    await Future.delayed(Duration(seconds: 0, milliseconds: 100));
    checkForSPUpdate();
    return true;
  }

  void checkForSPUpdate() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool checkValue = preferences.getBool("check");

    start = start + 10;
    end = end + 10;

    print('start : $start end : $end New API is called');

    if (checkValue != null) {
      setState(() {
        isLoaderShowing = true;
      });
      if (checkValue) {
        String token = preferences.getString("spToken");
        _authToken = 'Bearer $token';
        print('Auth Token from SP is : $_authToken');

        // this.getDataWebinarList('$_authToken', '0', '10', '', '', '', '$strWebinarType', '', '$strFilterPrice');
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
