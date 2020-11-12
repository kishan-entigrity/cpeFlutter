import 'package:cpe_flutter/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _email;
  String _password;

  String strEmail, strID, strFName, strLName, strContact, strProfilePic;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Here we take call for getting user data from SharedPrefs..
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Home Screen',
        ),
        actions: [
          IconButton(
              icon: Icon(
                FontAwesomeIcons.signOutAlt,
                color: Colors.white,
              ),
              onPressed: () {
                logoutUser();
              })
        ],
      ),
      body: SafeArea(
        child: Container(),
        /*child: Center(
          child: GestureDetector(
            child: Text(
              'Logout',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            onTap: () {
              // call Logout function here..
              print('Logout method is called..');
              logoutUser();
            },
          ),
        ),*/
      ),
    );
  }

  void logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    // Navigator.pushAndRemoveUntil(context, newRoute, (route) => false)
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => Login(),
        ),
        (Route<dynamic> route) => false);
    // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: context) => , (route) => false);
  }

  void getUserData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool checkValue = preferences.getBool("check");

    if (checkValue != null) {
      if (checkValue) {
        strEmail = preferences.getString("spEmail");
        strID = preferences.getString("spID");
        strFName = preferences.getString("spFName");
        strLName = preferences.getString("spLName");
        strContact = preferences.getString("spContact");
        strProfilePic = preferences.getString("spProfilePic");
        // String pass = sharedPreferences.getString("password");

        print('Email on home screen from SP is : $strEmail');
        print('ID on home screen from SP is : $strID');
        print('FName on home screen from SP is : $strFName');
        print('LName on home screen from SP is : $strLName');
        print('Contact on home screen from SP is : $strContact');
        print('ProfilePic on home screen from SP is : $strProfilePic');
      } else {
        print('Check value : $checkValue');
        // username.clear();
        // password.clear();
        preferences.clear();
      }
    } else {
      print('Null value else part');
      checkValue = false;
    }
  }

  /*void getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs != null) {
      _email = prefs.getString('logged_email');
      _password = prefs.getString('logged_pass');

      print('Prefs Email is : $_email');
      print('Prefs Password is : $_password');
    } else {
      print('Oops we didnt get data on shared prefs..');
    }
  }*/
}
