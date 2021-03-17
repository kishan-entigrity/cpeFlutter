import 'dart:convert';

import 'package:cpe_flutter/screens/fragments/pagination/webinar_list.dart';
import 'package:cpe_flutter/screens/profile/notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../constant.dart';
import '../webinar_details/webinar_details_new.dart';
import 'model_recentwebinar/recent_webinar_data.dart';

class HomeFragment extends StatefulWidget {
  @override
  _HomeFragmentState createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  List<int> tempInt = [1, 4, 5, 7];
  int arrCount = 0;
  int arrCountRecent = 0;
  var data;
  var data_web;
  var data_recent;

  int start = 0;

  bool isHotTopics = false;
  bool isLive = true;
  bool isSelfStudy = false;
  bool isPremium = false;
  bool isFree = false;
  bool isCPD1 = false;

  String _authToken = "";

  String strWebinarType = "live";
  String strFilterPrice = "";
  String strWebinarTypeIntent = "";

  bool isProgressShowing = false;
  bool isLoaderShowing = false;
  List<Webinar> list;
  List<RecentWebinars> recentList;

  bool isLast = false;
  bool isSearch = false;
  ScrollController _scrollController = new ScrollController();

  TextEditingController searchController = TextEditingController();
  var searchKey = "";

  Future<List<Webinar>> getDataWebinarList(String authToken, String start, String limit, String topic_of_interest, String subject_area,
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
      if (data['payload']['is_last']) {
        isLast = true;
      } else {
        isLast = false;
      }
    });

    // print(data[1]["title"]);
    print('API response is : $data');
    arrCount = data['payload']['webinar'].length;
    arrCountRecent = data['payload']['RecentWebinars'].length;
    data_web = data['payload']['webinar'];
    print('Size for array is : $arrCount');
    print('Size for arrayRecent is : $arrCountRecent');

    // data_recent = data['payload']['RecentWebinars'];
    // print('Size for the recent List is : ${recentList.length}');

    if (list != null && list.isNotEmpty) {
      list.addAll(List.from(data_web).map<Webinar>((item) => Webinar.fromJson(item)).toList());
    } else {
      list = List.from(data_web).map<Webinar>((item) => Webinar.fromJson(item)).toList();
    }

    if (arrCountRecent != 0) {
      data_recent = data['payload']['RecentWebinars'];
      recentList = List.from(data_recent).map<RecentWebinars>((item) => RecentWebinars.fromJson(item)).toList();
      print('Size for recentList = ${recentList.length}');
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

    /*this.getDataWebinarList(
        '', '0', '10', '', '', '', '$strWebinarType', '', '$strFilterPrice');
    print('init State isLive : $isLive');
    print('init State isSelfStudy : $isSelfStudy');*/
    // this.getDataWebinarList('', '0', '10', '', '', '', 'self_study', '', '0');
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: Text(
          'My Webinar App Bar',
          style: TextStyle(
            fontSize: 30.0,
            color: Colors.teal,
          ),
        ),
      ),*/
      body: SafeArea(
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
                              'Home',
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
                                GestureDetector(
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
                Visibility(
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
                ),
                Container(
                  height: 1.0,
                  width: double.infinity,
                  color: Colors.blueGrey,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                    child: Row(
                      children: <Widget>[
                        /*selectedFilterWidget(
                      str: 'Test Filter',
                    ),*/
                        selectedFilterWidget(
                          str: 'Hot Topics',
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
                                'Topics',
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
                          onTap: () {
                            selectLiveFilter();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                            child: Container(
                              decoration: isLive
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
                        ),
                        GestureDetector(
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
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: (list != null && list.isNotEmpty)
                      ? ListView.builder(
                          controller: _scrollController,
                          shrinkWrap: true,
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
                                // : (index == 0 && isSelfStudy && arrCountRecent != 0 && start == 0)
                                : (index == 0 && isSelfStudy && arrCountRecent > 0)
                                    ? Column(
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: 12.0.sp),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Text(
                                                  'Continue Watch',
                                                  style: TextStyle(
                                                    fontSize: 11.0.sp,
                                                    fontFamily: 'Whitney Semi Bold',
                                                  ),
                                                ),
                                                Icon(
                                                  FontAwesomeIcons.angleRight,
                                                  color: Colors.black,
                                                  size: 12.0.sp,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: 40.0.w,
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: recentList.length,
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  margin: EdgeInsets.fromLTRB(3.5.w, 1.0.h, 0.0, 2.0.h),
                                                  height: 40.0.w,
                                                  width: 65.0.w,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10.0.sp),
                                                    color: Colors.teal,
                                                  ),
                                                  child: Stack(
                                                    children: <Widget>[
                                                      Positioned(
                                                        child: Image.asset(
                                                          'assets/bg_image_recent.png',
                                                          height: 40.0.w,
                                                          width: 65.0.w,
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                      Positioned(
                                                        child: Container(
                                                          height: double.infinity,
                                                          child: Stack(
                                                            children: <Widget>[
                                                              Positioned(
                                                                child: Text(
                                                                  recentList[index].webinarTitle,
                                                                  style: TextStyle(
                                                                    fontSize: 10.0.sp,
                                                                    color: Colors.white,
                                                                    fontFamily: 'Whitney Bold',
                                                                  ),
                                                                  maxLines: 3,
                                                                  overflow: TextOverflow.ellipsis,
                                                                ),
                                                              ),
                                                              Positioned(
                                                                bottom: 0.0,
                                                                child: GestureDetector(
                                                                  onTap: () {
                                                                    print('Clicked on index position : $index');
                                                                    print('Clicked on ID : ${recentList[index].id}');
                                                                    getIdWebinar(index);
                                                                  },
                                                                  child: Container(
                                                                    height: 25.0.sp,
                                                                    width: 25.0.sp,
                                                                    decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(25.0.sp),
                                                                      color: Colors.white,
                                                                    ),
                                                                    padding: EdgeInsets.all(7.0.sp),
                                                                    child: Image.asset(
                                                                      'assets/cpe_icon.png',
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          padding: EdgeInsets.all(10.0.sp),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      )
                                    /*Text('Horizontal row here..')*/
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
                                                                padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
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
                                                                padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
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
                                                                padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
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
                        )
                      : Container(
                          child: Center(
                            child: CircularProgressIndicator(),
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
    );
  }

  void selectLiveFilter() {
    setState(() {
      strWebinarType = "live";
      isLive = true;
      isSelfStudy = false;
      isProgressShowing = true;

      list.clear();
      start = 0;

      this.getDataWebinarList('', '0', '10', '', '', '$searchKey', '$strWebinarType', '', '$strFilterPrice');
    });
  }

  void selectSelfStudyFilter() {
    setState(() {
      strWebinarType = "self_study";
      isLive = false;
      isSelfStudy = true;
      isProgressShowing = true;

      list.clear();
      start = 0;

      this.getDataWebinarList('', '0', '10', '', '', '$searchKey', '$strWebinarType', '', '$strFilterPrice');
    });
  }

  void selectPremiumFilter() {
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
  }

  selectCPDFilter() {
    /*setState(() {
      if (isCPD1) {
        isCPD1 = false;
      } else {
        isCPD1 = true;
      }
    });*/
  }

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
    if (strFee == "FREE") {
      finalFee = 'FREE';
    } else {
      // finalFee = 'data["payload']['webinar'][index]['fee"]';
      // finalFee = '\$ ${data['payload']['webinar'][index]['fee']}';
      finalFee = '\$ ${list[index].fee}';
    }

    return finalFee;
  }

  displayDateCondition(int index) {
    // '${data['payload']['webinar'][index]['start_date']} - ${data['payload']['webinar'][index]['start_time']} - ${data['payload']['webinar'][index]['time_zone']}',
    // String strStartDate = data['payload']['webinar'][index]['start_date'];
    String strStartDate = list[index].startDate;
    String day = "";
    String month = "";
    String year = "";

    /*if (month == "01") {
      month = "Jan";
    } else if (month == "02") {
    } else if (month == "03") {
    } else if (month == "04") {
    } else if (month == "05") {
    } else if (month == "06") {
    } else if (month == "07") {
    } else if (month == "08") {
    } else if (month == "09") {
    } else if (month == "10") {
    } else if (month == "11") {
    } else {}*/
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
    print('Check value is : $checkValue');

    if (checkValue != null) {
      setState(() {
        isLoaderShowing = true;
      });

      if (checkValue) {
        String token = preferences.getString("spToken");
        _authToken = 'Bearer $token';
        print('Auth Token from SP is : $_authToken');

        this.getDataWebinarList('$_authToken', '$start', '10', '', '', '$searchKey', '$strWebinarType', '', '$strFilterPrice');
        // print('init State isLive : $isLive');
        // print('init State isSelfStudy : $isSelfStudy');
      } else {
        this.getDataWebinarList('$_authToken', '$start', '10', '', '', '$searchKey', '$strWebinarType', '', '$strFilterPrice');
        // print('init State isLive : $isLive');
        // print('init State isSelfStudy : $isSelfStudy');
        print('Check value : $checkValue');
        preferences.clear();
      }
    } else {
      print('check value is null....');
      this.getDataWebinarList('$_authToken', '$start', '10', '', '', '$searchKey', '$strWebinarType', '', '$strFilterPrice');
      // print('init State isLive : $isLive');
      // print('init State isSelfStudy : $isSelfStudy');
      print('Check value : $checkValue');
      preferences.clear();
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

          this.getDataWebinarList('$_authToken', '$start', '10', '', '', '$searchKey', '$strWebinarType', '', '$strFilterPrice');
          // print('init State isLive : $isLive');
          // print('init State isSelfStudy : $isSelfStudy');
        } else {
          this.getDataWebinarList('', '$start', '10', '', '', '$searchKey', '$strWebinarType', '', '$strFilterPrice');
          // print('init State isLive : $isLive');
          // print('init State isSelfStudy : $isSelfStudy');
          print('Check value : $checkValue');
          preferences.clear();
        }
      }
    } else {
      if (!isLast) {
        start = start + 10;
        this.getDataWebinarList('', '$start', '10', '', '', '$searchKey', '$strWebinarType', '', '$strFilterPrice');
        // print('init State isLive : $isLive');
        // print('init State isSelfStudy : $isSelfStudy');
        print('Check value : $checkValue');
        preferences.clear();
      }
    }
  }
}

class selectedFilterWidget extends StatelessWidget {
  selectedFilterWidget({this.str});

  final String str;

  @override
  Widget build(BuildContext context) {
    return Padding(
      // padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 4.0, 8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18.0),
          color: Color(0xFF607083),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 9.0,
            horizontal: 18.0,
          ),
          child: Text(
            // 'Hot Topics',
            str,
            style: TextStyle(
              color: Colors.white,
              fontSize: 11.0.sp,
              fontFamily: 'Whitney Medium',
            ),
          ),
        ),
      ),
    );
  }
}
