import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:cpe_flutter/components/SpinKitSample1.dart';
import 'package:cpe_flutter/components/custom_dialog.dart';
import 'package:cpe_flutter/components/custom_dialog_register.dart';
import 'package:cpe_flutter/components/custom_dialog_two.dart';
import 'package:cpe_flutter/const_signup.dart';
import 'package:cpe_flutter/screens/final_quiz/final_quiz_screen.dart';
import 'package:cpe_flutter/screens/fragments/pagination/webinar_list_new.dart';
import 'package:cpe_flutter/screens/intro_login_signup/login.dart';
import 'package:cpe_flutter/screens/profile/guest_cards_frag.dart';
import 'package:cpe_flutter/screens/profile/notification.dart';
import 'package:cpe_flutter/screens/webinar_details/evaluation_form.dart';
import 'package:cpe_flutter/screens/webinar_details/pdf_preview_certificate.dart';
import 'package:cpe_flutter/screens/webinar_details/webinar_details_new.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constant.dart';
import '../../rest_api.dart';
import 'model_hot_topics/list_hot_topics.dart';
import 'model_qualifications/list_qualifications.dart';
import 'model_recentwebinar/recent_webinar_data.dart';

class HomeFragment extends StatefulWidget {
  @override
  _HomeFragmentState createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  final scaffoldState = GlobalKey<ScaffoldState>();

  // FocusNode _focusNode = FocusNode();

  List<int> tempInt = [1, 4, 5, 7];
  int arrCount = 0;
  int arrCountRecent = 0;
  var data;
  var dataMsg = '';
  var data_web;
  var data_recent;
  int arrCountHotTopics = 0;
  var dataHotTopics;
  var dataHotTopicsList;

  int arrCountQualifications = 0;
  var dataQualifications;
  var dataqualificationsList;

  int start = 0;

  bool isHotTopics = false;
  bool isLive = true;
  bool isSelfStudy = false;
  bool isPremium = false;
  bool isFree = false;
  bool isDateSelected = false;
  bool isCPD1 = false;

  String _authToken = "";

  String strWebinarType = "live";
  String strFilterPrice = "";
  String strWebinarTypeIntent = "";
  String strDateFilter = '';
  String strDateType = '';
  List<String> dateList = ['Today', 'Tomorrow', 'Next 7 Days', 'Next 30 Days'];

  bool isProgressShowing = false;
  bool isLoaderShowing = false;
  List<Webinar> list;
  List<RecentWebinars> recentList;
  List<Hot_topics> listHotTopics;
  List<Audiances> listQualifications;
  static List<String> hotTopicsId = [];
  static List<String> qualificationsId = [];

  var hot_topics_ids = '';
  var qualification_ids = '';
  bool isGuestUser = false;
  bool isFreeWebGRegist = false;

  bool isLast = false;
  bool isSearch = false;
  ScrollController _scrollController = new ScrollController();

  TextEditingController searchController = TextEditingController();
  var searchKey = "";

  var respStatus;
  var respMessage;

  TextEditingController nameController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expMonthController = TextEditingController();
  TextEditingController expYearController = TextEditingController();
  TextEditingController cvvController = TextEditingController();

  var selectedCertificateType = '';

  Future<List<Webinar>> getDataWebinarList(String authToken, String start, String limit, String topic_of_interest, String subject_area,
      String webinar_key_text, String webinar_type, String date_filter, String filter_price, String hot_topics_ids, String qualification_ids) async {
    var urls = Uri.parse(URLs.BASE_URL + 'webinar/list');
    // String urls = 'https://my-cpe.com/api/v3/webinar/list';

    print('Request Params authToken : $authToken');
    print('Request Params start : $start');
    print('Request Params limit : $limit');
    print('Request Params hot_topics : $hot_topics_ids');
    print('Request Params qualifications_ids : $qualification_ids');
    print('Request Params topic_of_interest : $topic_of_interest');
    print('Request Params subject_area : $subject_area');
    print('Request Params webinar_key_text : $webinar_key_text');
    print('Request Params webinar_type : $webinar_type');
    print('Request Params date_filter : $date_filter');
    print('Request Params filter_price : $filter_price');

    final response = await http.post(
      urls,
      headers: {
        'Accept': 'Application/json',
        'Authorization': '$authToken',
      },
      body: {
        'start': start,
        'limit': limit,
        // 'topic_of_interest': topic_of_interest,
        'subject_area': subject_area,
        'webinar_key_text': webinar_key_text,
        'webinar_type': webinar_type,
        'date_filter': date_filter,
        'filter_price': filter_price,
        'hot_topics': hot_topics_ids,
        'qualification_ids': qualification_ids,
      },
    );

    this.setState(() {
      // data = JSON.decode(response.body);
      data = jsonDecode(response.body);
      isLoaderShowing = false;
      isProgressShowing = false;
      if (data['payload']['is_last']) {
        isLast = true;
      } else {
        isLast = false;
      }
    });

    // print(data[1]["title"]);
    print('API response is : $data');
    dataMsg = data['message'];
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

    print('Staus for the isGuestRegisterWebinar : ${ConstSignUp.isGuestRegisterWebinar}');
    if (ConstSignUp.isGuestRegisterWebinar) {
      print('Staus for the isGuestRegisterWebinar : ${ConstSignUp.isGuestRegisterWebinar}');
      print('Staus for the isGuestRegisterWebinarId : ${ConstSignUp.strWebinarId}');
      print('Staus for the isGuestRegisterScheduleId : ${ConstSignUp.strScheduleId}');
      print('Staus for the isGuestRegisterWebinarType : ${ConstSignUp.strWebinarType}');
      print('Staus for the isGuestRegisterWebinar Free : ${ConstSignUp.isFreeWebinar}');
      print('Staus for the isGuestRegisterWebinar Fee : ${ConstSignUp.strFee}');

      if (ConstSignUp.isFreeWebinar) {
        // So here is the free webinar soo we can directly register the webinar..
        registerGuestRedirectWebinar(_authToken, ConstSignUp.strWebinarId, ConstSignUp.strScheduleId, ConstSignUp.strWebinarType);
        ConstSignUp.clearGuestRedirectionFlow();
      } else {
        // So here is the paid webinar soo we have to redirect to guestuserCards screen..
        Navigator.of(context)
            .push(
          MaterialPageRoute(
            builder: (context) => GuestCardFrag(
                ConstSignUp.strFee.toString(), int.parse(ConstSignUp.strWebinarId), ConstSignUp.strWebinarType, ConstSignUp.strScheduleId),
          ),
        )
            .then((_) {
          // Call setState() here or handle this appropriately
          setState(() {
            list.clear();
          });
          checkForSP();
        });
      }
    }

    // return "Success!";
    return list;
  }

  Future<List<Hot_topics>> getHotTopics() async {
    var urls = Uri.parse(URLs.BASE_URL + 'hot-topics');

    final response = await http.get(
      urls,
      headers: {
        'Accept': 'Application/json',
        // 'Authorization': '$authToken',
      },
    );

    this.setState(() {
      dataHotTopics = jsonDecode(response.body);
      isLoaderShowing = false;
    });

    // print(data[1]["title"]);
    print('API response hot topics is : $dataHotTopics');
    arrCountHotTopics = dataHotTopics['payload']['hot_topics'].length;
    dataHotTopicsList = dataHotTopics['payload']['hot_topics'];
    print('Size for array is : $arrCountHotTopics');

    if (listHotTopics != null && listHotTopics.isNotEmpty) {
      listHotTopics.addAll(List.from(dataHotTopicsList).map<Hot_topics>((item) => Hot_topics.fromJson(item)).toList());
    } else {
      listHotTopics = List.from(dataHotTopicsList).map<Hot_topics>((item) => Hot_topics.fromJson(item)).toList();
    }

    getQualificationList();

    return listHotTopics;
  }

