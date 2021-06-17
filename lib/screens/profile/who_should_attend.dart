import 'package:cpe_flutter/screens/intro_login_signup/login.dart';
import 'package:cpe_flutter/screens/profile/pagination_notification/notification_list_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class WhoShouldAttend extends StatefulWidget {
  WhoShouldAttend(this.whoShouldAttend);

  final List<String> whoShouldAttend;

  @override
  _WhoShouldAttendState createState() => _WhoShouldAttendState(whoShouldAttend);
}

class _WhoShouldAttendState extends State<WhoShouldAttend> {
  _WhoShouldAttendState(this.whoShouldAttend);

  final List<String> whoShouldAttend;

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('Enter into myTransaction screen');
    // Get API call for my transaction..
    // checkForSP();

    /*_scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        print('Scroll Controller is called here status for isLast is : $isLast');
        if (!isLast) {
          start = start + 10;
          print('Val for Start is : $start || Status for isLast is : $isLast');
          // this.getMyTransactionList('$_authToken', '$start', '10');
        } else {
          print('val for isLast : $isLast');
        }
      }
    });*/
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
                  Flexible(
                    child: GestureDetector(
                      onTap: () {
                        print('Back button is pressed..');
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          FontAwesomeIcons.angleLeft,
                        ),
                      ),
                    ),
                    flex: 1,
                  ),
                  Flexible(
                    child: Center(
                      child: Text(
                        'Who Should Attend',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.5.sp,
                          fontFamily: 'Whitney Semi Bold',
                        ),
                      ),
                    ),
                    flex: 8,
                  ),
                  Flexible(
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
              child: ListView.builder(
                physics: AlwaysScrollableScrollPhysics(),
                controller: _scrollController,
                shrinkWrap: true,
                // itemCount: arrCount,
                itemCount: whoShouldAttend.length,
                // itemCount: strTitles.length,
                itemBuilder: (context, index) {
                  return ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: 50.0,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        print('Clicked on the webinar title : ${list[index].webinarId}');
                        // So Basically we can handle the click event for the selected tile from here..
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
                              '${whoShouldAttend[index].toString()}',
                              style: TextStyle(
                                fontSize: 15.0.sp,
                                fontFamily: 'Whitney Medium',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )),
          ],
        ),
      ),
    );
  }

  /*void checkForSP() async {
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
  }*/

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
