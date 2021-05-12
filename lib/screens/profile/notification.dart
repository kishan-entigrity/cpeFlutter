import 'dart:convert';

import 'package:cpe_flutter/screens/intro_login_signup/login.dart';
import 'package:cpe_flutter/screens/profile/notification_settings.dart';
import 'package:cpe_flutter/screens/profile/pagination_notification/notification_list_data.dart';
import 'package:cpe_flutter/screens/webinar_details/webinar_details_new.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../constant.dart';
import '../../rest_api.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController _scrollController = new ScrollController();
  bool isLoaderShowing = false;
  String _authToken = "";

  int start = 0;
  var data;

  bool isLast = false;

  List<Notification_list> list;
  int arrCount = 0;
  var data_web;

  Future<List<Notification_list>> getMyTransactionList(String authToken, String start, String limit) async {
    // String urls = URLs.BASE_URL + 'webinar/list';
    var urls = Uri.parse(URLs.BASE_URL + 'notification');

    final response = await http.post(
      urls,
      headers: {
        'Accept': 'Application/json',
        'Authorization': '$authToken',
      },
      body: {
        'start': start,
        'limit': limit,
      },
    );

    this.setState(() {
      // data = JSON.decode(response.body);
      if (response.statusCode == 401) {
        print('Get response for 401 need to force logout user..');
        logoutUser();
      }

      data = jsonDecode(response.body);
      isLoaderShowing = false;
      if (data['payload']['is_last']) {
        isLast = true;
      } else {
        isLast = false;
      }
    });

    // print(data[1]["title"]);
    print('API response is : $data');
    arrCount = data['payload']['notification_list'].length;
    data_web = data['payload']['notification_list'];
    print('Size for array is : $arrCount');

    if (list != null && list.isNotEmpty) {
      list.addAll(List.from(data_web).map<Notification_list>((item) => Notification_list.fromJson(item)).toList());
    } else {
      list = List.from(data_web).map<Notification_list>((item) => Notification_list.fromJson(item)).toList();
    }

    // return "Success!";
    return list;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('Enter into myTransaction screen');
    // Get API call for my transaction..
    checkForSP();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        print('Scroll Controller is called here status for isLast is : $isLast');
        if (!isLast) {
          start = start + 10;
          print('Val for Start is : $start || Status for isLast is : $isLast');
          this.getMyTransactionList('$_authToken', '$start', '10');
        } else {
          print('val for isLast : $isLast');
        }
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
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              height: 70.0,
              width: double.infinity,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    child: Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          FontAwesomeIcons.angleLeft,
                        ),
                      ),
                      flex: 1,
                    ),
                    onTap: () {
                      print('Back button is pressed..');
                      Navigator.pop(context);
                    },
                  ),
                  Flexible(
                    child: Center(
                      child: Text(
                        'Notifications',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.5.sp,
                          fontFamily: 'Whitney Semi Bold',
                        ),
                      ),
                    ),
                    flex: 8,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NotificationSettings(),
                          // builder: (context) => Notifications(),
                        ),
                      );
                    },
                    child: Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Visibility(
                          visible: false,
                          child: Icon(
                            FontAwesomeIcons.cog,
                          ),
                        ),
                      ),
                      flex: 1,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 0.5,
              color: Colors.black,
            ),
            Expanded(
              child: Container(
                // color: Colors.teal,
                // child: Text('Hello World'),
                child: (list != null && list.isNotEmpty)
                    // child: !isLoaderShowing
                    ? RefreshIndicator(
                        onRefresh: () {
                          print('On refresh is called..');
                          start = 0;
                          list.clear();
                          return this.getMyTransactionList('$_authToken', '$start', '10');
                        },
                        child: ListView.builder(
                          physics: AlwaysScrollableScrollPhysics(),
                          controller: _scrollController,
                          shrinkWrap: true,
                          // itemCount: arrCount,
                          itemCount: list.length + 1,
                          // itemCount: strTitles.length,
                          itemBuilder: (context, index) {
                            return ConstrainedBox(
                              constraints: BoxConstraints(
                                minHeight: 50.0,
                              ),
                              child: (index == list.length)
                                  ? isLast
                                      ? Container(
                                          height: 20.0,
                                        )
                                      : Padding(
                                          padding: EdgeInsets.symmetric(vertical: 20.0),
                                          child: Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        )
                                  : GestureDetector(
                                      onTap: () {
                                        print('Clicked on the webinar id : ${list[index].webinarId}');
                                        print('Clicked on the webinar type : ${list[index].webinarType}');
                                        // So Basically we can handle the click event for the selected tile from here..

                                        var strWebinarType = list[index].webinarType.toString();
                                        var webinarId = list[index].webinarId;

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => WebinarDetailsNew(strWebinarType, webinarId),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10.0),
                                          // color: Colors.blueGrey,
                                          color: Color(0xFFF3F5F9),
                                        ),
                                        margin: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                                        // padding: EdgeInsets.all(10.0),
                                        padding: EdgeInsets.symmetric(
                                          vertical: 15.0,
                                          horizontal: 10.0,
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              '${list[index].notificationMessage}',
                                              style: TextStyle(
                                                fontSize: 15.0.sp,
                                                fontFamily: 'Whitney Medium',
                                              ),
                                            ),
                                            SizedBox(
                                              height: 16.0.sp,
                                            ),
                                            Text(
                                              // '${list[index].timestamp}',
                                              // '${new DateTime.fromMicrosecondsSinceEpoch(${list[index].timestamp})}',
                                              // '${covertDateTimeTimeStamp('${list[index].timestamp}')}',
                                              list[index].timestamp,
                                              style: TextStyle(
                                                fontSize: 12.0.sp,
                                                fontFamily: 'Whitney Medium',
                                                color: Color(0x501F2227),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                            );
                          },
                        ),
                      )
                    : (list != null && list.isEmpty)
                        ? Center(
                            child: Text(
                              'Oops data no data found for this user..',
                              // data['message'],
                              style: kValueLableWebinarDetailExpand,
                            ),
                          )
                        : Container(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
              ),
            ),
          ],
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

        // this.getDataWebinarList('$_authToken', '$start', '10');
        this.getMyTransactionList('$_authToken', '$start', '10');
        // print('init State isLive : $isLive');
        // print('init State isSelfStudy : $isSelfStudy');
      } else {
        preferences.clear();
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text(sharedPrefsNot),
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }

  String covertDateTimeTimeStamp(String timeStamp) {
    print('TimeStamp we are getting is : $timeStamp');

    var intDate = int.parse(timeStamp);

    var date = DateTime.fromMillisecondsSinceEpoch(intDate * 1000);
    // DateTime date1 = intDate.toDate;
    // var date2 = DateTime.fromMillisecondsSinceEpoch(intDate);
    // var formattedDate = DateFormat.yMMMd().format(date2);

    // return timeStamp;
    // return formattedDate;
    return date.toString();
  }

  void logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    // Navigator.pushAndRemoveUntil(context, newRoute, (route) => false)
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => Login(false),
        ),
        (Route<dynamic> route) => false);
  }
}