  Future<List<Audiances>> getQualificationList() async {
    var urls = Uri.parse(URLs.BASE_URL + 'audiances');

    final response = await http.get(
      urls,
      headers: {
        'Accept': 'Application/json',
        // 'Authorization': '$authToken',
      },
    );

    this.setState(() {
      dataQualifications = jsonDecode(response.body);
      isLoaderShowing = false;
    });

    // print(data[1]["title"]);
    print('API response hot topics is : $dataQualifications');
    arrCountQualifications = dataQualifications['payload']['audiances'].length;
    dataqualificationsList = dataQualifications['payload']['audiances'];
    print('Size for array is : $arrCountQualifications');

    if (listQualifications != null && listQualifications.isNotEmpty) {
      listQualifications.addAll(List.from(dataqualificationsList).map<Audiances>((item) => Audiances.fromJson(item)).toList());
    } else {
      listQualifications = List.from(dataqualificationsList).map<Audiances>((item) => Audiances.fromJson(item)).toList();
    }

    return listQualifications;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hotTopicsId.clear();
    qualificationsId.clear();
    checkForInternet();

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
      key: scaffoldState,
      /*appBar: AppBar(
        title: Text(
          'My Webinar App Bar',
          style: TextStyle(
            fontSize: 30.0,
            color: Colors.teal,
          ),
        ),
      ),*/
      body: new WillPopScope(
          child: SafeArea(
            child: Stack(
              children: <Widget>[
                Positioned(
                    child: Column(
                  children: <Widget>[
                    /*Visibility(
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
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    list[0].status = 'Hello';
                                  });
                                  print('Updated status on the 0th position is : ${list[0].status}');
                                },
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
                                          _focusNode.addListener(() {
                                            if (!_focusNode.hasFocus) {
                                              FocusScope.of(context).requestFocus(_focusNode);
                                            }
                                          });
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
                                      child: Visibility(
                                        visible: isGuestUser ? false : true,
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
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),*/
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
                                    focusNode: _focusNode,
                                    autofocus: true,
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
                                        if (searchController.text.isNotEmpty) {
                                          print('Search keyword lenght is == 0');
                                          FocusScope.of(context).requestFocus(new FocusNode());
                                        } else {
                                          print('Search keyword lenght is > 0');
                                          FocusScope.of(context).requestFocus(new FocusNode());
                                          // Now take an API call for the search tag too..
                                          list.clear();
                                          start = 0;

                                          this.getDataWebinarList('', '0', '10', '', '', '$searchKey', '$strWebinarType', '', '$strFilterPrice',
                                              '$hot_topics_ids', '$qualification_ids');
                                        }
                                      });
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

                                        this.getDataWebinarList('', '0', '10', '', '', '$searchKey', '$strWebinarType', '', '$strFilterPrice',
                                            '$hot_topics_ids', '$qualification_ids');
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
                    /*Container(
                      height: 1.0,
                      width: double.infinity,
                      color: Colors.blueGrey,
                    ),*/
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            height: 60.0,
                            // color: Color(0xFFF3F5F9),
                            color: Colors.white,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                                child: Row(
                                  children: <Widget>[
                                    /*selectedFilterWidget(
                                    str: 'Test Filter',
                                  ),*/
                                    /*selectedFilterWidget(
                                        str: 'Hot Topics',
                                      ),*/
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          SystemChannels.textInput.invokeMethod('TextInput.hide');
                                          selectHotTopicsFilter();
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                        child: Container(
                                          decoration: hotTopicsId.length > 0
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
                                              'Topics',
                                              style: TextStyle(
                                                color: hotTopicsId.length > 0 ? Colors.white : Colors.black,
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
                                        setState(() {
                                          // selectHotTopicsFilter();
                                          SystemChannels.textInput.invokeMethod('TextInput.hide');
                                          selectQualificationsFilter();
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                        child: Container(
                                          decoration: qualificationsId.length > 0
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
                                              'Qualification',
                                              style: TextStyle(
                                                color: qualificationsId.length > 0 ? Colors.white : Colors.black,
                                                fontSize: 11.0.sp,
                                                fontFamily: 'Whitney Medium',
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    /*Padding(
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
                                        ),*/
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
                                              // 'Live Webinars',
                                              'Live',
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
                                    Visibility(
                                      visible: isLive ? true : false,
                                      child: GestureDetector(
                                        onTap: () {
                                          SystemChannels.textInput.invokeMethod('TextInput.hide');
                                          selectDateFilter();
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                          child: Container(
                                            decoration: isDateSelected
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
                                                'Date',
                                                style: TextStyle(
                                                  color: isDateSelected ? Colors.white : Colors.black,
                                                  fontSize: 11.0.sp,
                                                  fontFamily: 'Whitney Medium',
                                                ),
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
                          ),
                        ),
                        Container(
                          // color: Color(0xFFF3F5F9),
                          color: Colors.white,
                          // width: 20.0.sp,
                          height: 60.0,
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  print('Clicked on the search icon..');
                                  setState(() {
                                    isSearch = true;
                                    /*_focusNode.addListener(() {
                                      if (!_focusNode.hasFocus) {
                                        FocusScope.of(context).requestFocus(_focusNode);
                                      }
                                    });*/
                                  });
                                },
                                child: Container(
                                  width: 30.0.sp,
                                  height: double.infinity,
                                  // color: Color(0xFFF3F5F9),
                                  color: Colors.white,
                                  child: Icon(
                                    FontAwesomeIcons.search,
                                    size: 12.0.sp,
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: isGuestUser ? false : true,
                                child: GestureDetector(
                                  onTap: () {
                                    print('Clicked on notification icon');
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
                                    // color: Color(0xFFF3F5F9),
                                    color: Colors.white,
                                    child: Icon(
                                      FontAwesomeIcons.solidBell,
                                      size: 12.0.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    /*SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                        child: Row(
                          children: <Widget>[
                            selectedFilterWidget(
                              str: 'Test Filter',
                            ),
                            selectedFilterWidget(
                              str: 'Hot Topics',
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectHotTopicsFilter();
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                child: Container(
                                  decoration: hotTopicsId.length > 0
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
                                      'Topics',
                                      style: TextStyle(
                                        color: hotTopicsId.length > 0 ? Colors.white : Colors.black,
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
                                setState(() {
                                  // selectHotTopicsFilter();
                                  selectQualificationsFilter();
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                child: Container(
                                  decoration: qualificationsId.length > 0
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
                                      'Qualification',
                                      style: TextStyle(
                                        color: qualificationsId.length > 0 ? Colors.white : Colors.black,
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
                                      // 'Live Webinars',
                                      'Live',
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
                            Visibility(
                              visible: isLive ? true : false,
                              child: GestureDetector(
                                onTap: () {
                                  selectDateFilter();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                  child: Container(
                                    decoration: isDateSelected
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
                                        'Date',
                                        style: TextStyle(
                                          color: isDateSelected ? Colors.white : Colors.black,
                                          fontSize: 11.0.sp,
                                          fontFamily: 'Whitney Medium',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),*/
                    Visibility(
                      visible: isSearch,
                      child: Container(
                        height: 50.0,
                        // width: double.infinity,
                        // color: Color(0xFFF3F5F9),
                        color: Colors.white,
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
                                    color: searchbarColor,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: TextField(
                                    controller: searchController,
                                    // focusNode: _focusNode,
                                    autofocus: true,
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
                                        if (searchController.text.isNotEmpty) {
                                          print('Search keyword lenght is > 0');
                                          // FocusScope.of(context).requestFocus(new FocusNode());
                                          // FocusScope.of(context).unfocus();
                                          // _focusNode.unfocus();
                                          // FocusManager.instance.primaryFocus?.unfocus();
                                          /*if (!currentFocus.hasPrimaryFocus) {
                                            currentFocus.unfocus();
                                          }*/

                                          SystemChannels.textInput.invokeMethod('TextInput.hide');
                                          // Now take an API call for the search tag too..
                                          list.clear();
                                          start = 0;

                                          this.getDataWebinarList('$_authToken', '0', '10', '', '', '$searchKey', '$strWebinarType', '',
                                              '$strFilterPrice', '$hot_topics_ids', '$qualification_ids');
                                        } else {
                                          print('Search keyword lenght is == 0');
                                          FocusScope.of(context).requestFocus(new FocusNode());
                                        }
                                      });
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

                                        this.getDataWebinarList('$_authToken', '0', '10', '', '', '$searchKey', '$strWebinarType', '',
                                            '$strFilterPrice', '$hot_topics_ids', '$qualification_ids');
                                      }
                                    });
                                  },
                                  child: Container(
                                    height: double.infinity,
                                    // color: Color(0xFFF3F5F9),
                                    color: Colors.white,
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
                    Expanded(
                      child: Container(
                        color: Colors.white,
                        child: isProgressShowing
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : (list != null && list.isNotEmpty)
                                ? RefreshIndicator(
                                    onRefresh: () {
                                      print('On refresh is called..');
                                      start = 0;
                                      list.clear();
                                      return this.getDataWebinarList('$_authToken', '0', '10', '', '', '$searchKey', '$strWebinarType', '',
                                          '$strFilterPrice', '$hot_topics_ids', '$qualification_ids');
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
                                            // : (index == 0 && isSelfStudy && arrCountRecent != 0 && start == 0)
                                            : (index == 0 && isSelfStudy && arrCountRecent > 0)
                                                ? Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                                        height: 128.0.sp,
                                                        child: ListView.builder(
                                                          scrollDirection: Axis.horizontal,
                                                          itemCount: recentList.length,
                                                          shrinkWrap: true,
                                                          itemBuilder: (context, index) {
                                                            return Container(
                                                              // color: Colors.blueGrey,
                                                              margin: EdgeInsets.fromLTRB(3.5.w, 1.0.h, 0.0, 2.0.h),
                                                              child: Column(
                                                                children: <Widget>[
                                                                  Container(
                                                                    // margin: EdgeInsets.fromLTRB(3.5.w, 1.0.h, 0.0, 2.0.h),
                                                                    height: 100.0.sp,
                                                                    width: 55.0.w,
                                                                    decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(10.0.sp),
                                                                      color: Colors.teal,
                                                                    ),
                                                                    child: Stack(
                                                                      children: <Widget>[
                                                                        Positioned(
                                                                          child: Image.asset(
                                                                            'assets/bg_image_recent.png',
                                                                            height: 100.0.sp,
                                                                            width: 55.0.w,
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
                                                                                      fontSize: 9.0.sp,
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
                                                                                      // getIdWebinar(index);
                                                                                      redirectToRecentDetails(index);
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
                                                                  ),
                                                                  // Text('Hello'),
                                                                  Container(
                                                                    height: 3.0.sp,
                                                                    width: 55.0.w,
                                                                    margin: EdgeInsets.only(top: 4.0.sp),
                                                                    decoration: BoxDecoration(
                                                                      color: progressBackground,
                                                                      borderRadius: BorderRadius.circular(3.0.sp),
                                                                    ),
                                                                    child: Row(
                                                                      children: <Widget>[
                                                                        new Flexible(
                                                                          child: Container(
                                                                            decoration: BoxDecoration(
                                                                              color: themeYellow,
                                                                              borderRadius: BorderRadius.circular(3.0.sp),
                                                                            ),
                                                                          ),
                                                                          flex: double.parse(recentList[index].watched).toInt(),
                                                                        ),
                                                                        new Flexible(
                                                                          child: Container(
                                                                            decoration: BoxDecoration(
                                                                              color: progressBackground,
                                                                              borderRadius: BorderRadius.only(
                                                                                  topRight: Radius.circular(3.0.sp),
                                                                                  bottomRight: Radius.circular(3.0.sp)),
                                                                            ),
                                                                          ),
                                                                          // flex: 80,
                                                                          flex: 100 - double.parse(recentList[index].watched).toInt(),
                                                                        ),
                                                                      ],
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
                                                      redirectToDetails(index);
                                                    },
                                                    child: Container(
                                                      // margin: EdgeInsets.only(top: 10.0),
                                                      margin: EdgeInsets.fromLTRB(3.5.w, 0.0.h, 3.5.w, 2.0.h),
                                                      decoration: BoxDecoration(
                                                        // color: Color(0xFFFFC803),
                                                        // color: index % 2 == 0 ? Color(0xFFFFC803) : Color(0xFF00B1FD),
                                                        color: setCardColor(index),
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
                                                                        constraints: BoxConstraints(minWidth: 24.0.w),
                                                                        child: Container(
                                                                          margin: EdgeInsets.only(left: 15.0),
                                                                          height: 4.0.h,
                                                                          decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.circular(5.0),
                                                                            color: Colors.white,
                                                                          ),
                                                                          child: Padding(
                                                                            padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
                                                                            child: Center(
                                                                              child: Text(
                                                                                  // '${data['payload']['webinar'][index]['webinar_type']}',
                                                                                  '${list[index].webinarType}',
                                                                                  style:
                                                                                      // kWebinarButtonLabelTextStyleGreen,
                                                                                      TextStyle(
                                                                                    fontFamily: 'Whitney Semi Bold',
                                                                                    fontSize: 10.0.sp,
                                                                                    // color: Color(0xFF00A81B),
                                                                                    color: Colors.black,
                                                                                  )),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      ConstrainedBox(
                                                                        constraints: BoxConstraints(minWidth: 24.0.w),
                                                                        child: Container(
                                                                          height: 4.0.h,
                                                                          decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.circular(5.0),
                                                                            color: Colors.white,
                                                                          ),
                                                                          child: Padding(
                                                                            padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
                                                                            child: Center(
                                                                              child: Text(
                                                                                  // '${data['payload']['webinar'][index]['cpa_credit']}',
                                                                                  '${list[index].cpaCredit}',
                                                                                  style:
                                                                                      // kWebinarButtonLabelTextStyle,
                                                                                      TextStyle(
                                                                                    fontFamily: 'Whitney Semi Bold',
                                                                                    fontSize: 10.0.sp,
                                                                                    color: Colors.black,
                                                                                  )),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      ConstrainedBox(
                                                                        constraints: BoxConstraints(minWidth: 24.0.w),
                                                                        child: Container(
                                                                          margin: EdgeInsets.only(right: 15.0),
                                                                          height: 4.0.h,
                                                                          decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.circular(5.0),
                                                                            color: Colors.white,
                                                                          ),
                                                                          child: Padding(
                                                                            padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
                                                                            child: Center(
                                                                              child: Text(
                                                                                  // '\$ ${data['payload']['webinar'][index]['fee']}',
                                                                                  '${checkForPrice(index)}',
                                                                                  style:
                                                                                      // kWebinarButtonLabelTextStyle,
                                                                                      TextStyle(
                                                                                    fontFamily: 'Whitney Semi Bold',
                                                                                    fontSize: 10.0.sp,
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
                                                                        fontSize: 15.0.sp,
                                                                        // color: index % 2 == 0 ? Colors.black : Colors.white,
                                                                        color: Colors.white,
                                                                      ),
                                                                      maxLines: 3,
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
                                                                            // color: index % 2 == 0 ? Colors.black : Colors.white,
                                                                            color: Colors.white,
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
                                                                          // color: index % 2 == 0 ? Colors.black : Colors.white,
                                                                          color: Colors.white,
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
                                                                  height: 10.5.w,
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
                                                              /*index % 2 == 0
                                                                  ? 'assets/avatar_bottom_right.png'
                                                                  : 'assets/avtar_bottom_right_even.png',*/
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
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 20.0.sp),
                                      child: Text(
                                        'Sorry, we couldn\'t find webinars based on your filters',
                                        // '$dataMsg',
                                        style: kValueLableWebinarDetailExpand,
                                      ),
                                    ),
                                  ), /*Container(
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),*/
                      ),
                    ),
                  ],
                )),
                Positioned(
                  bottom: 0.0,
                  right: 0.0,
                  left: 0.0,
                  top: 100.0,
                  child: Visibility(
                    visible: isLoaderShowing ? true : false,
                    child: SpinKitSample1(),
                  ),
                ),
              ],
            ),
          ),
          onWillPop: _onWillPop),
    );
  }

  Future<bool> _onWillPop() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialogTwo(
            "Confirm Exit?",
            "Are you sure you want to exit the app?",
            "Yes",
            "No",
            () {
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            },
            () {
              Navigator.pop(context);
            },
          );
        });
    /*return showDialog(
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
        false;*/
  }

  void selectLiveFilter() {
    setState(() {
      strWebinarType = "live";
      isLive = true;
      isSelfStudy = false;
      isProgressShowing = true;

      list.clear();
      start = 0;

      this.getDataWebinarList('$_authToken', '0', '10', '', '', '$searchKey', '$strWebinarType', '$strDateType', '$strFilterPrice', '$hot_topics_ids',
          '$qualification_ids');
    });
  }

  void selectSelfStudyFilter() {
    setState(() {
      strWebinarType = "self_study";
      isLive = false;
      isSelfStudy = true;
      isDateSelected = false;
      strDateFilter = '';
      strDateType = '';
      isProgressShowing = true;

      list.clear();
      start = 0;

      this.getDataWebinarList(
          '$_authToken', '0', '10', '', '', '$searchKey', '$strWebinarType', '', '$strFilterPrice', '$hot_topics_ids', '$qualification_ids');
    });
  }

  void selectPremiumFilter() {
    setState(() {
      /*if (isPremium) {
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
      }*/
      if (isPremium) {
        isPremium = false;
        isFree = false;

        strFilterPrice = "";
        list.clear();
        start = 0;
        isProgressShowing = true;
        this.getDataWebinarList('$_authToken', '0', '10', '', '', '$searchKey', '$strWebinarType', '$strDateType', '$strFilterPrice',
            '$hot_topics_ids', '$qualification_ids');
      } else {
        isPremium = true;
        isFree = false;

        strFilterPrice = "1";
        list.clear();
        start = 0;
        isProgressShowing = true;
        this.getDataWebinarList('$_authToken', '0', '10', '', '', '$searchKey', '$strWebinarType', '$strDateType', '$strFilterPrice',
            '$hot_topics_ids', '$qualification_ids');
      }
    });
  }

  void selectFreeFilter() {
    setState(() {
      /*if (isFree) {
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
      }*/
      if (isFree) {
        isFree = false;
        isPremium = false;

        strFilterPrice = "";
        list.clear();
        start = 0;
        isProgressShowing = true;
        this.getDataWebinarList('$_authToken', '0', '10', '', '', '$searchKey', '$strWebinarType', '$strDateType', '$strFilterPrice',
            '$hot_topics_ids', '$qualification_ids');
      } else {
        isFree = true;
        isPremium = false;

        strFilterPrice = "0";
        list.clear();
        start = 0;
        isProgressShowing = true;
        this.getDataWebinarList('$_authToken', '0', '10', '', '', '$searchKey', '$strWebinarType', '$strDateType', '$strFilterPrice',
            '$hot_topics_ids', '$qualification_ids');
      }
    });
  }

  void selectDateFilter() {
    setState(() {
      showModalBottomSheet(
          context: context,
          builder: (builder) {
            return StatefulBuilder(
              builder: (BuildContext context, void Function(void Function()) setState) {
                return Container(
                  height: 150.0.w,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 17.0.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                setState(() {
                                  isDateSelected = false;
                                  strDateFilter = '';
                                  isDateSelected = false;

                                  strDateType = '';

                                  list.clear();
                                  start = 0;

                                  isProgressShowing = true;

                                  this.getDataWebinarList('$_authToken', '$start', '10', '', '', '$searchKey', '$strWebinarType', '',
                                      '$strFilterPrice', '$hot_topics_ids', '$qualification_ids');
                                });
                              },
                              child: Container(
                                width: 20.0.w,
                                child: Center(
                                  child: Text(
                                    'Clear',
                                    style: kDateTestimonials,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 50.0.w,
                              child: Center(
                                child: Text(
                                  'Date',
                                  style: kOthersTitle,
                                ),
                              ),
                            ),
                            Container(
                              width: 20.0.w,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: dateList.length,
                          itemBuilder: (context, index) {
                            return ConstrainedBox(
                              constraints: BoxConstraints(
                                minHeight: 15.0.w,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    // clickEventOrgSize(index);
                                    clickEventDateFilter(index);
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(3.0.w, 3.0.w, 3.0.w, 0.0),
                                  decoration: BoxDecoration(
                                    color: strDateFilter == dateList[index] ? themeYellow : testColor,
                                    borderRadius: BorderRadius.circular(7.0),
                                    // color: Colors.teal,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 3.5.w, horizontal: 3.5.w),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Text(
                                            dateList[index],
                                            textAlign: TextAlign.start,
                                            style: kDataSingleSelectionBottomNav,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          });
    });
  }

  void selectQualificationsFilter() {
    if (arrCountHotTopics == 0) {
      Fluttertoast.showToast(
          msg: "Oops we didn't get Qualifications",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: toastBackgroundColor,
          textColor: toastTextColor,
          fontSize: 16.0);
      /*scaffoldState.currentState.showSnackBar(
        SnackBar(
          content: Text("Oops we didn't get Qualifications"),
          duration: Duration(seconds: 3),
        ),
      );*/
      Future.delayed(const Duration(seconds: 3), () {
        // Take API call for getting hot topics again..
        print('API call for get Qualifications is needed..');
      });
    } else {
      setState(() {
        showModalBottomSheet(
            context: context,
            builder: (builder) {
              return StatefulBuilder(
                builder: (BuildContext context, void Function(void Function()) setState) {
                  return Container(
                    height: 150.0.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 17.0.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  width: 20.0.w,
                                  child: Center(
                                    child: Text(
                                      'Cancel',
                                      style: kDateTestimonials,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 50.0.w,
                                child: Center(
                                  child: Text(
                                    'Qualifications',
                                    style: kOthersTitle,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    qualificationsId.clear();
                                    qualification_ids = "";
                                    for (int i = 0; i < listQualifications.length; i++) {
                                      listQualifications[i].isSelected = false;
                                    }

                                    isProgressShowing = true;

                                    list.clear();
                                    start = 0;

                                    this.getDataWebinarList('$_authToken', '0', '10', '', '', '$searchKey', '$strWebinarType', '$strDateType',
                                        '$strFilterPrice', '$hot_topics_ids', '$qualification_ids');
                                  });
                                },
                                child: Container(
                                  width: 20.0.w,
                                  child: Center(
                                    child: Text(
                                      'Clear',
                                      style: kDateTestimonials,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: qualificationsId.length > 0 ? true : false,
                          child: SingleChildScrollView(
                            child: Container(
                              margin: EdgeInsets.fromLTRB(3.0.w, 0, 3.0.w, 1.5.w),
                              child: Wrap(
                                children: List.generate(listQualifications.length, (i) {
                                  return Visibility(
                                    visible: listQualifications[i].isSelected ? true : false,
                                    child: ConstrainedBox(
                                      constraints: BoxConstraints(
                                        minWidth: 25.0.sp,
                                      ),
                                      child: Container(
                                        margin: EdgeInsets.only(right: 8.0, bottom: 8.0),
                                        padding: EdgeInsets.only(left: 8.0.sp, right: 8.0.sp),
                                        height: 25.0.sp,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30.0),
                                          border: Border.all(
                                            color: listQualifications[i].isSelected ? themeYellow : Color(0xFFB4C2D3),
                                            width: 1.0,
                                          ),
                                          color: Color(0xFFFFFFFF),
                                          // color: listQualifications[i].isSelected ? Colors.blue : Color(0xFFFFFFFF),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            GestureDetector(
                                              onTap: () {
                                                print('Clicked on UNCHECK id: ${listQualifications[i].id} & title : ${listQualifications[i].title} & '
                                                    'short'
                                                    ' title : '
                                                    '${listQualifications[i].shortTitle}');
                                                setState(() {
                                                  clickEventQualifications(i);
                                                });
                                              },
                                              child: Icon(
                                                FontAwesomeIcons.times,
                                                color: themeYellow,
                                                size: 11.0.sp,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5.0.sp,
                                            ),
                                            Text(
                                              '${listQualifications[i].shortTitle}',
                                              style: TextStyle(
                                                fontFamily: 'Whitney Medium',
                                                fontSize: 11.0.sp,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: qualificationsId.length > 0 ? true : false,
                          child: Container(
                            height: 1.0,
                            color: Colors.black,
                            margin: EdgeInsets.fromLTRB(3.0.w, 0, 3.0.w, 3.0.w),
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Container(
                              margin: EdgeInsets.fromLTRB(3.0.w, 0, 3.0.w, 5.0.w),
                              child: Wrap(
                                children: List.generate(
                                  listQualifications.length,
                                  (i) {
                                    return GestureDetector(
                                      onTap: () {
                                        print('Clicked on id: ${listQualifications[i].id} & title : ${listQualifications[i].title} & short title : '
                                            '${listQualifications[i].shortTitle}');
                                        setState(() {
                                          clickEventQualifications(i);
                                        });
                                      },
                                      child: Visibility(
                                        visible: listQualifications[i].isSelected ? false : true,
                                        child: Container(
                                          // margin: EdgeInsets.symmetric(horizontal: 4.0, vertical: 0.0),
                                          margin: EdgeInsets.only(right: 8.0, bottom: 8.0),
                                          // child: FilterChip(
                                          child: ConstrainedBox(
                                            constraints: BoxConstraints(
                                              minWidth: 25.0.sp,
                                            ),
                                            child: Container(
                                              padding: EdgeInsets.only(left: 8.0.sp, right: 8.0.sp, top: 5.0.sp),
                                              height: 25.0.sp,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(30.0),
                                                border: Border.all(
                                                  color: Color(0xFFB4C2D3),
                                                  width: 1.0,
                                                ),
                                                color: Color(0xFFFFFFFF),
                                                // color: listQualifications[i].isSelected ? Colors.blue : Color(0xFFFFFFFF),
                                              ),
                                              child: Text(
                                                '${listQualifications[i].shortTitle.toString()}',
                                                style: TextStyle(
                                                  fontFamily: 'Whitney Medium',
                                                  fontSize: 11.0.sp,
                                                  color: Colors.black,
                                                ),
                                              ),
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
                          /*ListView.builder(
                              itemCount: arrCountQualifications,
                              itemBuilder: (context, index) {
                                return ConstrainedBox(
                                  constraints: BoxConstraints(
                                    minHeight: 15.0.w,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        // clickEventDateFilter(index);
                                        clickEventQualifications(index);
                                      });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(3.0.w, 3.0.w, 3.0.w, 0.0),
                                      decoration: BoxDecoration(
                                        color: listQualifications[index].isSelected ? themeYellow : testColor,
                                        // color: Colors.teal,
                                        borderRadius: BorderRadius.circular(7.0),
                                        // color: Colors.teal,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(vertical: 3.5.w, horizontal: 3.5.w),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Expanded(
                                              child: Text(
                                                listQualifications[index].shortTitle,
                                                textAlign: TextAlign.start,
                                                style: kDataSingleSelectionBottomNav,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),*/
                        ),
                      ],
                    ),
                  );
                },
              );
            });
      });
    }
  }

  void selectHotTopicsFilter() {
    // if (listHotTopics.length == 0) {
    if (arrCountHotTopics == 0) {
      Fluttertoast.showToast(
          msg: "Oops we didn't get Hot Topics",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: toastBackgroundColor,
          textColor: toastTextColor,
          fontSize: 16.0);
      /*scaffoldState.currentState.showSnackBar(
        SnackBar(
          content: Text("Oops we didn't get Hot Topics"),
          duration: Duration(seconds: 3),
        ),
      );*/
      Future.delayed(const Duration(seconds: 3), () {
        // Take API call for getting hot topics again..
        print('API call for get Hot Topics is needed..');
      });
    } else {
      setState(() {
        showModalBottomSheet(
            context: context,
            builder: (builder) {
              return StatefulBuilder(
                builder: (BuildContext context, void Function(void Function()) setState) {
                  return Container(
                    height: 150.0.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 17.0.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  width: 20.0.w,
                                  child: Center(
                                    child: Text(
                                      'Cancel',
                                      style: kDateTestimonials,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 50.0.w,
                                child: Center(
                                  child: Text(
                                    'Topics',
                                    style: kOthersTitle,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    hotTopicsId.clear();
                                    for (int i = 0; i < listHotTopics.length; i++) {
                                      listHotTopics[i].isSelected = false;
                                    }

                                    hot_topics_ids = "";

                                    isProgressShowing = true;

                                    list.clear();
                                    start = 0;

                                    this.getDataWebinarList('$_authToken', '0', '10', '', '', '$searchKey', '$strWebinarType', '$strDateType',
                                        '$strFilterPrice', '$hot_topics_ids', '$qualification_ids');
                                  });
                                },
                                child: Container(
                                  width: 20.0.w,
                                  child: Center(
                                    child: Text(
                                      'Clear',
                                      style: kDateTestimonials,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: hotTopicsId.length > 0 ? true : false,
                          child: SingleChildScrollView(
                            child: Container(
                              margin: EdgeInsets.fromLTRB(3.0.w, 0, 3.0.w, 1.5.w),
                              child: Wrap(
                                children: List.generate(arrCountHotTopics, (i) {
                                  return Visibility(
                                    visible: listHotTopics[i].isSelected ? true : false,
                                    child: ConstrainedBox(
                                      constraints: BoxConstraints(
                                        minWidth: 25.0.sp,
                                      ),
                                      child: Container(
                                        margin: EdgeInsets.only(right: 8.0, bottom: 8.0),
                                        padding: EdgeInsets.only(left: 8.0.sp, right: 8.0.sp),
                                        height: 25.0.sp,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30.0),
                                          border: Border.all(
                                            color: listHotTopics[i].isSelected ? themeYellow : Color(0xFFB4C2D3),
                                            width: 1.0,
                                          ),
                                          color: Color(0xFFFFFFFF),
                                          // color: listQualifications[i].isSelected ? Colors.blue : Color(0xFFFFFFFF),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            GestureDetector(
                                              onTap: () {
                                                /*print('Clicked on UNCHECK id: ${listQualifications[i].id} & title : ${listQualifications[i].title} & '
                                                    'short'
                                                    ' title : '
                                                    '${listHotTopics[i].name.toString()}');*/
                                                setState(() {
                                                  clickEventHotTopics(i);
                                                });
                                              },
                                              child: Icon(
                                                FontAwesomeIcons.times,
                                                color: themeYellow,
                                                size: 11.0.sp,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5.0.sp,
                                            ),
                                            Text(
                                              '${listHotTopics[i].name}',
                                              style: TextStyle(
                                                fontFamily: 'Whitney Medium',
                                                fontSize: 11.0.sp,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: hotTopicsId.length > 0 ? true : false,
                          child: Container(
                            height: 1.0,
                            color: Colors.black,
                            margin: EdgeInsets.fromLTRB(3.0.w, 0, 3.0.w, 3.0.w),
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Container(
                              margin: EdgeInsets.fromLTRB(3.0.w, 0, 3.0.w, 5.0.w),
                              child: Wrap(
                                children: List.generate(
                                  arrCountHotTopics,
                                  (i) {
                                    return GestureDetector(
                                      onTap: () {
                                        /*print('Clicked on id: ${listQualifications[i].id} & title : ${listQualifications[i].title} & short title : '
                                            '${listQualifications[i].shortTitle}');*/
                                        setState(() {
                                          clickEventHotTopics(i);
                                        });
                                      },
                                      child: Visibility(
                                        visible: listHotTopics[i].isSelected ? false : true,
                                        child: Container(
                                          // margin: EdgeInsets.symmetric(horizontal: 4.0, vertical: 0.0),
                                          margin: EdgeInsets.only(right: 8.0, bottom: 8.0),
                                          // child: FilterChip(
                                          child: ConstrainedBox(
                                            constraints: BoxConstraints(
                                              minWidth: 25.0.sp,
                                            ),
                                            child: Container(
                                              padding: EdgeInsets.only(left: 8.0.sp, right: 8.0.sp, top: 5.0.sp),
                                              height: 25.0.sp,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(30.0),
                                                border: Border.all(
                                                  color: Color(0xFFB4C2D3),
                                                  width: 1.0,
                                                ),
                                                color: Color(0xFFFFFFFF),
                                                // color: listQualifications[i].isSelected ? Colors.blue : Color(0xFFFFFFFF),
                                              ),
                                              child: Text(
                                                '${listHotTopics[i].name.toString()}',
                                                style: TextStyle(
                                                  fontFamily: 'Whitney Medium',
                                                  fontSize: 11.0.sp,
                                                  color: Colors.black,
                                                ),
                                              ),
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
                          /*child: ListView.builder(
                            itemCount: arrCountHotTopics,
                            itemBuilder: (context, index) {
                              return ConstrainedBox(
                                constraints: BoxConstraints(
                                  minHeight: 15.0.w,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      // clickEventDateFilter(index);
                                      clickEventHotTopics(index);
                                    });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(3.0.w, 3.0.w, 3.0.w, 0.0),
                                    decoration: BoxDecoration(
                                      color: listHotTopics[index].isSelected ? themeYellow : testColor,
                                      // color: Colors.teal,
                                      borderRadius: BorderRadius.circular(7.0),
                                      // color: Colors.teal,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 3.5.w, horizontal: 3.5.w),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Expanded(
                                            child: Text(
                                              listHotTopics[index].name,
                                              textAlign: TextAlign.start,
                                              style: kDataSingleSelectionBottomNav,
                                            ),
                                          ),
                                          Visibility(
                                            // visible: listHotTopics[index].hot_topic.toString() == '1' ? true : false,
                                            visible: listHotTopics[index].hot_topic.toString() == '1' ? false : false,
                                            child: Container(
                                              height: 18.0.sp,
                                              width: 54.0.sp,
                                              padding: EdgeInsets.only(left: 5.0.sp, right: 5.0.sp),
                                              child: Image.asset('assets/hot_topic.png'),
                                              */ /*child: Center(
                                                child: Text(
                                                  'HOT TOPIC',
                                                  style: TextStyle(
                                                    fontSize: 8.0.sp,
                                                    fontFamily: 'Whitney Bold',
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(2.0.sp),
                                                border: Border.all(color: Colors.red, width: 1.0.sp),
                                                // color: Color(0xFF607083),
                                              ),*/ /*
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),*/
                        ),
                      ],
                    ),
                  );
                },
              );
            });
      });
    }
  }

  void getIdWebinar(int index) async {
    // int webinarId = data['payload']['webinar'][index]['id'];
    int webinarId = list[index].id;
    String strWebinarId = webinarId.toString();
    // strWebinarTypeIntent = data['payload']['webinar'][index]['webinar_type'];
    strWebinarTypeIntent = list[index].webinarType;
    print('Id for the webinar is : $webinarId');
    print('String for strWebinarID : $strWebinarId');

    var connectivityResult = await (Connectivity().checkConnectivity());
    if ((connectivityResult == ConnectivityResult.mobile) || (connectivityResult == ConnectivityResult.wifi)) {
      if (strWebinarTypeIntent.toLowerCase() == 'live') {
        print('Webinar Type is live');
        if (list[index].status.toLowerCase() == 'register') {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          bool checkValue = preferences.getBool("check");
          print('Check value is : $checkValue');
          if (checkValue != null) {
            if (checkValue) {
              if (list[index].fee == 'FREE' || list[index].fee == '') {
                setState(() {
                  isLoaderShowing = true;
                });
                registerWebinar(_authToken, index, webinarId);
              } else {
                // Here we need to check for card status..
                // If card is saved then have to register webinar and redirect user to webinar details screen..
                // Else we need to redirect user to the add card screen..

                // showCustomCardPopup(index, list[index].fee.toString());
                int webinarId = list[index].id;
                String scheduleId = list[index].scheduleId.toString();
                // String strWebinarId = webinarId.toString();
                strWebinarTypeIntent = list[index].webinarType;
                /*Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GuestCardFrag(list[index].fee.toString(), webinarId, strWebinarTypeIntent, scheduleId),
                  ),
                );*/
                Navigator.of(context)
                    .push(
                  MaterialPageRoute(
                    builder: (context) => GuestCardFrag(list[index].fee.toString(), webinarId, strWebinarTypeIntent, scheduleId),
                  ),
                )
                    .then((_) {
                  // Call setState() here or handle this appropriately
                  setState(() {
                    list.clear();
                  });
                  checkForSP();
                });
              }
            } else {
              checkForWebinarFee(index);
              loginPopup(list[index].id.toString(), list[index].scheduleId.toString(), list[index].webinarType.toString(), isFreeWebGRegist,
                  list[index].fee.toString());
            }
          } else {
            checkForWebinarFee(index);
            loginPopup(list[index].id.toString(), list[index].scheduleId.toString(), list[index].webinarType.toString(), isFreeWebGRegist,
                list[index].fee.toString());
          }
        } else if (list[index].status.toLowerCase() == 'completed') {
          redirectToDetails(index);
        } else if (list[index].status.toLowerCase() == 'in progress') {
          // redirectToDetails(index);
          if (list[index].zoomLinkStatus) {
            funRedirectJoinWebinar(index);
          } else {
            showDialogJoinWebinar(index);
          }
        } else if (list[index].status.toLowerCase() == 'pending evaluation') {
          // redirectToDetails(index);
          getEvaluationFormLinkMethod(list[index].id.toString());
        } else if (list[index].status.toLowerCase() == 'my certificate') {
          // redirectToDetails(index);
          // First we need to check for the certificate links..
          // If the certificate links are available then have to redirect to certificate preview screen..
          funRedirectMyCertificate(index);
        } else if (list[index].status.toLowerCase() == 'join webinar') {
          // redirectToDetails(index);
          if (list[index].zoomLinkStatus) {
            funRedirectJoinWebinar(index);
          } else {
            showDialogJoinWebinar(index);
          }
        } else if (list[index].status.toLowerCase() == 'watch now') {
          // redirectToDetails(index);
          if (list[index].zoomLinkStatus) {
            funRedirectJoinWebinar(index);
          } else {
            showDialogJoinWebinar(index);
          }
        }
      } else if (strWebinarTypeIntent.toLowerCase() == 'self_study' || strWebinarTypeIntent.toLowerCase() == 'on-demand') {
        print('Webinar Type is self_study');
        if (list[index].status.toLowerCase() == 'register') {
          // Need to verify the user is logged in or not..
          // If user is not logged in then hava to show alert popup for login..
          // else have to check for the pricing..
          // if the webinar is free then
          SharedPreferences preferences = await SharedPreferences.getInstance();
          bool checkValue = preferences.getBool("check");
          print('Check value is : $checkValue');
          if (checkValue != null) {
            if (checkValue) {
              if (list[index].fee == 'FREE' || list[index].fee == '') {
                // Here are the free webinars so we can register these webinar directly and redirect user to webinar details screen..
                setState(() {
                  // isProgressShowing = true;
                  isLoaderShowing = true;
                });
                registerWebinar(_authToken, index, webinarId);
              } else {
                // Here we need to check for card status..
                // If card is saved then have to register webinar and redirect user to webinar details screen..
                // Else we need to redirect user to the add card screen..

                // showCustomCardPopup(index, list[index].fee.toString());
                int webinarId = list[index].id;
                String scheduleId = list[index].scheduleId.toString();
                // String strWebinarId = webinarId.toString();
                strWebinarTypeIntent = list[index].webinarType;
                /*Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GuestCardFrag(list[index].fee.toString(), webinarId, strWebinarTypeIntent, scheduleId),
                  ),
                );*/
                Navigator.of(context)
                    .push(
                  MaterialPageRoute(
                    builder: (context) => GuestCardFrag(list[index].fee.toString(), webinarId, strWebinarTypeIntent, scheduleId),
                  ),
                )
                    .then((_) {
                  // Call setState() here or handle this appropriately
                  setState(() {
                    list.clear();
                  });
                  checkForSP();
                });
              }
            } else {
              checkForWebinarFee(index);
              loginPopup(list[index].id.toString(), list[index].scheduleId.toString(), list[index].webinarType.toString(), isFreeWebGRegist,
                  list[index].fee.toString());
            }
          } else {
            checkForWebinarFee(index);
            loginPopup(list[index].id.toString(), list[index].scheduleId.toString(), list[index].webinarType.toString(), isFreeWebGRegist,
                list[index].fee.toString());
          }
          print('webinar status is : ${list[index].status.toLowerCase()}');
        } else if (list[index].status.toLowerCase() == 'quiz pending') {
          // redirectToDetails(index);
          funRedirectQuizPending(index);
        } else if (list[index].status.toLowerCase() == 'resume watching' || list[index].status.toLowerCase() == 'resume now') {
          redirectToDetails(index);
        } else if (list[index].status.toLowerCase() == 'watch now') {
          redirectToDetails(index);
        } else if (list[index].status.toLowerCase() == 'enrolled') {
          redirectToDetails(index);
        } else if (list[index].status.toLowerCase() == 'pending evaluation') {
          // redirectToDetails(index);
          getEvaluationFormLinkMethod(list[index].id.toString());
        } else if (list[index].status.toLowerCase() == 'completed') {
          redirectToDetails(index);
        } else if (list[index].status.toLowerCase() == 'my certificate') {
          // First we need to check for the certificate links..
          // If the certificate links are available then have to redirect to certificate preview screen..
          funRedirectMyCertificate(index);
        } else {
          print('Couldn\'t handle the case on selfstudy webinars.');
        }
      } else {
        print('Webinar Type is not found');
      }
    } else {
      Fluttertoast.showToast(
          msg: "Please check your internet connectivity and try again",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: toastBackgroundColor,
          textColor: toastTextColor,
          fontSize: 16.0);
      /*scaffoldState.currentState.showSnackBar(
        SnackBar(
          content: Text("Please check your internet connectivity and try again"),
          duration: Duration(seconds: 5),
        ),
      );*/
      setState(() {
        isLoaderShowing = false;
      });
    }

    /*var connectivityResult = await (Connectivity().checkConnectivity());
    if ((connectivityResult == ConnectivityResult.mobile) || (connectivityResult == ConnectivityResult.wifi)) {
      setState(() {
        isLoaderShowing = true;
      });
      // registerWebinar(list[index].id);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      bool checkValue = preferences.getBool("check");
      print('Check value is : $checkValue');

      if (checkValue != null) {
        */ /*setState(() {
          isLoaderShowing = true;
        });*/ /*

        if (checkValue) {
          String token = preferences.getString("spToken");
          _authToken = 'Bearer $token';
          print('Auth Token from SP is : $_authToken');

          if (list[index].fee == 'FREE' || list[index].fee == '') {
            // This is the free webinar.. take register webinar API call directly..
            print('Fees for the webinar is : ${list[index].fee}');
            registerWebinar(_authToken, index, list[index].id);
          } else {
            // Check for the card is added or not.. if card is added then take register api call..
            // If the card is not added then redirect to payment link from here..
            print('Is card saved status : ${list[index].isCardSave}');
            if (list[index].isCardSave) {
              print('Is card saved status : ${list[index].isCardSave}');
              // Take API call for the Register webinar..
              // If webinar registered successfully redirect to webinar details screen..
              registerWebinar(_authToken, index, list[index].id);
            } else {
              // const url = "https://flutter.io";
              var url = list[index].paymentLink.toString();
              if (await canLaunch(url))
                await launch(url);
              else
                // can't launch url, there is some error
                throw "Could not launch $url";
            }
            print('Payment redirection link : ${list[index].paymentLink.toString()}');
          }
        } else {
          // Redirect to login POPUP
        }
      } else {
        // Redirect to login POPUP
      }
    } else {
      scaffoldState.currentState.showSnackBar(
        SnackBar(
          content: Text("Please check your internet connectivity and try again"),
          duration: Duration(seconds: 5),
        ),
      );
      setState(() {
        isLoaderShowing = false;
      });
    }*/
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
    /*Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                // WebinarDetails('resultText Sender', webinarId)));
                WebinarDetailsNew(strWebinarTypeIntent, webinarId)));*/
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
        // isLoaderShowing = true;
        isProgressShowing = true;
      });

      if (checkValue) {
        setState(() {
          isGuestUser = false;
        });
        String token = preferences.getString("spToken");
        _authToken = 'Bearer $token';
        print('Auth Token from SP is : $_authToken');

        this.getDataWebinarList(
            '$_authToken',
            '$start',
            '10',
            '',
            '',
            '$searchKey',
            '$strWebinarType',
            '',
            '$strFilterPrice',
            '$hot_topics_ids',
            ''
                '$qualification_ids');
        // print('init State isLive : $isLive');
        // print('init State isSelfStudy : $isSelfStudy');
      } else {
        setState(() {
          isGuestUser = true;
        });
        this.getDataWebinarList(
            '$_authToken',
            '$start',
            '10',
            '',
            '',
            '$searchKey',
            '$strWebinarType',
            '',
            '$strFilterPrice',
            '$hot_topics_ids',
            ''
                '$qualification_ids');
        // print('init State isLive : $isLive');
        // print('init State isSelfStudy : $isSelfStudy');
        print('Check value : $checkValue');
        preferences.clear();
      }
    } else {
      print('check value is null....');
      setState(() {
        isProgressShowing = true;
        isGuestUser = true;
      });
      this.getDataWebinarList(
          '$_authToken', '$start', '10', '', '', '$searchKey', '$strWebinarType', '', '$strFilterPrice', '$hot_topics_ids', '$qualification_ids');
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

          this.getDataWebinarList(
              '$_authToken', '$start', '10', '', '', '$searchKey', '$strWebinarType', '', '$strFilterPrice', '$hot_topics_ids', '$qualification_ids');
          // print('init State isLive : $isLive');
          // print('init State isSelfStudy : $isSelfStudy');
        } else {
          this.getDataWebinarList(
              '', '$start', '10', '', '', '$searchKey', '$strWebinarType', '', '$strFilterPrice', '$hot_topics_ids', '$qualification_ids');
          // print('init State isLive : $isLive');
          // print('init State isSelfStudy : $isSelfStudy');
          print('Check value : $checkValue');
          preferences.clear();
        }
      }
    } else {
      if (!isLast) {
        start = start + 10;
        this.getDataWebinarList(
            '', '$start', '10', '', '', '$searchKey', '$strWebinarType', '', '$strFilterPrice', '$hot_topics_ids', '$qualification_ids');
        // print('init State isLive : $isLive');
        // print('init State isSelfStudy : $isSelfStudy');
        print('Check value : $checkValue');
        preferences.clear();
      }
    }
  }

  void clickEventDateFilter(int index) {
    setState(() {
      strDateFilter = dateList[index].toString();
      isDateSelected = true;

      if (dateList[index].toString().toLowerCase() == 'today') {
        setState(() {
          strDateType = '1';
          isProgressShowing = true;

          list.clear();
          start = 0;

          this.getDataWebinarList('$_authToken', '0', '10', '', '', '$searchKey', '$strWebinarType', '$strDateType', '$strFilterPrice',
              '$hot_topics_ids', '$qualification_ids');
        });
      } else if (dateList[index].toString().toLowerCase() == 'tomorrow') {
        setState(() {
          strDateType = '2';
          isProgressShowing = true;

          list.clear();
          start = 0;

          this.getDataWebinarList('$_authToken', '0', '10', '', '', '$searchKey', '$strWebinarType', '$strDateType', '$strFilterPrice',
              '$hot_topics_ids', '$qualification_ids');
        });
      } else if (dateList[index].toString().toLowerCase() == 'next 7 days') {
        setState(() {
          strDateType = '3';
          isProgressShowing = true;

          list.clear();
          start = 0;

          this.getDataWebinarList('$_authToken', '0', '10', '', '', '$searchKey', '$strWebinarType', '$strDateType', '$strFilterPrice',
              '$hot_topics_ids', '$qualification_ids');
        });
      } else if (dateList[index].toString().toLowerCase() == 'next 30 days') {
        setState(() {
          strDateType = '4';
          isProgressShowing = true;

          list.clear();
          start = 0;

          this.getDataWebinarList('$_authToken', '0', '10', '', '', '$searchKey', '$strWebinarType', '$strDateType', '$strFilterPrice',
              '$hot_topics_ids', '$qualification_ids');
        });
      }
    });
  }

  void registerGuestRedirectWebinar(String _authToken, String webinarId, String scheduleId, String strWebinarTypeIntent) async {
    print('API call for register Guestuser redirection webinar webinarID : $webinarId :: scheduleID : $scheduleId');
    isLoaderShowing = true;
    // isProgressShowing = true;
    var resp = await registerWebinarAPI(_authToken, webinarId.toString(), scheduleId.toString());
    print('Response is : $resp');

    respStatus = resp['success'];
    respMessage = resp['message'];

    setState(() {
      isLoaderShowing = false;
      // isProgressShowing = false;
    });

    if (respStatus) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogRegister(
              "$respMessage",
              strWebinarTypeIntent.toLowerCase() == "live"
                  ? "Click on Join Webinar at the scheduled time"
                  : "Registered Successfully. You can read handout material provided and complete review and final quiz",
              "CONTINUE",
              () {
                Navigator.pop(context);
                Navigator.of(context)
                    .push(
                  MaterialPageRoute(
                    builder: (context) => WebinarDetailsNew(strWebinarTypeIntent, int.parse(webinarId.toString())),
                  ),
                )
                    .then((_) {
                  // Call setState() here or handle this appropriately
                  setState(() {
                    list.clear();
                  });
                  checkForSP();
                });
              },
            );
          });
      /*Fluttertoast.showToast(
          msg: respMessage,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: toastBackgroundColor,
          textColor: toastTextColor,
          fontSize: 16.0);
      */ /*scaffoldState.currentState.showSnackBar(
        SnackBar(
          content: Text(respMessage),
          duration: Duration(seconds: 2),
        ),
      );*/ /*
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context)
            .push(
          MaterialPageRoute(
            builder: (context) => WebinarDetailsNew(strWebinarTypeIntent, int.parse(webinarId.toString())),
          ),
        )
            .then((_) {
          // Call setState() here or handle this appropriately
          setState(() {
            list.clear();
          });
          checkForSP();
        });
      });*/
    } else {
      Fluttertoast.showToast(
          msg: respMessage,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: toastBackgroundColor,
          textColor: toastTextColor,
          fontSize: 16.0);
      /*scaffoldState.currentState.showSnackBar(
        SnackBar(
          content: Text(respMessage),
          duration: Duration(seconds: 5),
        ),
      );*/
    }
  }

  void registerWebinar(String _authToken_1, int index, int id) async {
    print('API call for register webinar webinarID : ${list[index].id.toString()} :: scheduleID : ${list[index].scheduleId.toString()}');
    isLoaderShowing = true;
    // isProgressShowing = true;
    var resp = await registerWebinarAPI(_authToken_1, list[index].id.toString(), list[index].scheduleId.toString());
    print('Response is : $resp');

    respStatus = resp['success'];
    respMessage = resp['message'];

    setState(() {
      isLoaderShowing = false;
      // isProgressShowing = false;
    });

    if (respStatus) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogRegister(
              "$respMessage",
              strWebinarTypeIntent.toLowerCase() == "live"
                  ? "Click on Join Webinar at the scheduled time"
                  : "Registered Successfully. You can read handout material provided and complete review and final quiz",
              "CONTINUE",
              () {
                Navigator.pop(context);
                Navigator.of(context)
                    .push(
                  MaterialPageRoute(
                    builder: (context) => WebinarDetailsNew(strWebinarTypeIntent, list[index].id),
                  ),
                )
                    .then((_) {
                  // Call setState() here or handle this appropriately
                  setState(() {
                    list.clear();
                  });
                  checkForSP();
                });
              },
            );
          });
      /*Fluttertoast.showToast(
          msg: respMessage,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: toastBackgroundColor,
          textColor: toastTextColor,
          fontSize: 16.0);
      */ /*scaffoldState.currentState.showSnackBar(
        SnackBar(
          content: Text(respMessage),
          duration: Duration(seconds: 2),
        ),
      );*/ /*

      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context)
            .push(
          MaterialPageRoute(
            builder: (context) => WebinarDetailsNew(strWebinarTypeIntent, list[index].id),
          ),
        )
            .then((_) {
          // Call setState() here or handle this appropriately
          setState(() {
            list.clear();
          });
          checkForSP();
        });
      });*/
    } else {
      Fluttertoast.showToast(
          msg: respMessage,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: toastBackgroundColor,
          textColor: toastTextColor,
          fontSize: 16.0);
      /*scaffoldState.currentState.showSnackBar(
        SnackBar(
          content: Text(respMessage),
          duration: Duration(seconds: 5),
        ),
      );*/
    }
  }

  void redirectToDetails(int index) {
    int webinarId = list[index].id;
    String strWebinarId = webinarId.toString();
    strWebinarTypeIntent = list[index].webinarType;

    /*Navigator.push(context, MaterialPageRoute(builder: (context) => WebinarDetailsNew(strWebinarTypeIntent, webinarId)));*/
    Navigator.of(context)
        .push(
      MaterialPageRoute(
        builder: (context) => WebinarDetailsNew(strWebinarTypeIntent, webinarId),
      ),
    )
        .then((_) {
      // Call setState() here or handle this appropriately
      setState(() {
        list.clear();
      });
      checkForSP();
    });
  }

  void redirectToRecentDetails(int index) {
    int webinarId = recentList[index].id;
    String strWebinarId = webinarId.toString();
    strWebinarTypeIntent = recentList[index].webinarType;

    /*Navigator.push(context, MaterialPageRoute(builder: (context) => WebinarDetailsNew(strWebinarTypeIntent, webinarId)));*/
    Navigator.of(context)
        .push(
      MaterialPageRoute(
        builder: (context) => WebinarDetailsNew(strWebinarTypeIntent, webinarId),
      ),
    )
        .then((_) {
      // Call setState() here or handle this appropriately
      setState(() {
        list.clear();
      });
      checkForSP();
    });
  }

  void logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    /*Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          // builder: (context) => IntroScreen(),
          builder: (context) => Login(false),
        ),
        (Route<dynamic> route) => false);*/
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Login(true),
      ),
    );
  }

  void loginPopup(String webinarId, String scheduleId, String strWebType, bool isWebinarFree, String webFee) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialogTwo(
            "Login?",
            "For registering this webinar you must need to login first",
            "Login",
            "Cancel",
            () {
              Navigator.pop(context);
              setState(() {
                ConstSignUp.isGuestRegisterWebinar = true;
                ConstSignUp.strWebinarId = webinarId.toString();
                ConstSignUp.strScheduleId = scheduleId.toString();
                ConstSignUp.strWebinarType = strWebType.toString();
                ConstSignUp.isFreeWebinar = isWebinarFree;
                ConstSignUp.strFee = webFee.toString();
              });
              logoutUser();
            },
            () {
              Navigator.pop(context);
            },
          );
        });
    /*showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Login?', style: new TextStyle(color: Colors.black, fontSize: 20.0)),
            content: new Text('For registering this webinar you must need to login first'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () {
                  // this line exits the app.
                  setState(() {
                    ConstSignUp.isGuestRegisterWebinar = true;
                    ConstSignUp.strWebinarId = webinarId.toString();
                    ConstSignUp.strScheduleId = scheduleId.toString();
                    ConstSignUp.strWebinarType = strWebType.toString();
                    ConstSignUp.isFreeWebinar = isWebinarFree;
                    ConstSignUp.strFee = webFee.toString();
                  });
                  logoutUser();
                },
                child: new Text('Login', style: new TextStyle(fontSize: 18.0)),
              ),
              new FlatButton(
                onPressed: () => Navigator.pop(context), // this line dismisses the dialog
                child: new Text('Cancel', style: new TextStyle(fontSize: 18.0)),
              )
            ],
          ),
        ) ??
        false;*/
  }

  void showCustomCardPopup(int index, String fee) {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation, Animation secondaryAnimation) {
          return Center(
            child: Material(
              borderRadius: BorderRadius.circular(10.0.sp),
              color: Colors.white,
              child: Container(
                width: 80.0.w,
                height: 60.0.h,
                // padding: EdgeInsets.all(10.0.sp),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 10.0.sp, left: 10.0.sp),
                        child: Text(
                          'Add new Card',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.5.sp,
                            fontFamily: 'Whitney Semi Bold',
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10.0.sp, right: 10.0.sp, top: 5.0.w),
                        child: Text(
                          'Name on Card',
                          style: kLableSignUpHintLableStyle,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10.0.sp),
                        child: TextField(
                          controller: nameController,
                          style: kLableSignUpTextStyle,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'John Smith',
                            hintStyle: kLableSignUpHintStyle,
                          ),
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10.0.sp, 0, 10.0.sp, 0),
                        child: Divider(
                          height: 5.0,
                          color: Colors.black87,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10.0.sp, right: 10.0.sp, top: 2.0.w),
                        child: Text(
                          'Credit card number',
                          style: kLableSignUpHintLableStyle,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 1.0.w, horizontal: 10.0.sp),
                        child: TextField(
                          controller: cardNumberController,
                          style: kLableSignUpTextStyle,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '5052 6525 5548 6246',
                            hintStyle: kLableSignUpHintStyle,
                          ),
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10.0.sp, 0, 10.0.sp, 0),
                        child: Divider(
                          height: 5.0,
                          color: Colors.black87,
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(left: 10.0.sp, right: 10.0.sp, top: 2.0.w),
                                  child: Text(
                                    'Month',
                                    style: kLableSignUpHintLableStyle,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 1.0.w, horizontal: 10.0.sp),
                                  child: TextField(
                                    controller: expMonthController,
                                    style: kLableSignUpTextStyle,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'MM',
                                      hintStyle: kLableSignUpHintStyle,
                                    ),
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(10.0.sp, 0, 10.0.sp, 0),
                                  child: Divider(
                                    height: 5.0,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(left: 10.0.sp, right: 10.0.sp, top: 2.0.w),
                                  child: Text(
                                    'Year',
                                    style: kLableSignUpHintLableStyle,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 1.0.w, horizontal: 10.0.sp),
                                  child: TextField(
                                    controller: expYearController,
                                    style: kLableSignUpTextStyle,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'YYYY',
                                      hintStyle: kLableSignUpHintStyle,
                                    ),
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(10.0.sp, 0, 10.0.sp, 0),
                                  child: Divider(
                                    height: 5.0,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(left: 10.0.sp, right: 10.0.sp, top: 2.0.w),
                                  child: Text(
                                    'CVV',
                                    style: kLableSignUpHintLableStyle,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 1.0.w, horizontal: 10.0.sp),
                                  child: TextField(
                                    controller: cvvController,
                                    style: kLableSignUpTextStyle,
                                    obscureText: true,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'CVV',
                                      hintStyle: kLableSignUpHintStyle,
                                    ),
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(10.0.sp, 0, 10.0.sp, 0),
                                  child: Divider(
                                    height: 5.0,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          print('Clicked on paynow Button');
                          checkForCardValidation();
                        },
                        child: Container(
                          height: 30.0.sp,
                          margin: EdgeInsets.symmetric(horizontal: 10.0.sp, vertical: 18.0.sp),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0.sp),
                            color: themeYellow,
                          ),
                          child: Center(
                            child: Text(
                              'Pay Now \$$fee',
                              style: TextStyle(
                                fontSize: 12.0.sp,
                                fontFamily: 'Whitney Semi Bold',
                                color: Colors.white,
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
          );
        });
  }

  void checkForCardValidation() {
    if (nameController.text == '' || nameController.text.length == 0) {
      Fluttertoast.showToast(
          msg: strCardNameEmpty,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: toastBackgroundColor,
          textColor: toastTextColor,
          fontSize: 16.0);
      /*scaffoldState.currentState.showSnackBar(
        SnackBar(
          content: Text(strCardNameEmpty),
          duration: Duration(seconds: 5),
        ),
      );*/
    } else if (cardNumberController.text == '' || cardNumberController.text.length == 0) {
      Fluttertoast.showToast(
          msg: strCardNumberEmpty,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: toastBackgroundColor,
          textColor: toastTextColor,
          fontSize: 16.0);
      /*scaffoldState.currentState.showSnackBar(
        SnackBar(
          content: Text(strCardNumberEmpty),
          duration: Duration(seconds: 5),
        ),
      );*/
    } else if (cardNumberController.text.length < 16) {
      Fluttertoast.showToast(
          msg: strCardNumberValid,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: toastBackgroundColor,
          textColor: toastTextColor,
          fontSize: 16.0);
      /*scaffoldState.currentState.showSnackBar(
        SnackBar(
          content: Text(strCardNumberValid),
          duration: Duration(seconds: 5),
        ),
      );*/
    } else if (expMonthController.text == '' || expMonthController.text.length == 0) {
      Fluttertoast.showToast(
          msg: strExpMonthEmpty,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: toastBackgroundColor,
          textColor: toastTextColor,
          fontSize: 16.0);
      /*scaffoldState.currentState.showSnackBar(
        SnackBar(
          content: Text(strExpMonthEmpty),
          duration: Duration(seconds: 5),
        ),
      );*/
    } else if (expMonthController.text.length > 2 || int.parse(expMonthController.text) > 12) {
      Fluttertoast.showToast(
          msg: strExpMonthValid,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: toastBackgroundColor,
          textColor: toastTextColor,
          fontSize: 16.0);
      /*scaffoldState.currentState.showSnackBar(
        SnackBar(
          content: Text(strExpMonthValid),
          duration: Duration(seconds: 5),
        ),
      );*/
    } else if (expYearController.text == '' || expYearController.text.length == 0) {
      Fluttertoast.showToast(
          msg: strExpyearEmpty,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: toastBackgroundColor,
          textColor: toastTextColor,
          fontSize: 16.0);
      /*scaffoldState.currentState.showSnackBar(
        SnackBar(
          content: Text(strExpyearEmpty),
          duration: Duration(seconds: 5),
        ),
      );*/
    } else if (expYearController.text.length > 4 || int.parse(expYearController.text) > 2050 || int.parse(expYearController.text) < 2021) {
      Fluttertoast.showToast(
          msg: strExpYearValid,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: toastBackgroundColor,
          textColor: toastTextColor,
          fontSize: 16.0);
      /*scaffoldState.currentState.showSnackBar(
        SnackBar(
          content: Text(strExpYearValid),
          duration: Duration(seconds: 5),
        ),
      );*/
    } else if (cvvController.text == '' || cvvController.text.length == 0) {
      Fluttertoast.showToast(
          msg: strCVVEmpty,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: toastBackgroundColor,
          textColor: toastTextColor,
          fontSize: 16.0);
      /*scaffoldState.currentState.showSnackBar(
        SnackBar(
          content: Text(strCVVEmpty),
          duration: Duration(seconds: 5),
        ),
      );*/
    } else if (cvvController.text.length > 3) {
      Fluttertoast.showToast(
          msg: strCVVValid,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: toastBackgroundColor,
          textColor: toastTextColor,
          fontSize: 16.0);
      /*scaffoldState.currentState.showSnackBar(
        SnackBar(
          content: Text(strCVVValid),
          duration: Duration(seconds: 5),
        ),
      );*/
    } else {
      // All validations passed..
      print('All validation passed for add card');
      // addCardAPI();
    }
  }

  void checkForInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    print('Connectivity Result is : $connectivityResult');

    if ((connectivityResult == ConnectivityResult.mobile) || (connectivityResult == ConnectivityResult.wifi)) {
      getHotTopics();
    } else {
      Fluttertoast.showToast(
          msg: "Please check your internet connectivity and try again",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: toastBackgroundColor,
          textColor: toastTextColor,
          fontSize: 16.0);
      /*scaffoldState.currentState.showSnackBar(
        SnackBar(
          content: Text("Please check your internet connectivity and try again"),
          duration: Duration(seconds: 3),
        ),
      );*/
    }
  }

  void clickEventQualifications(int index) {
    if (listQualifications[index].isSelected) {
      setState(() {
        listQualifications[index].isSelected = false;
        qualificationsId.remove(listQualifications[index].id.toString());
        print('Lenght for hotTopicsId on remove is : ${qualificationsId.length}');
        print('Hot Topics array is : ${qualificationsId}');

        if (qualificationsId.length == 0) {
          qualification_ids = '';
        } else {
          for (int i = 0; i < qualificationsId.length; i++) {
            if (i == 0) {
              qualification_ids = qualificationsId[i].toString();
            } else {
              qualification_ids = qualification_ids + ',' + qualificationsId[i].toString();
            }
          }
        }

        isProgressShowing = true;

        list.clear();
        start = 0;

        this.getDataWebinarList('$_authToken', '0', '10', '', '', '$searchKey', '$strWebinarType', '$strDateType', '$strFilterPrice',
            '$hot_topics_ids', '$qualification_ids');
      });
    } else {
      setState(() {
        listQualifications[index].isSelected = true;
        qualificationsId.add(listQualifications[index].id.toString());
        print('Lenght for hotTopicsId on Add is : ${qualificationsId.length}');
        print('Hot Topics array is : ${qualificationsId}');

        if (qualificationsId.length == 0) {
          qualification_ids = '';
        } else {
          for (int i = 0; i < qualificationsId.length; i++) {
            if (i == 0) {
              qualification_ids = qualificationsId[i].toString();
            } else {
              qualification_ids = qualification_ids + ',' + qualificationsId[i].toString();
            }
          }
        }

        isProgressShowing = true;

        list.clear();
        start = 0;

        this.getDataWebinarList('$_authToken', '0', '10', '', '', '$searchKey', '$strWebinarType', '$strDateType', '$strFilterPrice',
            '$hot_topics_ids', '$qualification_ids');
      });
    }
  }

  void clickEventHotTopics(int index) {
    if (listHotTopics[index].isSelected) {
      setState(() {
        listHotTopics[index].isSelected = false;
        hotTopicsId.remove(listHotTopics[index].id.toString());
        print('Lenght for hotTopicsId on remove is : ${hotTopicsId.length}');
        print('Hot Topics array is : ${hotTopicsId}');

        if (hotTopicsId.length == 0) {
          hot_topics_ids = '';
        } else {
          for (int i = 0; i < hotTopicsId.length; i++) {
            if (i == 0) {
              hot_topics_ids = hotTopicsId[i].toString();
            } else {
              hot_topics_ids = hot_topics_ids + ',' + hotTopicsId[i].toString();
            }
          }
        }

        isProgressShowing = true;

        list.clear();
        start = 0;

        this.getDataWebinarList('$_authToken', '0', '10', '', '', '$searchKey', '$strWebinarType', '$strDateType', '$strFilterPrice',
            '$hot_topics_ids', '$qualification_ids');
      });
    } else {
      setState(() {
        listHotTopics[index].isSelected = true;
        hotTopicsId.add(listHotTopics[index].id.toString());
        print('Lenght for hotTopicsId on Add is : ${hotTopicsId.length}');
        print('Hot Topics array is : ${hotTopicsId}');

        if (hotTopicsId.length == 0) {
          hot_topics_ids = '';
        } else {
          for (int i = 0; i < hotTopicsId.length; i++) {
            if (i == 0) {
              hot_topics_ids = hotTopicsId[i].toString();
            } else {
              hot_topics_ids = hot_topics_ids + ',' + hotTopicsId[i].toString();
            }
          }
        }

        isProgressShowing = true;

        list.clear();
        start = 0;

        this.getDataWebinarList('$_authToken', '0', '10', '', '', '$searchKey', '$strWebinarType', '$strDateType', '$strFilterPrice',
            '$hot_topics_ids', '$qualification_ids');
      });
    }
  }

  void checkForWebinarFee(int index) {
    if (list[index].fee.toLowerCase() == 'free' || list[index].fee == '') {
      setState(() {
        isFreeWebGRegist = true;
      });
    } else {
      setState(() {
        isFreeWebGRegist = false;
      });
    }
  }

  void funRedirectJoinWebinar(int index) {
    var url =
        // "https://zoom.us/w/92056600703?tk=xzhOVl9nDeacxlQXdHHZ4OpFYYp3tD6YhJtS3HqU2ks.DQIAAAAVbwBAfxZjVjZiamV0VlRwaVJTUm95cnJqNFFnAAAAAAAAAAAAAAAAAAAAAAAAAAAA&uuid=WN_C16AFWZcR3SwGA5Gbd0XSQ";
        list[index].encryptedZoomLink;
    launchURLJoinWebinar(url);
    // can't launch url, there is some error
    throw "Could not launch $url";
  }

  void launchURLJoinWebinar(String _url) async {
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
  }

  void showDialogJoinWebinar(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialog(
            "Join Webinar",
            "${list[index].zoomLinkVerificationMessage}",
            "Ok",
            () {
              Navigator.pop(context);
            },
          );
        });
    /*showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Join Webinar', style: new TextStyle(color: Colors.black, fontSize: 20.0)),
            // content: new Text('${webDetailsObj['zoom_link_verification_message']}'),
            content: new Text('${list[index].zoomLinkVerificationMessage}'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.pop(context), // this line dismisses the dialog
                child: new Text('Ok', style: new TextStyle(fontSize: 18.0)),
              )
            ],
          ),
        ) ??
        false;*/
  }

  void getEvaluationFormLinkMethod(String webinarId) async {
    setState(() {
      isLoaderShowing = true;
    });
    print('Request params are : authToken : $_authToken :: webinarId : ${webinarId.toString()}');
    var resp = await evaluationFormLink('$_authToken', webinarId.toString());
    print('Response is : $resp');

    respStatus = resp['success'];
    respMessage = resp['message'];

    setState(() {
      isLoaderShowing = false;
    });

    var evaluationLink = resp['payload']['link'].toString();
    print('Evaluation form Link from API is : $evaluationLink');
    Navigator.of(context)
        .push(
      MaterialPageRoute(
        builder: (context) => EvaluationForm(evaluationLink),
      ),
    )
        .then((_) {
      // Call setState() here or handle this appropriately
      checkForSP();
    });
  }

  void funRedirectQuizPending(int index) {
    Navigator.of(context)
        .push(
      MaterialPageRoute(
        builder: (context) => FinalQuizScreen(list[index].id),
      ),
    )
        .then((_) {
      // Call setState() here or handle this appropriately
      checkForSP();
    });
  }

  setCardColor(int index) {
    if (index > 9) {
      if (index % 10 == 0) {
        return bgColor0;
      } else if (index % 10 == 1) {
        return bgColor1;
      } else if (index % 10 == 2) {
        return bgColor2;
      } else if (index % 10 == 3) {
        return bgColor3;
      } else if (index % 10 == 4) {
        return bgColor4;
      } else if (index % 10 == 5) {
        return bgColor5;
      } else if (index % 10 == 6) {
        return bgColor6;
      } else if (index % 10 == 7) {
        return bgColor7;
      } else if (index % 10 == 8) {
        return bgColor8;
      } else if (index % 10 == 9) {
        return bgColor9;
      }
    } else {
      if (index == 0) {
        return bgColor0;
      } else if (index == 1) {
        return bgColor1;
      } else if (index == 2) {
        return bgColor2;
      } else if (index == 3) {
        return bgColor3;
      } else if (index == 4) {
        return bgColor4;
      } else if (index == 5) {
        return bgColor5;
      } else if (index == 6) {
        return bgColor6;
      } else if (index == 7) {
        return bgColor7;
      } else if (index == 8) {
        return bgColor8;
      } else if (index == 9) {
        return bgColor9;
      }
    }
    // return index % 2 == 0 ? Color(0xFFFFC803) : Color(0xFF00B1FD);
  }

  void funRedirectMyCertificate(int index) {
    if (list[index].myCertificateLinks.length > 1) {
      // There are multiple certificates..
      showCertificateList(index);
    } else {
      // So here we have only single certificate.. Now we have to check for the certificate is available or not..
      // If the certificate is available then redirect to certificate preview screen..
      // if(list[index].myCertificateLinks[0].certificateLink = "") {}
      if (list[index].myCertificateLinks[0].certificateLink == '') {
        // Entered in empty certificate link option so need to show toast message..
        Fluttertoast.showToast(
            msg: strCouldntFindCertificateLink,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: toastBackgroundColor,
            textColor: toastTextColor,
            fontSize: 16.0);
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CertificatePdfPreview('${list[index].myCertificateLinks[0].certificateLink}', '${list[index].webinarTitle}',
                '${list[index].myCertificateLinks[0].certificateType}'),
          ),
        );
      }
    }
  }

  void showCertificateList(int index) {
    setState(() {
      selectedCertificateType = '';
    });

    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return StatefulBuilder(
            builder: (BuildContext context, void Function(void Function()) setState) {
              return Container(
                height: 60.0.w,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 17.0.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: 20.0.w,
                              child: Center(
                                child: Text(
                                  'Cancel',
                                  style: kDateTestimonials,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 50.0.w,
                            child: Center(
                              child: Text(
                                'Certificates List',
                                style: kOthersTitle,
                              ),
                            ),
                          ),
                          Container(
                            width: 20.0.w,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        // itemCount: orgSizeList.length,
                        itemCount: list[index].myCertificateLinks.length,
                        itemBuilder: (context, pos) {
                          return ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: 15.0.w,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  clickEventSelectCertificate(index, pos);
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.fromLTRB(3.0.w, 3.0.w, 3.0.w, 0.0),
                                decoration: BoxDecoration(
                                  color: selectedCertificateType == list[index].myCertificateLinks[pos].certificateType ? themeYellow : testColor,
                                  // color: themeYellow,
                                  borderRadius: BorderRadius.circular(7.0),
                                  // color: Colors.teal,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 3.5.w, horizontal: 3.5.w),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          // list[index].shortTitle,
                                          // orgSizeList[index],
                                          list[index].myCertificateLinks[pos].certificateType,
                                          textAlign: TextAlign.start,
                                          style: kDataSingleSelectionBottomNav,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        });
  }

  void clickEventSelectCertificate(int index, int pos) {
    setState(() {
      selectedCertificateType = list[index].myCertificateLinks[pos].certificateType.toString();
      Navigator.pop(context);

      if (list[index].myCertificateLinks[pos].certificateLink == '') {
        Fluttertoast.showToast(
            msg: strCouldntFindCertificateLink,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: toastBackgroundColor,
            textColor: toastTextColor,
            fontSize: 16.0);
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CertificatePdfPreview(
              '${list[index].myCertificateLinks[pos].certificateLink}',
              '${list[index].webinarTitle}',
              '${list[index].myCertificateLinks[pos].certificateType}',
            ),
          ),
        );
      }
    });
  }

/*void clickEventMonth(int index) {
    setState(() {
      ConstSignUp.strSelectedMonth = ConstSignUp.monthList[index].toString();
      FocusManager.instance.primaryFocus.unfocus();
      Navigator.pop(context);
    });
  }

  void clickEventYear(int index) {
    setState(() {
      ConstSignUp.strSelectedYear = ConstSignUp.yearList[index].toString();
      FocusManager.instance.primaryFocus.unfocus();
      Navigator.pop(context);
    });
  }*/
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
