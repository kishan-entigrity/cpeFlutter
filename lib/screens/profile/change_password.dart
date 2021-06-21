import 'package:connectivity/connectivity.dart';
import 'package:cpe_flutter/components/round_icon_button.dart';
import 'package:cpe_flutter/constant.dart';
import 'package:cpe_flutter/screens/intro_login_signup/login.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../rest_api.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController emailController = TextEditingController();
  TextEditingController oldPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String _oldPass;
  String _newPass;
  String _confirmPass;
  String _authToken;

  var respStatus;
  var respMessage;

  bool obscurePass = true;
  bool obscureNewPass = true;
  bool obscureConfPass = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAnalytics().setCurrentScreen(screenName: 'Change password screen');
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              height: 70.0,
              width: double.infinity,
              color: Color(0xFFF3F5F9),
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
                        'Change Password',
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
            Container(
              height: 1.0,
              width: double.infinity,
              color: Colors.blueGrey,
            ),
            /*Container(
              height: 300.0,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25.0, 80.0, 0.0, 0.0),
                child: Text(
                  'Enter your\nregistered email',
                  style: kLabelTitleTextStyle,
                ),
              ),
            ),*/
            Container(
              // margin: EdgeInsets.symmetric(vertical: 4.0.w, horizontal: 6.0.w),
              margin: EdgeInsets.only(top: 10.0.w, bottom: 4.0.w, right: 6.0.w, left: 6.0.w),
              child: TextField(
                controller: oldPassController,
                style: kLableSignUpTextStyle,
                obscureText: obscurePass,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Old Password',
                  hintStyle: kLableSignUpHintStyle,
                  suffixIcon: IconButton(
                    // onPressed: () => _controller.clear(),
                    onPressed: () {
                      setState(() {
                        if (obscurePass) {
                          obscurePass = false;
                        } else {
                          obscurePass = true;
                        }
                      });
                    },
                    icon: Icon(
                      FontAwesomeIcons.eye,
                      size: 15.0.sp,
                      color: Color(0xFFBDBFCA),
                    ),
                  ),
                ),
                textInputAction: TextInputAction.done,
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(6.0.w, 0, 6.0.w, 0),
              child: Divider(
                height: 5.0,
                color: Colors.black87,
              ),
            ),
            /*Container(
              height: 30.0,
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(25.0, 80.0, 25.0, 0.0),
              child: TextField(
                controller: oldPassController,
                obscureText: obscurePass,
                decoration: InputDecoration(
                  hintText: 'Old Password',
                  contentPadding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 0.0),
                  border: UnderlineInputBorder(),
                  suffixIcon: IconButton(
                    // onPressed: () => _controller.clear(),
                    onPressed: () {
                      setState(() {
                        if (obscurePass) {
                          obscurePass = false;
                        } else {
                          obscurePass = true;
                        }
                      });
                    },
                    icon: Icon(
                      FontAwesomeIcons.eye,
                      size: 15.0.sp,
                      color: Color(0xFFBDBFCA),
                    ),
                  ),
                ),
                textInputAction: TextInputAction.done,
              ),
            ),*/
            Container(
              margin: EdgeInsets.symmetric(vertical: 4.0.w, horizontal: 6.0.w),
              child: TextField(
                controller: newPassController,
                style: kLableSignUpTextStyle,
                obscureText: obscureNewPass,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: kLableSignUpHintStyle,
                  hintText: 'New Password',
                  suffixIcon: IconButton(
                    // onPressed: () => _controller.clear(),
                    onPressed: () {
                      setState(() {
                        if (obscureNewPass) {
                          obscureNewPass = false;
                        } else {
                          obscureNewPass = true;
                        }
                      });
                    },
                    icon: Icon(
                      FontAwesomeIcons.eye,
                      size: 15.0.sp,
                      color: Color(0xFFBDBFCA),
                    ),
                  ),
                ),
                textInputAction: TextInputAction.done,
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(6.0.w, 0, 6.0.w, 0),
              child: Divider(
                height: 5.0,
                color: Colors.black87,
              ),
            ),
            /*Container(
              height: 30.0,
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 0.0),
              child: TextField(
                controller: newPassController,
                obscureText: obscureNewPass,
                decoration: InputDecoration(
                  hintText: 'New Password',
                  contentPadding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 0.0),
                  border: UnderlineInputBorder(),
                  suffixIcon: IconButton(
                    // onPressed: () => _controller.clear(),
                    onPressed: () {
                      setState(() {
                        if (obscureNewPass) {
                          obscureNewPass = false;
                        } else {
                          obscureNewPass = true;
                        }
                      });
                    },
                    icon: Icon(
                      FontAwesomeIcons.eye,
                      size: 15.0.sp,
                      color: Color(0xFFBDBFCA),
                    ),
                  ),
                ),
                textInputAction: TextInputAction.done,
              ),
            ),*/
            Container(
              margin: EdgeInsets.symmetric(vertical: 4.0.w, horizontal: 6.0.w),
              child: TextField(
                controller: confirmPassController,
                style: kLableSignUpTextStyle,
                obscureText: obscureConfPass,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: kLableSignUpHintStyle,
                  hintText: 'Confirm Password',
                  suffixIcon: IconButton(
                    // onPressed: () => _controller.clear(),
                    onPressed: () {
                      setState(() {
                        if (obscureConfPass) {
                          obscureConfPass = false;
                        } else {
                          obscureConfPass = true;
                        }
                      });
                    },
                    icon: Icon(
                      FontAwesomeIcons.eye,
                      size: 15.0.sp,
                      color: Color(0xFFBDBFCA),
                    ),
                  ),
                ),
                textInputAction: TextInputAction.done,
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(6.0.w, 0, 6.0.w, 0),
              child: Divider(
                height: 5.0,
                color: Colors.black87,
              ),
            ),
            /*Container(
              height: 30.0,
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 0.0),
              child: TextField(
                controller: confirmPassController,
                obscureText: obscureConfPass,
                decoration: InputDecoration(
                  hintText: 'Confirm Password',
                  contentPadding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 0.0),
                  border: UnderlineInputBorder(),
                  suffixIcon: IconButton(
                    // onPressed: () => _controller.clear(),
                    onPressed: () {
                      setState(() {
                        if (obscureConfPass) {
                          obscureConfPass = false;
                        } else {
                          obscureConfPass = true;
                        }
                      });
                    },
                    icon: Icon(
                      FontAwesomeIcons.eye,
                      size: 15.0.sp,
                      color: Color(0xFFBDBFCA),
                    ),
                  ),
                ),
                textInputAction: TextInputAction.done,
              ),
            ),*/
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
    );
  }

  void getUserData() {
    _oldPass = oldPassController.text;
    _newPass = newPassController.text;
    _confirmPass = confirmPassController.text;

    if (_oldPass.length == 0) {
      Fluttertoast.showToast(
          msg: "Please enter old password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: toastBackgroundColor,
          textColor: toastTextColor,
          fontSize: 16.0);
      /*_scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Please enter old password'),
          duration: Duration(seconds: 5),
        ),
      );*/
    } else if (_newPass.length == 0) {
      Fluttertoast.showToast(
          msg: "Please enter new password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: toastBackgroundColor,
          textColor: toastTextColor,
          fontSize: 16.0);
      /*_scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Please enter new password'),
          duration: Duration(seconds: 5),
        ),
      );*/
    } else if (_confirmPass.length == 0) {
      Fluttertoast.showToast(
          msg: "Please enter confirm password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: toastBackgroundColor,
          textColor: toastTextColor,
          fontSize: 16.0);
      /*_scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Please enter confirm password'),
          duration: Duration(seconds: 5),
        ),
      );*/
    } else if (_newPass != _confirmPass) {
      Fluttertoast.showToast(
          msg: "New password and confirm password should be same",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: toastBackgroundColor,
          textColor: toastTextColor,
          fontSize: 16.0);
      /*_scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('New password and confirm password should be same'),
          duration: Duration(seconds: 5),
        ),
      );*/
    } else {
      print('All validations fired successfully..');
      // Mow we need to take one more api call for the change password.. :-)
      takeChangePasswordAPI();
      // Navigator.pop(context);
    }
    /*else if (!EmailValidator.validate(_email)) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Please enter valid email address'),
          duration: Duration(seconds: 5),
        ),
      );
    } else {
      print('All validations fired successfully');
      // Take and API call for submitting user data..
      // Then take a pop back stack if we get successful response..
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Data sent successfully'),
          duration: Duration(seconds: 5),
        ),
      );*/
  }

  void takeChangePasswordAPI() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    print('Connectivity Result is : $connectivityResult');

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

      if ((connectivityResult == ConnectivityResult.mobile) || (connectivityResult == ConnectivityResult.wifi)) {
        var resp = await changePassword(_authToken, _oldPass, _newPass, _confirmPass);
        print('Response for change password api is : $resp');

        if (resp == 'err401') {
          print('change pass found error with 401');
          logoutUser();
        } else {
          print('change pass Everything seems to be fine');
          respStatus = resp['success'];
          respMessage = resp['message'];

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
                duration: Duration(seconds: 3),
              ),
            );*/
            // Have to redirect to main profile screen again..
            Future.delayed(const Duration(seconds: 3), () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              } else {
                SystemNavigator.pop();
              }
            });
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
                duration: Duration(seconds: 3),
              ),
            );*/
          }
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
        /*_scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text("Please check your internet connectivity and try again"),
            duration: Duration(seconds: 3),
          ),
        );*/
      }
    }
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
