import 'dart:ffi';

import 'package:connectivity/connectivity.dart';
import 'package:cpe_flutter/model/home_webinar_list/webinar_list.dart';
import 'package:cpe_flutter/model/topics_of_interest/topic_of_interest.dart';
import 'package:cpe_flutter/rest_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeFrag extends StatefulWidget {
  @override
  _HomeFragState createState() => _HomeFragState();
}

class _HomeFragState extends State<HomeFrag> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var _authToken = '';
  // Request params..
  var _start = '';
  var _limit = '';
  var _topic_of_interest = '';
  var _subject_area = '';
  var _webinar_key_text = '';
  var _webinar_type = '';
  var _date_filter = '';
  var _filter_price = '';

  var resp;
  var respStatus;
  var respMessage;

  var respArrayWebinar;
  // List<String> arrWebTitles = <String> resp
  List<Webinar> arrWebTitles;
  List<Topic_of_interests> _topicOfInterests;
  // List _topicOfInterests;
  List<DynamicLibrary> topics;
  // List<String> _topicsOfInterestName;
  List<int> tempInt = [1, 4, 5, 7];
  int arrCount;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getWebinarList();
    getTopicsOfInterestAPI();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              height: 60.0,
              width: double.infinity,
              child: Center(
                child: Text(
                  'Home',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontFamily: 'Whitney Semi Bold',
                  ),
                ),
              ),
            ),
            // ListView.builder(itemCount: widget.steps.length,itemBuilder: (context, position) {
            Expanded(
              child: ListView.builder(
                // itemCount: resp['payload']['webinar'],
                // itemCount: respArrayWebinar.length(),
                itemCount: arrCount,
                itemBuilder: (context, index) => Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          '${resp[index]['id']}',
                          // 'Test Title',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '${resp[index]['name']}',
                          // 'Test Speaker Name}',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                        width: double.infinity,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /*void getWebinarList() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    print('Connectivity Result is : $connectivityResult');
    print('Connectivity Result is empty');

    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool checkValue = preferences.getBool("check");
    print('Status for checkValue is : $checkValue');
    if (checkValue != null) {
      if (checkValue) {
        _authToken = preferences.getString("spToken");
        // String pass = sharedPreferences.getString("password");
        print('Auth Token from SP is : $_authToken');
      } else {
        print('Check value : $checkValue');
        // username.clear();
        // password.clear();
        preferences.clear();
      }

      if ((connectivityResult == ConnectivityResult.mobile) ||
          (connectivityResult == ConnectivityResult.wifi)) {
        */ /*var resp = await homeWebinarList(
            _authToken,
            _start,
            _limit,
            _topic_of_interest,
            _subject_area,
            _webinar_key_text,
            _webinar_type,
            _date_filter,
            _filter_price);*/ /*
        resp = await homeWebinarList(
            _authToken, '0', '10', '', '', '', 'self_study', '', '0');
        print('Response is : $resp');
        // webinar_list

        respStatus = resp['success'];
        respMessage = resp['message'];

        setState(() {
          if (respStatus) {
            print('Getting response as success : $resp');
            // respArrayWebinar = resp['payload']['webinar'];
            // arrWebTitles = resp['payload']['webinar'];
            arrWebTitles = resp['payload']['webinar']['webinar_title'];
            print('Data for arrWebTitles : $arrWebTitles');
          } else {
            _scaffoldKey.currentState.showSnackBar(
              SnackBar(
                content: Text('$respMessage'),
                duration: Duration(seconds: 5),
              ),
            );
          }
        });
      } else {
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content:
                Text("Please check your internet connectivity and try again"),
            duration: Duration(seconds: 5),
          ),
        );
      }
    }
  }*/

  void getTopicsOfInterestAPI() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    print('Connectivity Result is : $connectivityResult');

    if ((connectivityResult == ConnectivityResult.mobile) ||
        (connectivityResult == ConnectivityResult.wifi)) {
      /*resp = await homeWebinarList(
          _authToken, '0', '10', '', '', '', 'self_study', '', '0');*/

      resp = await getTopicsOfInterest();
      // print('Response is : $resp');
      // webinar_list

      respStatus = resp['success'];
      respMessage = resp['message'];

      setState(() {
        if (respStatus) {
          // List testData = resp.print('Getting response as success : $resp');

          print('Data type for RESP is : ');
          print(resp['payload']['topic_of_interests'][1]);
          print(resp['payload']['topic_of_interests'][1]['name']);
          print(resp['payload']['topic_of_interests'][1].runtimeType);
          // print(resp.runtimeType);
          setState(() {
            _topicOfInterests = resp['payload']['topic_of_interests'];
            // int size_new = _topic_of_interest.length;
            int size_new = _topicOfInterests.length;
            arrCount = resp['payload']['topic_of_interests'].length;
            print('Data Name at 0th position is : $size_new');
          });

          // String nameArr = _topic_of_interest[1]['name'];

          // topics = resp['payload']['topic_of_interests'];
          // _topicsOfInterestName = resp['payload']['topic_of_interests']['name'];
          // String payload = resp['payload'];

          // print('Payload is : $payload');

          // int arrSizeTopic = _topicOfInterests.length;
          // int arrSizeTopic = topics.length;
          int arrSizeTopic = tempInt.length;
          print('New array _topicOfInterests size is : $arrSizeTopic');
          // respArrayWebinar = resp['payload']['webinar'];
          // arrWebTitles = resp['payload']['webinar'];
          // arrWebTitles = resp['payload']['webinar']['webinar_title'];
          // print('Data for arrWebTitles : $arrWebTitles');
        } else {
          _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Text('$respMessage'),
              duration: Duration(seconds: 5),
            ),
          );
        }
      });
    } else {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content:
              Text("Please check your internet connectivity and try again"),
          duration: Duration(seconds: 5),
        ),
      );
    }
  }
}
