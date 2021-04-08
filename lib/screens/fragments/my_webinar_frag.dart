import 'dart:convert';

// import 'package:cpe_flutter/screens/fragments/pagination/webinar_list.dart';
import 'package:cpe_flutter/screens/fragments/model_mywebinar/list_mywebinar.dart';
import 'package:cpe_flutter/screens/intro_login_signup/intro_screen.dart';
import 'package:cpe_flutter/screens/profile/notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../constant.dart';
import '../../rest_api.dart';
import '../webinar_details/webinar_details_new.dart';

class MyWebinarFrag extends StatefulWidget {
  @override
  _MyWebinarFragState createState() => _MyWebinarFragState();
}

class _MyWebinarFragState extends State<MyWebinarFrag> {
  List<int> tempInt = [1, 4, 5, 7];
  int arrCount = 0;
  var data;
  var data_web;
  var data_msg = '';

  int start = 0;

  bool isHotTopics = false;
  bool isLive = true;
  bool isSelfStudy = false;
  bool isPremium = false;
  bool isFree = false;
  bool isCPD1 = false;

  bool isUpcomingWeb = true;
  bool isPendingEva = false;
  bool isDidNotAttend = false;
  bool isPollMissed = false;
  bool isCompleted = false;

  bool isEnrolledSS = false;
  bool isQuizPendingSS = false;
  bool isPendinEvaSS = false;
  bool isCompletedSS = false;

  String _authToken = "";

  String strWebinarType = "live";
  String strFilterType = '2';
  String strFilterPrice = "";
  String strWebinarTypeIntent = "";

  bool isProgressShowing = false;
  bool isLoaderShowing = false;
  List<Webinar> list;

  bool isLast = false;
  bool isSearch = false;
  ScrollController _scrollController = new ScrollController();

  TextEditingController searchController = TextEditingController();
  var searchKey = "";

  bool isUserLoggedIn = false;

