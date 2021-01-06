import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../constant.dart';
import '../webinar_details/webinar_details_new.dart';

class MyWebinarFrag extends StatefulWidget {
  @override
  _MyWebinarFragState createState() => _MyWebinarFragState();
}

class _MyWebinarFragState extends State<MyWebinarFrag> {
  List<int> tempInt = [1, 4, 5, 7];
  int arrCount = 0;
  var data;

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

  Future<String> getDataWebinarList(
      String authToken,
      String start,
      String limit,
      String topic_of_interest,
      String subject_area,
      String webinar_key_text,
      String webinar_type,
      String date_filter,
      String filter_price) async {
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

    checkForSP();

    /*this.getDataWebinarList(
        '', '0', '10', '', '', '', '$strWebinarType', '', '$strFilterPrice');
    print('init State isLive : $isLive');
    print('init State isSelfStudy : $isSelfStudy');*/
    // this.getDataWebinarList('', '0', '10', '', '', '', 'self_study', '', '0');
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
                Container(
                  height: 70.0,
                  width: double.infinity,
                  color: Color(0xFFF3F5F9),
                  child: Center(
                    child: Text(
                      'My Webinar',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontFamily: 'Whitney Semi Bold',
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
                    padding: const EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: 10.0),
                    child: Row(
                      children: <Widget>[
                        /*selectedFilterWidget(
                      str: 'Test Filter',
                    ),*/
                        selectedFilterWidget(
                          str: 'Hot Topics',
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 4.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              border:
                                  Border.all(color: Colors.black, width: 1.0),
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
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 4.0),
                            child: Container(
                              decoration: isLive
                                  ? BoxDecoration(
                                      borderRadius: BorderRadius.circular(18.0),
                                      color: Color(0xFF607083),
                                    )
                                  : BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.0),
                                      border: Border.all(
                                          color: Colors.black, width: 1.0),
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
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 4.0),
                            child: Container(
                              decoration: isSelfStudy
                                  ? BoxDecoration(
                                      borderRadius: BorderRadius.circular(18.0),
                                      color: Color(0xFF607083),
                                    )
                                  : BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.0),
                                      border: Border.all(
                                          color: Colors.black, width: 1.0),
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
                                    color: isSelfStudy
                                        ? Colors.white
                                        : Colors.black,
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
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 4.0),
                            child: Container(
                              decoration: isPremium
                                  ? BoxDecoration(
                                      borderRadius: BorderRadius.circular(18.0),
                                      color: Color(0xFF607083),
                                    )
                                  : BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.0),
                                      border: Border.all(
                                          color: Colors.black, width: 1.0),
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
                                    color:
                                        isPremium ? Colors.white : Colors.black,
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
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 4.0),
                            child: Container(
                              decoration: isFree
                                  ? BoxDecoration(
                                      borderRadius: BorderRadius.circular(18.0),
                                      color: Color(0xFF607083),
                                    )
                                  : BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.0),
                                      border: Border.all(
                                          color: Colors.black, width: 1.0),
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
                                    fontFamily: 'Whitney Medium',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 4.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              border:
                                  Border.all(color: Colors.black, width: 1.0),
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
                                  fontFamily: 'Whitney Medium',
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: selectCPDFilter(),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 4.0),
                            child: Container(
                              decoration: isCPD1
                                  ? BoxDecoration(
                                      borderRadius: BorderRadius.circular(18.0),
                                      color: Color(0xFF607083),
                                    )
                                  : BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.0),
                                      border: Border.all(
                                          color: Colors.black, width: 1.0),
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
                  child: ListView.builder(
                    itemCount: arrCount,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          print('Clicked on index pos : $index');
                        },
                        child: Container(
                          // margin: EdgeInsets.only(top: 10.0),
                          margin: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 15.0),
                          decoration: BoxDecoration(
                            // color: Color(0xFFFFC803),
                            color: index % 2 == 0
                                ? Color(0xFFFFC803)
                                : Color(0xFF00B1FD),
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.0),
                            ),
                          ),
                          height: 270.0,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(left: 15.0),
                                            height: 27.0,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              color: Colors.white,
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 0.0,
                                                      horizontal: 10.0),
                                              child: Center(
                                                child: Text(
                                                  '${data['payload']['webinar'][index]['webinar_type']}',
                                                  style:
                                                      kWebinarButtonLabelTextStyleGreen,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 27.0,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              color: Colors.white,
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 0.0,
                                                      horizontal: 10.0),
                                              child: Center(
                                                child: Text(
                                                  '${data['payload']['webinar'][index]['cpa_credit']}',
                                                  style:
                                                      kWebinarButtonLabelTextStyle,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin:
                                                EdgeInsets.only(right: 15.0),
                                            height: 27.0,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              color: Colors.white,
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 0.0,
                                                      horizontal: 10.0),
                                              child: Center(
                                                child: Text(
                                                  // '\$ ${data['payload']['webinar'][index]['fee']}',
                                                  '${checkForPrice(index)}',
                                                  style:
                                                      kWebinarButtonLabelTextStyle,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          18.0, 10.0, 30.0, 0),
                                      child: Flexible(
                                        child: Text(
                                          '${data['payload']['webinar'][index]['webinar_title']}',
                                          style: TextStyle(
                                            fontFamily: 'Whitney Bold',
                                            fontSize: 20.0,
                                            color: index % 2 == 0
                                                ? Colors.black
                                                : Colors.white,
                                          ),
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          18.0, 5.0, 30.0, 0),
                                      child: Row(
                                        children: [
                                          Flexible(
                                            child: Text(
                                              '${data['payload']['webinar'][index]['speaker_name']}',
                                              style: TextStyle(
                                                fontFamily: 'Whitney Semi Bold',
                                                fontSize: 17.0,
                                                color: index % 2 == 0
                                                    ? Colors.black
                                                    : Colors.white,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          18.0, 5.0, 30.0, 0),
                                      child: Row(
                                        children: [
                                          Text(
                                            // '${data['payload']['webinar'][index]['start_date']} - ${data['payload']['webinar'][index]['start_time']} - ${data['payload']['webinar'][index]['time_zone']}',
                                            '${displayDateCondition(index)}',
                                            style: TextStyle(
                                              fontFamily: 'Whitney Semi Bold',
                                              fontSize: 17.0,
                                              color: index % 2 == 0
                                                  ? Colors.black
                                                  : Colors.white,
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
                                    print(
                                        'Clicked on register button index is : $index');
                                    getIdWebinar(index);
                                    // 1. Take an API call for relevent action from here..
                                    // 2. Before this need to verify user is logged in or not..
                                    // 3. If not then redirect to Login screen and then back here..
                                    // 4. If user is logged in then need to check for webinar is free or not..
                                    // 5. If the webinar is free then have to check for isCardSaved or not..
                                    // 6. Take a Register API call from there onwards..
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      // color: Color(0xFFC2900D),
                                      color: Color(0x23000000),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5.0),
                                      ),
                                    ),
                                    height: 40.0,
                                    width: 170.0,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            '${data['payload']['webinar'][index]['status']}',
                                            style:
                                                kWebinarButtonLabelTextStyleWhite,
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
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Image.asset(
                                  'assets/avatar_bottom_right.png',
                                  height: 130.0,
                                  width: 130.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
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
    );
  }

  void selectLiveFilter() {
    setState(() {
      strWebinarType = "live";
      isLive = true;
      isSelfStudy = false;
      isProgressShowing = true;

      this.getDataWebinarList(
          '', '0', '10', '', '', '', '$strWebinarType', '', '$strFilterPrice');
    });
  }

  void selectSelfStudyFilter() {
    setState(() {
      strWebinarType = "self_study";
      isLive = false;
      isSelfStudy = true;
      isProgressShowing = true;

      this.getDataWebinarList(
          '', '0', '10', '', '', '', '$strWebinarType', '', '$strFilterPrice');
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
      this.getDataWebinarList(
          '', '0', '10', '', '', '', '$strWebinarType', '', '$strFilterPrice');
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
      this.getDataWebinarList(
          '', '0', '10', '', '', '', '$strWebinarType', '', '$strFilterPrice');
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
    int webinarId = data['payload']['webinar'][index]['id'];
    String strWebinarId = webinarId.toString();
    strWebinarTypeIntent = data['payload']['webinar'][index]['webinar_type'];
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
    String strFee = data['payload']['webinar'][index]['fee'];
    String finalFee = "";
    if (strFee == "FREE") {
      finalFee = 'FREE';
    } else {
      // finalFee = 'data["payload']['webinar'][index]['fee"]';
      finalFee = '\$ ${data['payload']['webinar'][index]['fee']}';
    }

    return finalFee;
  }

  displayDateCondition(int index) {
    // '${data['payload']['webinar'][index]['start_date']} - ${data['payload']['webinar'][index]['start_time']} - ${data['payload']['webinar'][index]['time_zone']}',
    String strStartDate = data['payload']['webinar'][index]['start_date'];
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
          '$day $month $year - ${data['payload']['webinar'][index]['start_time']} - ${data['payload']['webinar'][index]['time_zone']}';
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
        String token = preferences.getString("spToken");
        _authToken = 'Bearer $token';
        print('Auth Token from SP is : $_authToken');

        this.getDataWebinarList('$_authToken', '0', '10', '', '', '',
            '$strWebinarType', '', '$strFilterPrice');
        // print('init State isLive : $isLive');
        // print('init State isSelfStudy : $isSelfStudy');
      } else {
        this.getDataWebinarList('$_authToken', '0', '10', '', '', '',
            '$strWebinarType', '', '$strFilterPrice');
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
              fontFamily: 'Whitney Medium',
            ),
          ),
        ),
      ),
    );
  }
}

class SpinKitSample1 extends StatelessWidget {
  const SpinKitSample1({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpinKitCircle(
      size: 60.0,
      color: Colors.black,
    );
  }
}
