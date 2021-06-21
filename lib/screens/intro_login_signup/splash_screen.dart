import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:cpe_flutter/components/custom_dialog_two.dart';
import 'package:cpe_flutter/const_signup.dart';
import 'package:cpe_flutter/constant.dart';
import 'package:cpe_flutter/screens/home_screen.dart';
import 'package:cpe_flutter/screens/intro_login_signup/intro_screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../rest_api.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String _email;

  // String _password;

  var resp;
  var respPayload;
  var respStatus;
  var respMessage;
  var current_version;
  var is_update = false;
  var is_force_update = false;
  var update_message = '';
  var is_logout = false;

  var playStoreURL = 'https://play.google.com/store/apps/details?id=com.myCPE';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAnalytics().setCurrentScreen(screenName: 'Splash Screen');
    setState(() {
      ConstSignUp.isReloadWebinar = false;
    });
    getVersion();
    // getUserData();
    /*new Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Login(),
          ),
        );
      });
    });*/
    if (Platform.isAndroid) {
      print('Device Type is Android');
    } else if (Platform.isIOS) {
      print('Device Type is iOS');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      // backgroundColor: Colors.blueGrey,
      backgroundColor: testColor,
      body: Column(
        children: <Widget>[
          /*Expanded(
            child: Image.asset('assets/logo.png'),
          ),*/
          Expanded(
            child: Center(
              child: Container(
                // height: 100.0,
                width: 50.0.w,
                // child: Image.asset('assets/logo.png'),
                // child: Image.asset('assets/logo_my_cpe.png'),
                child: Image.asset('assets/my_cpe_icon.png'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool checkValue = sharedPreferences.getBool("check");
    if (checkValue != null) {
      if (checkValue) {
        String eml = sharedPreferences.getString("username");
        // String pass = sharedPreferences.getString("password");

        print('Email on Login Screen getCredential method is : $eml');
        // print('Password on Login Screen getCredential method is : $pass');
        // new Future.delayed(const Duration(seconds: 5), () {
        new Future.delayed(const Duration(seconds: 1), () {
          setState(() {
            /*Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ),
            );*/
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ),
            );
          });
        });
      } else {
        print('Check value : $checkValue');
        // username.clear();
        // password.clear();
        sharedPreferences.clear();
        new Future.delayed(const Duration(seconds: 5), () {
          setState(() {
            Navigator.push(
              context,
              MaterialPageRoute(
                // builder: (context) => Login(),
                builder: (context) => IntroScreen(),
              ),
            );
          });
        });
      }
    } else {
      print('Null value else part');
      checkValue = false;
      new Future.delayed(const Duration(seconds: 5), () {
        setState(() {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => IntroScreen(),
            ),
          );
        });
      });
    }
    /*if (prefs != null) {
      //We found data on Shared Prefs redirect to home screen directly..
      _email = prefs.getString('logged_email');
      _password = prefs.getString('logged_pass');

      print('1 email is : $_email');
      print('1 pass is : $_password');

      // if (_email == '' && _password == '') {
      // if (_email.isEmpty?? true || _password.isEmpty) {

      if (_email?.isEmpty ?? true) {
        bool testBoolEmail = _email.isEmpty;
        print('Email is Empty is called : $testBoolEmail');
      }
    } else {
      print('Oops we didnt get data on shared prefs');
    }*/
  }

  void getVersion() async {
    if (Platform.isAndroid) {
      print('Device Type is Android');
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String versionName = packageInfo.version;
      String versionCode = packageInfo.buildNumber;
      print('Version name : $versionName');
      print('version code : $versionCode');

      getVersionCheckAPI(versionName, versionCode, 'A');
    } else if (Platform.isIOS) {
      print('Device Type is iOS');
      getUserData();
    }
  }

  void getVersionCheckAPI(String versionName, String versionCode, String device_type) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if ((connectivityResult == ConnectivityResult.mobile) || (connectivityResult == ConnectivityResult.wifi)) {
      resp = await versionCheck(versionName, device_type);
      // resp = await versionCheck('1.2', device_type);
      if (resp['success']) {
        respPayload = resp['payload']['data'];
        if (respPayload['is_update']) {
          if (respPayload['is_force_update']) {
            // This is the force update.. Need to show update message there and with update and close buttons..
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomDialogTwo(
                    "Update App",
                    "${respPayload['update_message']}",
                    "Yes",
                    "Close",
                    () {
                      if (respPayload['is_logout']) {
                        logoutUser();
                      } else {
                        redirectPlayStoreURL();
                      }
                    },
                    () {
                      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                    },
                  );
                });
            /*showDialog(
                  context: context,
                  builder: (context) => new AlertDialog(
                    title: new Text('Update App', style: new TextStyle(color: Colors.black, fontSize: 20.0)),
                    content: new Text('${respPayload['update_message']}'),
                    actions: <Widget>[
                      new FlatButton(
                        onPressed: () {
                          // this line exits the app.
                          // SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                          if (respPayload['is_logout']) {
                            logoutUser();
                          } else {
                            redirectPlayStoreURL();
                          }
                        },
                        child: new Text('Yes', style: new TextStyle(fontSize: 18.0)),
                      ),
                      new FlatButton(
                        // onPressed: () => Navigator.pop(context), // this line dismisses the dialog
                        onPressed: () => SystemChannels.platform.invokeMethod('SystemNavigator.pop'), // this line dismisses the dialog
                        child: new Text('Close', style: new TextStyle(fontSize: 18.0)),
                      )
                    ],
                  ),
                ) ??
                false;*/
          } else {
            // This is the regular update.. Need to show update message there and with yes and no buttons..
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomDialogTwo(
                    "Update App",
                    "${respPayload['update_message']}",
                    "Yes",
                    "No",
                    () {
                      if (respPayload['is_logout']) {
                        logoutUser();
                      } else {
                        redirectPlayStoreURL();
                      }
                    },
                    () {
                      getUserData();
                    },
                  );
                });
            /*showDialog(
                  context: context,
                  builder: (context) => new AlertDialog(
                    title: new Text('Update App', style: new TextStyle(color: Colors.black, fontSize: 20.0)),
                    content: new Text('${respPayload['update_message']}'),
                    actions: <Widget>[
                      new FlatButton(
                        onPressed: () {
                          // this line exits the app.
                          // SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                          if (respPayload['is_logout']) {
                            logoutUser();
                          } else {
                            redirectPlayStoreURL();
                          }
                        },
                        child: new Text('Yes', style: new TextStyle(fontSize: 18.0)),
                      ),
                      new FlatButton(
                        // onPressed: () => Navigator.pop(context), // this line dismisses the dialog
                        onPressed: () => getUserData(), // this line dismisses the dialog
                        child: new Text('No', style: new TextStyle(fontSize: 18.0)),
                      )
                    ],
                  ),
                ) ??
                false;*/
          }
        } else {
          // There is no need to update the app and proceed to further screens..
          getUserData();
        }
      } else {
        Fluttertoast.showToast(
            msg: "${resp['message']}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: toastBackgroundColor,
            textColor: toastTextColor,
            fontSize: 16.0);
        /*_scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text('${resp['message']}'),
            duration: Duration(seconds: 3),
          ),
        );*/
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

  void redirectPlayStoreURL() async {
    await canLaunch(playStoreURL) ? await launch(playStoreURL) : throw 'Could not launch $playStoreURL';
  }

  void logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    redirectPlayStoreURL();
  }
}
