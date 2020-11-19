import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../rest_api.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWebinarList();
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
            ListView.builder(
              // itemCount: resp['payload']['webinar'],
              // itemCount: respArrayWebinar.length(),
              itemCount: 10,
              itemBuilder: (context, index) => Container(
                child: Column(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "${respArrayWebinar[index]['webinar_title']}",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "${respArrayWebinar[index]['speaker_name']}",
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
                  ],
                ),
              ),
            )
            /*itemBuilder: (context, position) {
                  return Column(
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            'Title',
                          ),
                          Text(
                            'Speaker name',
                          ),
                          SizedBox(
                            height: 10.0,
                            width: double.infinity,
                          ),
                        ],
                      ),
                    ],
                  );
                })*/
            ,
          ],
        ),
      ),
    );
  }

  void getWebinarList() async {
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
        /*var resp = await homeWebinarList(
            _authToken,
            _start,
            _limit,
            _topic_of_interest,
            _subject_area,
            _webinar_key_text,
            _webinar_type,
            _date_filter,
            _filter_price);*/
        resp = await homeWebinarList(
            _authToken, '0', '10', '', '', '', 'self_study', '', '0');
        print('Response is : $resp');

        respStatus = resp['success'];
        respMessage = resp['message'];

        setState(() {
          if (respStatus) {
            print('Getting response as success : $resp');
            respArrayWebinar = resp['payload']['webinar'];
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
}
