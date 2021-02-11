import 'dart:convert';

import 'package:cpe_flutter/components/SpinKitSample1.dart';
import 'package:cpe_flutter/components/TopBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PaginationSample extends StatefulWidget {
  @override
  _PaginationSampleState createState() => _PaginationSampleState();
}

class _PaginationSampleState extends State<PaginationSample> {
  bool isLoaderShowing = false;
  String _authToken = "";

  int arrCount = 0;
  var data;

  String strWebinarType = "live";
  String strFilterPrice = "";
  String strWebinarTypeIntent = "";

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
              TopBar(Colors.white, "Pagination Sample"),
              Expanded(
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      child: Container(
                        color: Colors.tealAccent,
                        child: Expanded(
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
        this.getDataWebinarList('$_authToken', '0', '10', '', '', '', 'self_study', '', '0');
        // print('init State isLive : $isLive');
        // print('init State isSelfStudy : $isSelfStudy');
      } else {
        // this.getDataWebinarList('$_authToken', '0', '10', '', '', '','$strWebinarType', '', '$strFilterPrice');
        this.getDataWebinarList('$_authToken', '0', '10', '', '', '', 'self_study', '', '0');
        // print('init State isLive : $isLive');
        // print('init State isSelfStudy : $isSelfStudy');
        print('Check value : $checkValue');
        preferences.clear();
      }
    }
  }
}
