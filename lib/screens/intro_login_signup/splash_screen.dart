import 'dart:io';

import 'package:cpe_flutter/screens/home_screen.dart';
import 'package:cpe_flutter/screens/intro_login_signup/intro_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String _email;
  // String _password;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getVersion();
    getUserData();
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
      backgroundColor: Colors.blueGrey,
      body: Column(
        children: <Widget>[
          /*Expanded(
            child: Image.asset('assets/logo.png'),
          ),*/
          Expanded(
            child: Center(
              child: Container(
                height: 100.0,
                width: 250.0,
                child: Image.asset('assets/logo.png'),
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
        new Future.delayed(const Duration(seconds: 5), () {
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
    } else if (Platform.isIOS) {
      print('Device Type is iOS');
    }
  }
}
