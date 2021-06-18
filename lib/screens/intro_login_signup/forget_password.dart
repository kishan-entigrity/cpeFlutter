import 'package:connectivity/connectivity.dart';
import 'package:cpe_flutter/components/round_icon_button.dart';
import 'package:cpe_flutter/constant.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../rest_api.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController emailController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String _email;

  var respStatus;
  var respMessage;

  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAnalytics().setCurrentScreen(screenName: 'Forget Password screen');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      /*appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            FontAwesomeIcons.angleLeft,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'ForgetPassword',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
            fontFamily: 'Whitney Semi Bold',
          ),
        ),
      ),*/
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 50.0,
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
                                'Forget Password',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                  fontFamily: 'Whitney Semi Bold',
                                ),
                              ),
                            ),
                            flex: 8,
                          ),
                          Flexible(
                            child: Text(''),
                            flex: 1,
                          )
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 300.0,
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(25.0, 80.0, 0.0, 0.0),
                              child: Text(
                                'Enter your\nregistered email',
                                style: kLabelTitleTextStyle,
                              ),
                            ),
                          ),
                          Container(
                            height: 30.0,
                            width: double.infinity,
                            margin: EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
                            child: TextField(
                              controller: emailController,
                              obscureText: false,
                              decoration: lTextFlieldStyleEmail,
                              textInputAction: TextInputAction.done,
                            ),
                          ),
                          Container(
                            height: 100.0,
                            width: double.infinity,
                            // color: Colors.teal,
                            margin: EdgeInsets.symmetric(vertical: 50.0, horizontal: 25.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Submit',
                                  style: kButtonLabelTextStyle,
                                ),
                                RoundIconButton(
                                  icon: FontAwesomeIcons.arrowRight,
                                  onPressed: () async {
                                    // getUserData();
                                    getUserData();
                                  },
                                ),
                                /*FloatingActionButton(
                          onPressed: null,
                          backgroundColor: Color(0xFFFBB42C),
                        ),*/
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              child: Visibility(
                visible: isLoading ? true : false,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getUserData() {
    _email = emailController.text;

    if (_email.length == 0) {
      Fluttertoast.showToast(
          msg: "Please enter email",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: toastBackgroundColor,
          textColor: toastTextColor,
          fontSize: 16.0);
      /*_scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Please enter email'),
          duration: Duration(seconds: 5),
        ),
      );*/
    } else if (!EmailValidator.validate(_email)) {
      Fluttertoast.showToast(
          msg: "Please enter valid email address",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: toastBackgroundColor,
          textColor: toastTextColor,
          fontSize: 16.0);
      /*_scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Please enter valid email address'),
          duration: Duration(seconds: 5),
        ),
      );*/
    } else {
      print('All validations fired successfully');
      // Take and API call for submitting user data..
      // Then take a pop back stack if we get successful response..

      apiCallForgetPassword(_email);

      /*Fluttertoast.showToast(
          msg: "Data sent successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: toastBackgroundColor,
          textColor: toastTextColor,
          fontSize: 16.0);
      */ /*_scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Data sent successfully'),
          duration: Duration(seconds: 5),
        ),
      );*/ /*
      Navigator.pop(context);*/
    }
  }

  void apiCallForgetPassword(String email) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    print('Connectivity Result is : $connectivityResult');
    print('Connectivity Result is empty');

    if ((connectivityResult == ConnectivityResult.mobile) || (connectivityResult == ConnectivityResult.wifi)) {
      setState(() {
        isLoading = true;
      });
      var resp = await forgetPassword(email);
      print('Response is : $resp');

      respStatus = resp['success'];
      respMessage = resp['message'];

      // Now we need to add these above data on shared prefs and then
      // we can proceed for next screen.

      setState(() {
        isLoading = false;
      });

      if (respStatus) {
        Fluttertoast.showToast(
            msg: respMessage,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: toastBackgroundColor,
            textColor: toastTextColor,
            fontSize: 16.0);
        /*_scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text('$respMessage'),
            duration: Duration(seconds: 5),
          ),
        );*/

        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(
            msg: respMessage,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: toastBackgroundColor,
            textColor: toastTextColor,
            fontSize: 16.0);
        /*_scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text('$respMessage'),
            duration: Duration(seconds: 5),
          ),
        );*/
      }
    } else {
      setState(() {
        isLoading = false;
      });

      Fluttertoast.showToast(
          msg: "Please check your internet connectivity and try again",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: toastBackgroundColor,
          textColor: toastTextColor,
          fontSize: 16.0);
      /*_scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Please check your internet connectivity and try again"),
          duration: Duration(seconds: 5),
        ),
      );*/
    }
  }
}
