import 'package:cpe_flutter/screens/intro_login_signup/intro_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import 'file:///C:/Kishan/Projects/Flutter_Project/cpe_flutter/lib/screens/profile/change_password.dart';
import 'file:///C:/Kishan/Projects/Flutter_Project/cpe_flutter/lib/screens/profile/contact_us.dart';
import 'file:///C:/Kishan/Projects/Flutter_Project/cpe_flutter/lib/screens/profile/my_credit.dart';
import 'file:///C:/Kishan/Projects/Flutter_Project/cpe_flutter/lib/screens/profile/my_transaction.dart';
import 'file:///C:/Kishan/Projects/Flutter_Project/cpe_flutter/lib/screens/profile/notification_settings.dart';
import 'file:///C:/Kishan/Projects/Flutter_Project/cpe_flutter/lib/screens/profile/privacy_policy.dart';
import 'file:///C:/Kishan/Projects/Flutter_Project/cpe_flutter/lib/screens/profile/terms_condition.dart';

class ProfileFrag extends StatefulWidget {
  @override
  _ProfileFragState createState() => _ProfileFragState();
}

class _ProfileFragState extends State<ProfileFrag> {
  String strEmail = '';
  String strFName = '';
  String strLName = '';
  String strContact = '';
  String strProfilePic = '';
  int strID = 0;

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
      /*appBar: AppBar(
        title: Text(
          'Profile Frag Screen',
          style: kTextTitleFragc,
        ),
      ),*/
      body: new WillPopScope(
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,v
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: Text(
                        'Profile',
                        style: TextStyle(
                          fontSize: 13.5.sp,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                          fontFamily: 'Whitney Semi Bold',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 0.0),
                    child: Center(
                      child: CircleAvatar(
                        radius: 14.0.w,
                        backgroundImage: NetworkImage(strProfilePic),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: Text(
                        '$strFName ' '$strLName',
                        style: TextStyle(
                          fontSize: 19.0.sp,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                          fontFamily: 'Whitney Bold',
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        // Notification settings controller..
                        GestureDetector(
                          onTap: () {
                            // Navigator.push(context, MaterialPageRoute(context)=>NotificationSettings());
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NotificationSettings(),
                              ),
                            );
                          },
                          child: Card(
                            margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                            child: ListTile(
                              leading: Icon(
                                // Icons.phone,
                                FontAwesomeIcons.solidBell,
                                color: Colors.black,
                              ),
                              trailing: Icon(
                                FontAwesomeIcons.angleRight,
                                color: Colors.black,
                              ),
                              title: Text(
                                'Notification Settings',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Whitney Medium',
                                  fontSize: 15.0.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                        // My Transaction controller..
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyTranscation(),
                              ),
                            );
                          },
                          child: Card(
                            margin: EdgeInsets.symmetric(
                                vertical: 0.0, horizontal: 0.0),
                            child: ListTile(
                              leading: Icon(
                                // Icons.phone,
                                FontAwesomeIcons.creditCard,
                                color: Colors.black,
                              ),
                              trailing: Icon(
                                FontAwesomeIcons.angleRight,
                                color: Colors.black,
                              ),
                              title: Text(
                                'My Transaction',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Whitney Medium',
                                  fontSize: 15.0.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                        // My Credit controller..
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyCredit(),
                              ),
                            );
                          },
                          child: Card(
                            margin: EdgeInsets.symmetric(
                                vertical: 0.0, horizontal: 0.0),
                            child: ListTile(
                              leading: Icon(
                                // Icons.phone,
                                FontAwesomeIcons.creditCard,
                                color: Colors.black,
                              ),
                              trailing: Icon(
                                FontAwesomeIcons.angleRight,
                                color: Colors.black,
                              ),
                              title: Text(
                                'My Credit',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Whitney Medium',
                                  fontSize: 15.0.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Provacy policy controller..
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PrivacyPolicy(),
                              ),
                            );
                          },
                          child: Card(
                            margin: EdgeInsets.symmetric(
                                vertical: 0.0, horizontal: 0.0),
                            child: ListTile(
                              leading: Icon(
                                // Icons.phone,
                                FontAwesomeIcons.solidFile,
                                color: Colors.black,
                              ),
                              trailing: Icon(
                                FontAwesomeIcons.angleRight,
                                color: Colors.black,
                              ),
                              title: Text(
                                'Privacy Policy',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Whitney Medium',
                                  fontSize: 15.0.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          height: 1.0,
                          color: Colors.black,
                        ),
                        // Terms and condition controller..
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TermsCondition(),
                              ),
                            );
                          },
                          child: Card(
                            margin: EdgeInsets.symmetric(
                                vertical: 0.0, horizontal: 0.0),
                            child: ListTile(
                              leading: Icon(
                                // Icons.phone,
                                FontAwesomeIcons.solidFile,
                                color: Colors.black,
                              ),
                              trailing: Icon(
                                FontAwesomeIcons.angleRight,
                                color: Colors.black,
                              ),
                              title: Text(
                                'Terms & Condition',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Whitney Medium',
                                  fontSize: 15.0.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Contact us controller..
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ContactUs(),
                              ),
                            );
                          },
                          child: Card(
                            margin: EdgeInsets.symmetric(
                                vertical: 0.0, horizontal: 0.0),
                            child: ListTile(
                              leading: Icon(
                                // Icons.phone,
                                FontAwesomeIcons.solidEnvelope,
                                color: Colors.black,
                              ),
                              trailing: Icon(
                                FontAwesomeIcons.angleRight,
                                color: Colors.black,
                              ),
                              title: Text(
                                'Contact Us',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Whitney Medium',
                                  fontSize: 15.0.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Change password controller..
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChangePassword(),
                              ),
                            );
                          },
                          child: Card(
                            margin: EdgeInsets.symmetric(
                                vertical: 0.0, horizontal: 0.0),
                            child: ListTile(
                              leading: Icon(
                                // Icons.phone,
                                FontAwesomeIcons.lock,
                                color: Colors.black,
                              ),
                              trailing: Icon(
                                FontAwesomeIcons.angleRight,
                                color: Colors.black,
                              ),
                              title: Text(
                                'Change Password',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Whitney Medium',
                                  fontSize: 15.0.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Logout controller..
                        GestureDetector(
                          onTap: () {
                            // print('clicked on LogOut button');
                            logoutUser();
                          },
                          child: Card(
                            margin: EdgeInsets.symmetric(
                                vertical: 0.0, horizontal: 0.0),
                            child: ListTile(
                              leading: Icon(
                                // Icons.phone,
                                FontAwesomeIcons.signOutAlt,
                                color: Colors.black,
                              ),
                              trailing: Icon(
                                FontAwesomeIcons.angleRight,
                                color: Colors.black,
                              ),
                              title: Text(
                                'Logout',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Whitney Medium',
                                  fontSize: 15.0.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 60.0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          onWillPop: _onWillPop),
    );
  }

  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Confirm Exit?',
                style: new TextStyle(color: Colors.black, fontSize: 20.0)),
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
                onPressed: () =>
                    Navigator.pop(context), // this line dismisses the dialog
                child: new Text('No', style: new TextStyle(fontSize: 18.0)),
              )
            ],
          ),
        ) ??
        false;
  }

  void getUserData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool checkValue = preferences.getBool("check");

    print('Status for checkValue is : $checkValue');
    if (checkValue != null) {
      if (checkValue) {
        setState(() {
          strEmail = preferences.getString("spEmail");
          strID = preferences.getInt("spID");
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
        });
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

  void logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    // Navigator.pushAndRemoveUntil(context, newRoute, (route) => false)
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          // builder: (context) => Login(),
          builder: (context) => IntroScreen(),
        ),
        (Route<dynamic> route) => false);
    // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: context) => , (route) => false);
  }
}