  // Future<String> getDataWebinarList(
  Future<List<Webinar>> getDataWebinarList(String authToken, String start, String limit, String webinar_type, String filter_type) async {
    // String urls = URLs.BASE_URL + 'webinar/list';
    print('Request params are : authToken : $authToken :: start : $start :: limit : $limit :: webinar_type : $webinar_type :: filter_type : '
        '$filter_type');
    String urls = URLs.BASE_URL + 'webinar/mywebinars';
    // String urls = 'https://my-cpe.com/api/v3/webinar/list';
    // String urls = 'https://my-cpe.com/api/v3/webinar/my-webinar';

    final response = await http.post(
      urls,
      headers: {
        'Accept': 'Application/json',
        'Authorization': '$authToken',
      },
      body: {
        'start': start,
        'limit': limit,
        'webinar_type': webinar_type,
        'filter_type': filter_type,
      },
    );

    this.setState(() {
      // data = JSON.decode(response.body);
      if (response.statusCode == 401) {
        // Force Logout User..
        print('Get response for 401 need to force logout user..');
        logoutUser();
      }

      data = jsonDecode(response.body);
      isLoaderShowing = false;
      data_msg = data['message'];
      if (data['payload']['is_last']) {
        isLast = true;
      } else {
        isLast = false;
      }
    });

    // print(data[1]["title"]);
    print('API response is : $data');
    arrCount = data['payload']['webinar'].length;
    data_web = data['payload']['webinar'];
    print('Size for array is : $arrCount');

    if (list != null && list.isNotEmpty) {
      list.addAll(List.from(data_web).map<Webinar>((item) => Webinar.fromJson(item)).toList());
    } else {
      list = List.from(data_web).map<Webinar>((item) => Webinar.fromJson(item)).toList();
    }

    // return "Success!";
    return list;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    checkForSP();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        print('Scroll Controller is called here');
        if (!isLast) {
          checkForSPNew();
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
    return Scaffold(
      body: new WillPopScope(
          child: SafeArea(
            child: Stack(
              children: <Widget>[
                Positioned(
                    child: Column(
                  children: <Widget>[
                    Visibility(
                      visible: !isSearch,
                      child: Container(
                        height: 60.0,
                        width: double.infinity,
                        color: Color(0xFFF3F5F9),
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              top: 0.0,
                              bottom: 0.0,
                              right: 0.0,
                              left: 0.0,
                              child: Center(
                                child: Text(
                                  'My Webinar',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.0.sp,
                                    fontFamily: 'Whitney Semi Bold',
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 0.0,
                              top: 0.0,
                              bottom: 0.0,
                              child: Container(
                                // color: Color(0xFFF3F5F9),
                                // width: 20.0.sp,
                                height: double.infinity,
                                padding: EdgeInsets.all(10.0),
                                child: Row(
                                  children: <Widget>[
                                    Visibility(
                                      visible: false,
                                      child: GestureDetector(
                                        onTap: () {
                                          print('Clicked on the search icon..');
                                          setState(() {
                                            isSearch = true;
                                          });
                                        },
                                        child: Container(
                                          width: 30.0.sp,
                                          height: double.infinity,
                                          color: Color(0xFFF3F5F9),
                                          child: Icon(
                                            FontAwesomeIcons.search,
                                            size: 12.0.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Notifications(),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width: 20.0.sp,
                                        height: double.infinity,
                                        color: Color(0xFFF3F5F9),
                                        child: Icon(
                                          FontAwesomeIcons.solidBell,
                                          size: 12.0.sp,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    /*Visibility(
                    visible: isSearch,
                    child: Container(
                      height: 60.0,
                      // width: double.infinity,
                      color: Color(0xFFF3F5F9),
                      // color: Colors.tealAccent,
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              flex: 8,
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 7.0, horizontal: 15.0),
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                decoration: BoxDecoration(
                                  color: Color(0x88767680),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: TextField(
                                  controller: searchController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Search',
                                    hintStyle: kLableSearchHomeStyle,
                                  ),
                                  textInputAction: TextInputAction.search,
                                  onEditingComplete: () {
                                    print('Search event fired');
                                    setState(() {
                                      searchKey = searchController.text;
                                    });
                                    FocusScope.of(context).requestFocus(new FocusNode());

                                    // Now take an API call for the search tag too..
                                    list.clear();
                                    start = 0;

                                    this.getDataWebinarList('', '0', '10', '', '', '$searchKey', '$strWebinarType', '', '$strFilterPrice');
                                  },
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isSearch = false;
                                    if (searchController.text.isNotEmpty) {
                                      searchController.text = "";
                                      searchKey = "";

                                      list.clear();
                                      start = 0;

                                      this.getDataWebinarList('', '0', '10', '', '', '$searchKey', '$strWebinarType', '', '$strFilterPrice');
                                    }
                                  });
                                },
                                child: Container(
                                  height: double.infinity,
                                  color: Color(0xFFF3F5F9),
                                  padding: EdgeInsets.only(right: 20.0),
                                  child: Center(
                                    child: Text(
                                      'Cancel',
                                      style: kLableTextCancelStyle,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),*/
                    Container(
                      height: 1.0,
                      width: double.infinity,
                      color: Colors.blueGrey,
                    ),
                    Expanded(
                      child: Container(
                        child: !isUserLoggedIn
                            ? Container(
                                color: testColor,
                                child: Center(
                                  child: Container(
                                    height: 80.0.w,
                                    width: 70.0.w,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(top: 20.0.sp),
                                          height: 25.0.w,
                                          width: 25.0.w,
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.circular(25.0.w),
                                          ),
                                          child: Center(
                                            child: Text(
                                              '!',
                                              style: TextStyle(
                                                fontSize: 15.0.w,
                                                color: Colors.white,
                                                fontFamily: 'Whitney Bold',
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            'Oops',
                                            style: TextStyle(
                                              fontSize: 20.0.sp,
                                              color: Colors.black,
                                              fontFamily: 'Whitney Bold',
                                            ),
                                          ),
                                          padding: EdgeInsets.all(10.0),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 20.0.sp),
                                          child: Text(
                                            'You need to login first for accessing this window.',
                                            style: TextStyle(
                                              fontSize: 14.0.sp,
                                              color: Colors.black45,
                                              fontFamily: 'Whitney Medium',
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                logoutUser();
                                              });
                                            },
                                            child: Container(
                                              margin: EdgeInsets.symmetric(vertical: 5.0.w, horizontal: 5.0.w),
                                              height: 15.0.w,
                                              width: double.infinity,
                                              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                                              decoration: BoxDecoration(
                                                color: themeYellow,
                                                borderRadius: BorderRadius.circular(10.0),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  'Ok',
                                                  style: TextStyle(
                                                    fontSize: 12.0.sp,
                                                    color: Colors.white,
                                                    fontFamily: 'Whitney Bold',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : Column(
                                children: <Widget>[
                                  /*Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            selectLiveFilter();
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(left: 10.0, top: 10.0, right: 5.0, bottom: 0.0),
                                            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                            decoration: isLive
                                                ? BoxDecoration(
                                                    borderRadius: BorderRadius.circular(5.0),
                                                    border: Border.all(color: Color(0xFF607083), width: 1.0),
                                                    color: Color(0xFF607083),
                                                  )
                                                : BoxDecoration(
                                                    borderRadius: BorderRadius.circular(5.0),
                                                    border: Border.all(color: Colors.black, width: 1.0),
                                                    color: Color(0xFFFFFFFF),
                                                  ),
                                            child: Center(
                                              child: Text(
                                                'Live Webinars',
                                                style: TextStyle(
                                                  color: isLive ? Colors.white : Colors.black,
                                                  fontSize: 11.0.sp,
                                                  fontFamily: 'Whitney Medium',
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            selectSelfStudyFilter();
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(left: 5.0, top: 10.0, right: 10.0, bottom: 00.0),
                                            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                            decoration: isSelfStudy
                                                ? BoxDecoration(
                                                    borderRadius: BorderRadius.circular(5.0),
                                                    border: Border.all(color: Color(0xFF607083), width: 1.0),
                                                    color: Color(0xFF607083),
                                                  )
                                                : BoxDecoration(
                                                    borderRadius: BorderRadius.circular(5.0),
                                                    border: Border.all(color: Colors.black, width: 1.0),
                                                    color: Color(0xFFFFFFFF),
                                                  ),
                                            child: Center(
                                              child: Text(
                                                'Self Study',
                                                style: TextStyle(
                                                  color: isSelfStudy ? Colors.white : Colors.black,
                                                  fontSize: 11.0.sp,
                                                  fontFamily: 'Whitney Medium',
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),*/
                                  Container(
                                    color: testColor,
                                    child: Row(
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap: () {
                                            selectLiveFilter();
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(left: 10.0, top: 10.0, right: 5.0, bottom: 0.0),
                                            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                            // padding: const EdgeInsets.only(left: 14.0, right: 9.0, top: 18.0, bottom: 8.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  'Live Webinars',
                                                  style: TextStyle(
                                                    // color: isLive ? Colors.white : Colors.black,
                                                    color: Colors.black,
                                                    fontSize: isLive ? 13.0.sp : 11.0.sp,
                                                    fontFamily: isLive ? 'Whitney Bold' : 'Whitney Medium',
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(top: 2.0.sp),
                                                  height: 2.0.sp,
                                                  width: 20.0.sp,
                                                  color: isLive ? Colors.black : testColor,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            selectSelfStudyFilter();
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(left: 10.0.sp, top: 10.0, right: 10.0, bottom: 00.0),
                                            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  'Self Study',
                                                  style: TextStyle(
                                                    // color: isSelfStudy ? Colors.white : Colors.black,
                                                    color: Colors.black,
                                                    fontSize: isSelfStudy ? 13.0.sp : 11.0.sp,
                                                    fontFamily: isSelfStudy ? 'Whitney Bold' : 'Whitney Medium',
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(top: 2.0.sp),
                                                  height: 2.0.sp,
                                                  width: 20.0.sp,
                                                  color: isSelfStudy ? Colors.black : testColor,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                                      child: Row(
                                        children: <Widget>[
                                          /*GestureDetector(
                                          onTap: () {
                                            selectLiveFilter();
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                            child: Container(
                                              decoration: isLive
                                                  ? BoxDecoration(
                                                      borderRadius: BorderRadius.circular(18.0),
                                                      border: Border.all(color: Color(0xFF607083), width: 1.0),
                                                      color: Color(0xFF607083),
                                                    )
                                                  : BoxDecoration(
                                                      borderRadius: BorderRadius.circular(30.0),
                                                      border: Border.all(color: Colors.black, width: 1.0),
                                                      color: Color(0xFFFFFFFF),
                                                    ),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 9.0,
                                                  horizontal: 18.0,
                                                ),
                                                child: Text(
                                                  'Live Webinars',
                                                  style: TextStyle(
                                                    color: isLive ? Colors.white : Colors.black,
                                                    fontSize: 11.0.sp,
                                                    fontFamily: 'Whitney Medium',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            selectSelfStudyFilter();
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                            child: Container(
                                              decoration: isSelfStudy
                                                  ? BoxDecoration(
                                                      borderRadius: BorderRadius.circular(18.0),
                                                      border: Border.all(color: Color(0xFF607083), width: 1.0),
                                                      color: Color(0xFF607083),
                                                    )
                                                  : BoxDecoration(
                                                      borderRadius: BorderRadius.circular(30.0),
                                                      border: Border.all(color: Colors.black, width: 1.0),
                                                      color: Color(0xFFFFFFFF),
                                                    ),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 9.0,
                                                  horizontal: 18.0,
                                                ),
                                                child: Text(
                                                  'Self Study',
                                                  style: TextStyle(
                                                    color: isSelfStudy ? Colors.white : Colors.black,
                                                    fontSize: 11.0.sp,
                                                    fontFamily: 'Whitney Medium',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),*/
                                          Visibility(
                                            visible: isLive ? true : false,
                                            child: GestureDetector(
                                              onTap: () {
                                                selectUpcomingWebinarFilter();
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                                child: Container(
                                                  decoration: isUpcomingWeb
                                                      ? BoxDecoration(
                                                          borderRadius: BorderRadius.circular(18.0),
                                                          border: Border.all(color: Color(0xFF607083), width: 1.0),
                                                          color: Color(0xFF607083),
                                                        )
                                                      : BoxDecoration(
                                                          borderRadius: BorderRadius.circular(30.0),
                                                          border: Border.all(color: Colors.black, width: 1.0),
                                                          color: Color(0xFFFFFFFF),
                                                        ),
                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(
                                                      vertical: 9.0,
                                                      horizontal: 18.0,
                                                    ),
                                                    child: Text(
                                                      'Upcoming webinar',
                                                      style: TextStyle(
                                                        color: isUpcomingWeb ? Colors.white : Colors.black,
                                                        fontSize: 11.0.sp,
                                                        fontFamily: 'Whitney Medium',
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Visibility(
                                            visible: isLive ? true : false,
                                            child: GestureDetector(
                                              onTap: () {
                                                selectForPendingEvaluationFilter();
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                                child: Container(
                                                  decoration: isPendingEva
                                                      ? BoxDecoration(
                                                          borderRadius: BorderRadius.circular(18.0),
                                                          border: Border.all(color: Color(0xFF607083), width: 1.0),
                                                          color: Color(0xFF607083),
                                                        )
                                                      : BoxDecoration(
                                                          borderRadius: BorderRadius.circular(30.0),
                                                          border: Border.all(color: Colors.black, width: 1.0),
                                                          color: Color(0xFFFFFFFF),
                                                        ),
                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(
                                                      vertical: 9.0,
                                                      horizontal: 18.0,
                                                    ),
                                                    child: Text(
                                                      'Pending Evaluation',
                                                      style: TextStyle(
                                                        color: isPendingEva ? Colors.white : Colors.black,
                                                        fontSize: 11.0.sp,
                                                        fontFamily: 'Whitney Medium',
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Visibility(
                                            visible: isLive ? true : false,
                                            child: GestureDetector(
                                              onTap: () {
                                                selectDidNotAttendFilter();
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                                child: Container(
                                                  decoration: isDidNotAttend
                                                      ? BoxDecoration(
                                                          borderRadius: BorderRadius.circular(18.0),
                                                          border: Border.all(color: Color(0xFF607083), width: 1.0),
                                                          color: Color(0xFF607083),
                                                        )
                                                      : BoxDecoration(
                                                          borderRadius: BorderRadius.circular(30.0),
                                                          border: Border.all(color: Colors.black, width: 1.0),
                                                          color: Color(0xFFFFFFFF),
                                                        ),
                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(
                                                      vertical: 9.0,
                                                      horizontal: 18.0,
                                                    ),
                                                    child: Text(
                                                      'Did not attend',
                                                      style: TextStyle(
                                                        color: isDidNotAttend ? Colors.white : Colors.black,
                                                        fontSize: 11.0.sp,
                                                        fontFamily: 'Whitney Medium',
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Visibility(
                                            visible: isLive ? true : false,
                                            child: GestureDetector(
                                              onTap: () {
                                                selectPollMissedFilter();
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                                child: Container(
                                                  decoration: isPollMissed
                                                      ? BoxDecoration(
                                                          borderRadius: BorderRadius.circular(18.0),
                                                          border: Border.all(color: Color(0xFF607083), width: 1.0),
                                                          color: Color(0xFF607083),
                                                        )
                                                      : BoxDecoration(
                                                          borderRadius: BorderRadius.circular(30.0),
                                                          border: Border.all(color: Colors.black, width: 1.0),
                                                          color: Color(0xFFFFFFFF),
                                                        ),
                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(
                                                      vertical: 9.0,
                                                      horizontal: 18.0,
                                                    ),
                                                    child: Text(
                                                      'Poll Missed',
                                                      style: TextStyle(
                                                        color: isPollMissed ? Colors.white : Colors.black,
                                                        fontSize: 11.0.sp,
                                                        fontFamily: 'Whitney Medium',
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Visibility(
                                            visible: isLive ? true : false,
                                            child: GestureDetector(
                                              onTap: () {
                                                selectCompletedFilter();
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                                child: Container(
                                                  decoration: isCompleted
                                                      ? BoxDecoration(
                                                          borderRadius: BorderRadius.circular(18.0),
                                                          border: Border.all(color: Color(0xFF607083), width: 1.0),
                                                          color: Color(0xFF607083),
                                                        )
                                                      : BoxDecoration(
                                                          borderRadius: BorderRadius.circular(30.0),
                                                          border: Border.all(color: Colors.black, width: 1.0),
                                                          color: Color(0xFFFFFFFF),
                                                        ),
                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(
                                                      vertical: 9.0,
                                                      horizontal: 18.0,
                                                    ),
                                                    child: Text(
                                                      'Completed',
                                                      style: TextStyle(
                                                        color: isCompleted ? Colors.white : Colors.black,
                                                        fontSize: 11.0.sp,
                                                        fontFamily: 'Whitney Medium',
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Visibility(
                                            visible: isSelfStudy ? true : false,
                                            child: GestureDetector(
                                              onTap: () {
                                                selectEnrolledSSFilter();
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                                child: Container(
                                                  decoration: isEnrolledSS
                                                      ? BoxDecoration(
                                                          borderRadius: BorderRadius.circular(18.0),
                                                          border: Border.all(color: Color(0xFF607083), width: 1.0),
                                                          color: Color(0xFF607083),
                                                        )
                                                      : BoxDecoration(
                                                          borderRadius: BorderRadius.circular(30.0),
                                                          border: Border.all(color: Colors.black, width: 1.0),
                                                          color: Color(0xFFFFFFFF),
                                                        ),
                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(
                                                      vertical: 9.0,
                                                      horizontal: 18.0,
                                                    ),
                                                    child: Text(
                                                      'Enrolled',
                                                      style: TextStyle(
                                                        color: isEnrolledSS ? Colors.white : Colors.black,
                                                        fontSize: 11.0.sp,
                                                        fontFamily: 'Whitney Medium',
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Visibility(
                                            visible: isSelfStudy ? true : false,
                                            child: GestureDetector(
                                              onTap: () {
                                                selectQuizPendingSSFilter();
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                                child: Container(
                                                  decoration: isQuizPendingSS
                                                      ? BoxDecoration(
                                                          borderRadius: BorderRadius.circular(18.0),
                                                          border: Border.all(color: Color(0xFF607083), width: 1.0),
                                                          color: Color(0xFF607083),
                                                        )
                                                      : BoxDecoration(
                                                          borderRadius: BorderRadius.circular(30.0),
                                                          border: Border.all(color: Colors.black, width: 1.0),
                                                          color: Color(0xFFFFFFFF),
                                                        ),
                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(
                                                      vertical: 9.0,
                                                      horizontal: 18.0,
                                                    ),
                                                    child: Text(
                                                      'Quiz Pending',
                                                      style: TextStyle(
                                                        color: isQuizPendingSS ? Colors.white : Colors.black,
                                                        fontSize: 11.0.sp,
                                                        fontFamily: 'Whitney Medium',
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Visibility(
                                            visible: isSelfStudy ? true : false,
                                            child: GestureDetector(
                                              onTap: () {
                                                selectPendingEvaluationSSFilter();
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                                child: Container(
                                                  decoration: isPendinEvaSS
                                                      ? BoxDecoration(
                                                          borderRadius: BorderRadius.circular(18.0),
                                                          border: Border.all(color: Color(0xFF607083), width: 1.0),
                                                          color: Color(0xFF607083),
                                                        )
                                                      : BoxDecoration(
                                                          borderRadius: BorderRadius.circular(30.0),
                                                          border: Border.all(color: Colors.black, width: 1.0),
                                                          color: Color(0xFFFFFFFF),
                                                        ),
                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(
                                                      vertical: 9.0,
                                                      horizontal: 18.0,
                                                    ),
                                                    child: Text(
                                                      'Pending Evaluation',
                                                      style: TextStyle(
                                                        color: isPendinEvaSS ? Colors.white : Colors.black,
                                                        fontSize: 11.0.sp,
                                                        fontFamily: 'Whitney Medium',
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Visibility(
                                            visible: isSelfStudy ? true : false,
                                            child: GestureDetector(
                                              onTap: () {
                                                selectCompletedSSFilter();
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                                child: Container(
                                                  decoration: isCompletedSS
                                                      ? BoxDecoration(
                                                          borderRadius: BorderRadius.circular(18.0),
                                                          border: Border.all(color: Color(0xFF607083), width: 1.0),
                                                          color: Color(0xFF607083),
                                                        )
                                                      : BoxDecoration(
                                                          borderRadius: BorderRadius.circular(30.0),
                                                          border: Border.all(color: Colors.black, width: 1.0),
                                                          color: Color(0xFFFFFFFF),
                                                        ),
                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(
                                                      vertical: 9.0,
                                                      horizontal: 18.0,
                                                    ),
                                                    child: Text(
                                                      'Completed',
                                                      style: TextStyle(
                                                        color: isCompletedSS ? Colors.white : Colors.black,
                                                        fontSize: 11.0.sp,
                                                        fontFamily: 'Whitney Medium',
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          /*GestureDetector(
                              onTap: () {
                                selectPremiumFilter();
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                child: Container(
                                  decoration: isPremium
                                      ? BoxDecoration(
                                          borderRadius: BorderRadius.circular(18.0),
                                          color: Color(0xFF607083),
                                        )
                                      : BoxDecoration(
                                          borderRadius: BorderRadius.circular(30.0),
                                          border: Border.all(color: Colors.black, width: 1.0),
                                          color: Color(0xFFFFFFFF),
                                        ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 9.0,
                                      horizontal: 18.0,
                                    ),
                                    child: Text(
                                      'Premium',
                                      style: TextStyle(
                                        color: isPremium ? Colors.white : Colors.black,
                                        fontSize: 11.0.sp,
                                        fontFamily: 'Whitney Medium',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                selectFreeFilter();
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                child: Container(
                                  decoration: isFree
                                      ? BoxDecoration(
                                          borderRadius: BorderRadius.circular(18.0),
                                          color: Color(0xFF607083),
                                        )
                                      : BoxDecoration(
                                          borderRadius: BorderRadius.circular(30.0),
                                          border: Border.all(color: Colors.black, width: 1.0),
                                          color: Color(0xFFFFFFFF),
                                        ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 9.0,
                                      horizontal: 18.0,
                                    ),
                                    child: Text(
                                      'Free',
                                      style: TextStyle(
                                        color: isFree ? Colors.white : Colors.black,
                                        fontSize: 11.0.sp,
                                        fontFamily: 'Whitney Medium',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.0),
                                  border: Border.all(color: Colors.black, width: 1.0),
                                  color: Color(0xFFFFFFFF),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 9.0,
                                    horizontal: 18.0,
                                  ),
                                  child: Text(
                                    'Date',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 11.0.sp,
                                      fontFamily: 'Whitney Medium',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: selectCPDFilter(),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                child: Container(
                                  decoration: isCPD1
                                      ? BoxDecoration(
                                          borderRadius: BorderRadius.circular(18.0),
                                          color: Color(0xFF607083),
                                        )
                                      : BoxDecoration(
                                          borderRadius: BorderRadius.circular(30.0),
                                          border: Border.all(color: Colors.black, width: 1.0),
                                          color: Color(0xFFFFFFFF),
                                        ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 9.0,
                                      horizontal: 18.0,
                                    ),
                                    child: Text(
                                      'CPD',
                                      style: TextStyle(
                                        color: isCPD1 ? Colors.white : Colors.black,
                                        fontSize: 11.0.sp,
                                        fontFamily: 'Whitney Medium',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),*/
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: isLoaderShowing
                                          ? Center(
                                              child: CircularProgressIndicator(),
                                            )
                                          : (list != null && list.isNotEmpty)
                                              ? RefreshIndicator(
                                                  onRefresh: () {
                                                    print('On refresh is called..');
                                                    start = 0;
                                                    list.clear();
                                                    return this.getDataWebinarList('$_authToken', '0', '10', '$strWebinarType', '$strFilterType');
                                                  },
                                                  child: ListView.builder(
                                                    controller: _scrollController,
                                                    shrinkWrap: true,
                                                    physics: AlwaysScrollableScrollPhysics(),
                                                    // itemCount: arrCount,
                                                    itemCount: list.length + 1,
                                                    itemBuilder: (context, index) {
                                                      return (index == list.length)
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
                                                                print('Clicked on index pos : $index');
                                                              },
                                                              child: Container(
                                                                // margin: EdgeInsets.only(top: 10.0),
                                                                margin: EdgeInsets.fromLTRB(3.5.w, 0.0.h, 3.5.w, 2.0.h),
                                                                decoration: BoxDecoration(
                                                                  // color: Color(0xFFFFC803),
                                                                  color: index % 2 == 0 ? Color(0xFFFFC803) : Color(0xFF00B1FD),
                                                                  borderRadius: BorderRadius.all(
                                                                    Radius.circular(15.0),
                                                                  ),
                                                                ),
                                                                height: 70.0.w,
                                                                child: Stack(
                                                                  children: [
                                                                    Positioned(
                                                                      top: 0,
                                                                      left: 0,
                                                                      right: 0,
                                                                      child: Column(
                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: <Widget>[
                                                                          Padding(
                                                                            padding: const EdgeInsets.only(top: 15.0),
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: <Widget>[
                                                                                ConstrainedBox(
                                                                                  constraints: BoxConstraints(minWidth: 28.0.w),
                                                                                  child: Container(
                                                                                    margin: EdgeInsets.only(left: 15.0),
                                                                                    height: 4.0.h,
                                                                                    decoration: BoxDecoration(
                                                                                      borderRadius: BorderRadius.circular(5.0),
                                                                                      color: Colors.white,
                                                                                    ),
                                                                                    child: Padding(
                                                                                      padding:
                                                                                          const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                                                                                      child: Center(
                                                                                        child: Text(
                                                                                            // '${data['payload']['webinar'][index]['webinar_type']}',
                                                                                            '${list[index].webinarType}',
                                                                                            style:
                                                                                                // kWebinarButtonLabelTextStyleGreen,
                                                                                                TextStyle(
                                                                                              fontFamily: 'Whitney Semi Bold',
                                                                                              fontSize: 12.5.sp,
                                                                                              color: Color(0xFF00A81B),
                                                                                            )),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                ConstrainedBox(
                                                                                  constraints: BoxConstraints(minWidth: 28.0.w),
                                                                                  child: Container(
                                                                                    height: 4.0.h,
                                                                                    decoration: BoxDecoration(
                                                                                      borderRadius: BorderRadius.circular(5.0),
                                                                                      color: Colors.white,
                                                                                    ),
                                                                                    child: Padding(
                                                                                      padding:
                                                                                          const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                                                                                      child: Center(
                                                                                        child: Text(
                                                                                            // '${data['payload']['webinar'][index]['cpa_credit']}',
                                                                                            '${list[index].cpaCredit}',
                                                                                            style:
                                                                                                // kWebinarButtonLabelTextStyle,
                                                                                                TextStyle(
                                                                                              fontFamily: 'Whitney Semi Bold',
                                                                                              fontSize: 12.5.sp,
                                                                                              color: Colors.black,
                                                                                            )),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                ConstrainedBox(
                                                                                  constraints: BoxConstraints(minWidth: 28.0.w),
                                                                                  child: Container(
                                                                                    margin: EdgeInsets.only(right: 15.0),
                                                                                    height: 4.0.h,
                                                                                    decoration: BoxDecoration(
                                                                                      borderRadius: BorderRadius.circular(5.0),
                                                                                      color: Colors.white,
                                                                                    ),
                                                                                    child: Padding(
                                                                                      padding:
                                                                                          const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                                                                                      child: Center(
                                                                                        child: Text(
                                                                                            // '\$ ${data['payload']['webinar'][index]['fee']}',
                                                                                            '${checkForPrice(index)}',
                                                                                            style:
                                                                                                // kWebinarButtonLabelTextStyle,
                                                                                                TextStyle(
                                                                                              fontFamily: 'Whitney Semi Bold',
                                                                                              fontSize: 12.5.sp,
                                                                                              color: Colors.black,
                                                                                            )),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: const EdgeInsets.fromLTRB(18.0, 10.0, 30.0, 0),
                                                                            child: Flexible(
                                                                              child: Text(
                                                                                // '${data['payload']['webinar'][index]['webinar_title']}',
                                                                                '${list[index].webinarTitle}',
                                                                                style: TextStyle(
                                                                                  fontFamily: 'Whitney Bold',
                                                                                  fontSize: 16.0.sp,
                                                                                  color: index % 2 == 0 ? Colors.black : Colors.white,
                                                                                ),
                                                                                maxLines: 2,
                                                                                overflow: TextOverflow.ellipsis,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: const EdgeInsets.fromLTRB(18.0, 5.0, 30.0, 0),
                                                                            child: Row(
                                                                              children: [
                                                                                Flexible(
                                                                                  child: Text(
                                                                                    // '${data['payload']['webinar'][index]['speaker_name']}',
                                                                                    '${list[index].speakerName}',
                                                                                    style: TextStyle(
                                                                                      fontFamily: 'Whitney Semi Bold',
                                                                                      fontSize: 13.0.sp,
                                                                                      color: index % 2 == 0 ? Colors.black : Colors.white,
                                                                                    ),
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                    maxLines: 2,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: const EdgeInsets.fromLTRB(18.0, 5.0, 30.0, 0),
                                                                            child: Row(
                                                                              children: [
                                                                                Text(
                                                                                  // '${data['payload']['webinar'][index]['start_date']} - ${data['payload']['webinar'][index]['start_time']} - ${data['payload']['webinar'][index]['time_zone']}',
                                                                                  '${displayDateCondition(index)}',
                                                                                  style: TextStyle(
                                                                                    fontFamily: 'Whitney Semi Bold',
                                                                                    fontSize: 13.0.sp,
                                                                                    color: index % 2 == 0 ? Colors.black : Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Positioned(
                                                                      bottom: 18.0,
                                                                      left: 18.0,
                                                                      child: GestureDetector(
                                                                        onTap: () {
                                                                          print('Clicked on register button index is : $index');
                                                                          getIdWebinar(index);
                                                                          // 1. Take an API call for relevent action from here..
                                                                          // 2. Before this need to verify user is logged in or not..
                                                                          // 3. If not then redirect to Login screen and then back here..
                                                                          // 4. If user is logged in then need to check for webinar is free or not..
                                                                          // 5. If the webinar is free then have to check for isCardSaved or not..
                                                                          // 6. Take a Register API call from there onwards..
                                                                        },
                                                                        child: ConstrainedBox(
                                                                          constraints: BoxConstraints(
                                                                            minWidth: 35.0.w,
                                                                          ),
                                                                          child: Container(
                                                                            decoration: BoxDecoration(
                                                                              // color: Color(0xFFC2900D),
                                                                              color: Color(0x23000000),
                                                                              borderRadius: BorderRadius.all(
                                                                                Radius.circular(5.0),
                                                                              ),
                                                                            ),
                                                                            height: 11.5.w,
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: <Widget>[
                                                                                Padding(
                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                  child: Text(
                                                                                    // '${data['payload']['webinar'][index]['status']}',
                                                                                    '${list[index].status}',
                                                                                    style: TextStyle(
                                                                                      fontFamily: 'Whitney Semi Bold',
                                                                                      fontSize: 14.0.sp,
                                                                                      color: Colors.white,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: EdgeInsets.all(5.0),
                                                                                  child: Icon(
                                                                                    FontAwesomeIcons.angleRight,
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Positioned(
                                                                      bottom: 0,
                                                                      right: 0,
                                                                      child: Image.asset(
                                                                        'assets/avatar_bottom_right.png',
                                                                        height: 36.0.w,
                                                                        width: 36.0.w,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                    },
                                                  ),
                                                )
                                              : Center(
                                                  child: Text(
                                                    // 'Oops no data found for this user..',
                                                    '$data_msg',
                                                    style: kValueLableWebinarDetailExpand,
                                                  ),
                                                ),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ],
                )),
                /*Positioned(
                bottom: 0.0,
                right: 0.0,
                left: 0.0,
                top: 100.0,
                child: Visibility(
                  visible: isLoaderShowing ? true : false,
                  child: SpinKitSample1(),
                ),
              ),*/
              ],
            ),
          ),
          onWillPop: _onWillPop),
    );
  }

  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Confirm Exit?', style: new TextStyle(color: Colors.black, fontSize: 20.0)),
            content: new Text('Are you sure you want to exit the app?'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () {
                  // this line exits the app.
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                },
                child: new Text('Yes', style: new TextStyle(fontSize: 18.0)),
              ),
              new FlatButton(
                onPressed: () => Navigator.pop(context),
                // this line dismisses the dialog
                child: new Text('No', style: new TextStyle(fontSize: 18.0)),
              )
            ],
          ),
        ) ??
        false;
  }

  void selectLiveFilter() {
    setState(() {
      isUpcomingWeb = true;
      isPendingEva = false;
      isDidNotAttend = false;
      isPollMissed = false;
      isCompleted = false;

      isEnrolledSS = false;
      isQuizPendingSS = false;
      isPendinEvaSS = false;
      isCompletedSS = false;

      strFilterType = '2';

      strWebinarType = "live";
      isLive = true;
      isSelfStudy = false;
      isProgressShowing = true;

      list.clear();
      start = 0;

      // this.getDataWebinarList('', '0', '10', '', '', '$searchKey', '$strWebinarType', '', '$strFilterPrice');
      this.getDataWebinarList('$_authToken', '0', '10', '$strWebinarType', '$strFilterType');
    });
  }

  void selectSelfStudyFilter() {
    setState(() {
      isUpcomingWeb = false;
      isPendingEva = false;
      isDidNotAttend = false;
      isPollMissed = false;
      isCompleted = false;

      isEnrolledSS = true;
      isQuizPendingSS = false;
      isPendinEvaSS = false;
      isCompletedSS = false;

      strFilterType = '7';

      strWebinarType = "self_study";
      isLive = false;
      isSelfStudy = true;
      isProgressShowing = true;

      list.clear();
      start = 0;

      // this.getDataWebinarList('', '0', '10', '', '', '$searchKey', '$strWebinarType', '', '$strFilterPrice');
      this.getDataWebinarList('$_authToken', '0', '10', '$strWebinarType', '$strFilterType');
    });
  }

  /*void selectPremiumFilter() {
    setState(() {
      if (isPremium) {
        isPremium = false;
      } else {
        isPremium = true;
      }

      if (isPremium && isFree) {
        strFilterPrice = "0,1";
      } else if (isPremium) {
        strFilterPrice = "1";
      } else if (isFree) {
        strFilterPrice = "0";
      } else {
        strFilterPrice = "";
      }

      isProgressShowing = true;
      this.getDataWebinarList('', '0', '10', '', '', '$searchKey', '$strWebinarType', '', '$strFilterPrice');
    });
  }

  void selectFreeFilter() {
    setState(() {
      if (isFree) {
        isFree = false;
      } else {
        isFree = true;
      }

      if (isPremium && isFree) {
        strFilterPrice = "0,1";
      } else if (isPremium) {
        strFilterPrice = "1";
      } else if (isFree) {
        strFilterPrice = "0";
      } else {
        strFilterPrice = "";
      }

      isProgressShowing = true;
      this.getDataWebinarList('', '0', '10', '', '', '$searchKey', '$strWebinarType', '', '$strFilterPrice');
    });
  }*/

  void getIdWebinar(int index) {
    // int webinarId = data['payload']['webinar'][index]['id'];
    int webinarId = list[index].id;
    String strWebinarId = webinarId.toString();
    // strWebinarTypeIntent = data['payload']['webinar'][index]['webinar_type'];
    strWebinarTypeIntent = list[index].webinarType;
    print('Id for the webinar is : $webinarId');
    print('String for strWebinarID : $strWebinarId');
    String sampleIntnent = 'HelloWorld';
    // Now redirect to webinar details from here..
    /*Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WebinarDetails(),
      ),
    );*/
    /*Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WebinarDetails(
          // builder: (context) => ProgressExample(
          // webinarId,
        ),
      ),
    );*/
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                // WebinarDetails('resultText Sender', webinarId)));
                WebinarDetailsNew(strWebinarTypeIntent, webinarId)));
  }

  checkForPrice(int index) {
    // String strFee = data['payload']['webinar'][index]['fee'];
    String strFee = list[index].fee;
    String finalFee = "";
    if (strFee == "FREE" || strFee == '') {
      finalFee = 'FREE';
    } else {
      // finalFee = 'data["payload']['webinar'][index]['fee"]';
      // finalFee = '\$ ${data['payload']['webinar'][index]['fee']}';
      finalFee = '\$ ${list[index].fee}';
    }

    return finalFee;
  }

  void selectUpcomingWebinarFilter() {
    setState(() {
      isUpcomingWeb = true;
      isPendingEva = false;
      isDidNotAttend = false;
      isPollMissed = false;
      isCompleted = false;

      isEnrolledSS = false;
      isQuizPendingSS = false;
      isPendinEvaSS = false;
      isCompletedSS = false;

      isLoaderShowing = true;

      strFilterType = '2';
      list.clear();
      start = 0;
      this.getDataWebinarList('$_authToken', '0', '10', '$strWebinarType', '$strFilterType');
    });
  }

  void selectForPendingEvaluationFilter() {
    setState(() {
      isUpcomingWeb = false;
      isPendingEva = true;
      isDidNotAttend = false;
      isPollMissed = false;
      isCompleted = false;

      isEnrolledSS = false;
      isQuizPendingSS = false;
      isPendinEvaSS = false;
      isCompletedSS = false;

      isLoaderShowing = true;

      strFilterType = '3';
      list.clear();
      start = 0;
      this.getDataWebinarList('$_authToken', '0', '10', '$strWebinarType', '$strFilterType');
    });
  }

  void selectDidNotAttendFilter() {
    setState(() {
      isUpcomingWeb = false;
      isPendingEva = false;
      isDidNotAttend = true;
      isPollMissed = false;
      isCompleted = false;

      isEnrolledSS = false;
      isQuizPendingSS = false;
      isPendinEvaSS = false;
      isCompletedSS = false;

      isLoaderShowing = true;

      strFilterType = '4';
      list.clear();
      start = 0;
      this.getDataWebinarList('$_authToken', '0', '10', '$strWebinarType', '$strFilterType');
    });
  }

  void selectPollMissedFilter() {
    setState(() {
      isUpcomingWeb = false;
      isPendingEva = false;
      isDidNotAttend = false;
      isPollMissed = true;
      isCompleted = false;

      isEnrolledSS = false;
      isQuizPendingSS = false;
      isPendinEvaSS = false;
      isCompletedSS = false;

      isLoaderShowing = true;

      strFilterType = '5';
      list.clear();
      start = 0;
      this.getDataWebinarList('$_authToken', '0', '10', '$strWebinarType', '$strFilterType');
    });
  }

  void selectCompletedFilter() {
    setState(() {
      isUpcomingWeb = false;
      isPendingEva = false;
      isDidNotAttend = false;
      isPollMissed = false;
      isCompleted = true;

      isEnrolledSS = false;
      isQuizPendingSS = false;
      isPendinEvaSS = false;
      isCompletedSS = false;

      isLoaderShowing = true;

      strFilterType = '1';
      list.clear();
      start = 0;
      this.getDataWebinarList('$_authToken', '0', '10', '$strWebinarType', '$strFilterType');
    });
  }

  void selectEnrolledSSFilter() {
    setState(() {
      isUpcomingWeb = false;
      isPendingEva = false;
      isDidNotAttend = false;
      isPollMissed = false;
      isCompleted = false;

      isEnrolledSS = true;
      isQuizPendingSS = false;
      isPendinEvaSS = false;
      isCompletedSS = false;

      isLoaderShowing = true;

      strFilterType = '7';
      list.clear();
      start = 0;
      this.getDataWebinarList('$_authToken', '0', '10', '$strWebinarType', '$strFilterType');
    });
  }

  void selectQuizPendingSSFilter() {
    setState(() {
      isUpcomingWeb = false;
      isPendingEva = false;
      isDidNotAttend = false;
      isPollMissed = false;
      isCompleted = false;

      isEnrolledSS = false;
      isQuizPendingSS = true;
      isPendinEvaSS = false;
      isCompletedSS = false;

      isLoaderShowing = true;

      strFilterType = '8';
      list.clear();
      start = 0;
      this.getDataWebinarList('$_authToken', '0', '10', '$strWebinarType', '$strFilterType');
    });
  }

  void selectPendingEvaluationSSFilter() {
    setState(() {
      isUpcomingWeb = false;
      isPendingEva = false;
      isDidNotAttend = false;
      isPollMissed = false;
      isCompleted = false;

      isEnrolledSS = false;
      isQuizPendingSS = false;
      isPendinEvaSS = true;
      isCompletedSS = false;

      isLoaderShowing = true;

      strFilterType = '9';
      list.clear();
      start = 0;
      this.getDataWebinarList('$_authToken', '0', '10', '$strWebinarType', '$strFilterType');
    });
  }

  void selectCompletedSSFilter() {
    setState(() {
      isUpcomingWeb = false;
      isPendingEva = false;
      isDidNotAttend = false;
      isPollMissed = false;
      isCompleted = false;

      isEnrolledSS = false;
      isQuizPendingSS = false;
      isPendinEvaSS = false;
      isCompletedSS = true;

      isLoaderShowing = true;

      strFilterType = '6';
      list.clear();
      start = 0;
      this.getDataWebinarList('$_authToken', '0', '10', '$strWebinarType', '$strFilterType');
    });
  }

  displayDateCondition(int index) {
    // '${data['payload']['webinar'][index]['start_date']} - ${data['payload']['webinar'][index]['start_time']} - ${data['payload']['webinar'][index]['time_zone']}',
    // String strStartDate = data['payload']['webinar'][index]['start_date'];
    String strStartDate = list[index].startDate;
    String day = "";
    String month = "";
    String year = "";

    String updatedDate = "";
    if (strStartDate == "") {
      updatedDate = "";
    } else {
      var split = strStartDate.split('-');
      day = split[2];
      month = split[1];
      year = split[0];

      print('Day : $day');
      print('Month : $month');
      print('Year : $year');

      switch (month) {
        case "01":
          {
            month = "Jan";
          }
          break;

        case "02":
          {
            month = "Feb";
          }
          break;

        case "03":
          {
            month = "Mar";
          }
          break;

        case "04":
          {
            month = "Apr";
          }
          break;

        case "05":
          {
            month = "May";
          }
          break;

        case "06":
          {
            month = "June";
          }
          break;

        case "07":
          {
            month = "July";
          }
          break;

        case "08":
          {
            month = "Aug";
          }
          break;

        case "09":
          {
            month = "Sep";
          }
          break;

        case "10":
          {
            month = "Oct";
          }
          break;

        case "11":
          {
            month = "Nov";
          }
          break;

        case "12":
          {
            month = "Dec";
          }
          break;
      }

      updatedDate =
          // '$day $month $year - ${data['payload']['webinar'][index]['start_time']} - ${data['payload']['webinar'][index]['time_zone']}';
          '$day $month $year - ${list[index].startTime} - ${list[index].timeZone}';
    }

    return (updatedDate);
  }

  void checkForSP() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool checkValue = preferences.getBool("check");

    if (checkValue != null) {
      setState(() {
        isLoaderShowing = true;
      });

      if (checkValue) {
        setState(() {
          isUserLoggedIn = true;
          String token = preferences.getString("spToken");
          _authToken = 'Bearer $token';
          print('Auth Token from SP is : $_authToken');
        });

        // this.getDataWebinarList('$_authToken', '$start', '10', '', '', '$searchKey', '$strWebinarType', '', '$strFilterPrice');
        strWebinarType = 'live';
        strFilterType = '2';
        this.getDataWebinarList('$_authToken', '$start', '10', '$strWebinarType', '$strFilterType');
        // print('init State isLive : $isLive');
        // print('init State isSelfStudy : $isSelfStudy');
      } else {
        // this.getDataWebinarList('$_authToken', '$start', '10', '', '', '$searchKey', '$strWebinarType', '', '$strFilterPrice');
        setState(() {
          isUserLoggedIn = false;
        });
        strWebinarType = 'live';
        strFilterType = '2';
        this.getDataWebinarList('', '$start', '10', '$strWebinarType', '$strFilterType');
        // print('init State isLive : $isLive');
        // print('init State isSelfStudy : $isSelfStudy');
        print('Check value : $checkValue');
        preferences.clear();
      }
    } else {
      // this.getDataWebinarList('', '$start', '10', '', '', '$searchKey', '$strWebinarType', '', '$strFilterPrice');
      // print('Entered init else part for the checkforSP');
      setState(() {
        isUserLoggedIn = false;
      });
      /*strWebinarType = 'live';
      strFilterType = '2';
      this.getDataWebinarList('', '$start', '10', '$strWebinarType', '$strFilterType');
      // print('init State isLive : $isLive');
      // print('init State isSelfStudy : $isSelfStudy');
      print('Check value : $checkValue');
      preferences.clear();*/
    }
  }

  void checkForSPNew() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool checkValue = preferences.getBool("check");

    if (checkValue != null) {
      if (!isLast) {
        start = start + 10;
        if (checkValue) {
          String token = preferences.getString("spToken");
          _authToken = 'Bearer $token';
          print('Auth Token from SP is : $_authToken');

          // this.getDataWebinarList('$_authToken', '$start', '10', '', '', '$searchKey', '$strWebinarType', '', '$strFilterPrice');
          strWebinarType = 'live';
          strFilterType = '2';
          this.getDataWebinarList('', '$start', '10', '$strWebinarType', '$strFilterType');
          // print('init State isLive : $isLive');
          // print('init State isSelfStudy : $isSelfStudy');
        } else {
          // this.getDataWebinarList('$_authToken', '$start', '10', '', '', '$searchKey', '$strWebinarType', '', '$strFilterPrice');
          strWebinarType = 'live';
          strFilterType = '2';
          this.getDataWebinarList('', '$start', '10', '$strWebinarType', '$strFilterType');
          // print('init State isLive : $isLive');
          // print('init State isSelfStudy : $isSelfStudy');
          print('Check value : $checkValue');
          preferences.clear();
        }
      }
    } else {
      if (!isLast) {
        start = start + 10;
        // this.getDataWebinarList('', '$start', '10', '', '', '$searchKey', '$strWebinarType', '', '$strFilterPrice');
        strWebinarType = 'live';
        strFilterType = '2';
        this.getDataWebinarList('', '$start', '10', '$strWebinarType', '$strFilterType');
        // print('init State isLive : $isLive');
        // print('init State isSelfStudy : $isSelfStudy');
        print('Check value : $checkValue');
        preferences.clear();
      }
    }
  }

  void logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    // Navigator.pushAndRemoveUntil(context, newRoute, (route) => false)
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => IntroScreen(),
        ),
        (Route<dynamic> route) => false);
  }
}
