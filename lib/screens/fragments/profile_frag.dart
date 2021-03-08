import 'package:cpe_flutter/screens/fragments/pagination/sample_pagination.dart';
import 'package:cpe_flutter/screens/intro_login_signup/intro_screen.dart';
import 'package:cpe_flutter/screens/profile/change_password.dart';
import 'package:cpe_flutter/screens/profile/contact_us.dart';
import 'package:cpe_flutter/screens/profile/my_credit.dart';
import 'package:cpe_flutter/screens/profile/my_transaction.dart';
import 'package:cpe_flutter/screens/profile/notification.dart';
import 'package:cpe_flutter/screens/profile/privacy_policy.dart';
import 'package:cpe_flutter/screens/profile/terms_condition.dart';
import 'package:cpe_flutter/screens/profile/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../profile/contact_us.dart';

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
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          // builder: (context) => PaginationSample(),
                          builder: (context) => SamplePagination(),
                          // builder: (context) => NewsListPage(),
                        ),
                      );
                    },
                    child: Padding(
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
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserProfile(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: Text(
                          '$strFName $strLName',
                          style: TextStyle(
                            fontSize: 19.0.sp,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                            fontFamily: 'Whitney Bold',
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0.sp),
                        topRight: Radius.circular(30.0.sp),
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        // Notification settings controller..
                        SizedBox(
                          height: 20.0.sp,
                        ),
                        // profile_cell(),
                        profile_cell(
                          childIcon: FontAwesomeIcons.solidBell,
                          strLable: "Notification",
                          onPress: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Notifications(),
                              ),
                            );
                          },
                        ),
                        // My Transaction controller..
                        profile_cell(
                          childIcon: FontAwesomeIcons.creditCard,
                          strLable: "My Transaction",
                          onPress: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyTranscation(),
                              ),
                            );
                          },
                        ),
                        // My Credit controller..
                        profile_cell(
                          childIcon: FontAwesomeIcons.creditCard,
                          strLable: "My Credit",
                          onPress: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyCredit(),
                              ),
                            );
                          },
                        ),
                        // Provacy policy controller..
                        profile_cell(
                          childIcon: FontAwesomeIcons.solidFile,
                          strLable: "Privacy Policy",
                          onPress: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PrivacyPolicy(),
                              ),
                            );
                          },
                        ),
                        Divider(
                          height: 1.0,
                          color: Colors.black,
                        ),
                        // Terms and condition controller..
                        profile_cell(
                          childIcon: FontAwesomeIcons.solidFile,
                          strLable: "Terms & Condition",
                          onPress: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TermsCondition(),
                              ),
                            );
                          },
                        ),
                        // Contact us controller..
                        profile_cell(
                          childIcon: FontAwesomeIcons.solidEnvelope,
                          strLable: "Contact Us",
                          onPress: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ContactUs(),
                              ),
                            );
                          },
                        ),
                        // Change password controller..
                        profile_cell(
                          childIcon: FontAwesomeIcons.lock,
                          strLable: "Change Password",
                          onPress: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ContactUs(),
                              ),
                            );
                          },
                        ),
                        // Logout controller..
                        profile_cell(
                          childIcon: FontAwesomeIcons.signOutAlt,
                          strLable: "Logout",
                          onPress: () {
                            logoutUser();
                          },
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
                onPressed: () => Navigator.pop(context),
                // this line dismisses the dialog
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

class profile_cell extends StatelessWidget {
  profile_cell({this.childIcon, this.strLable, this.onPress});

  final IconData childIcon;
  final String strLable;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: 40.0.sp,
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0.0,
              bottom: 0.0,
              left: 12.0.sp,
              child: Icon(
                childIcon,
                size: 14.0.sp,
              ),
            ),
            Positioned(
              top: 0.0,
              bottom: 0.0,
              left: 50.0.sp,
              child: Center(
                child: Text(
                  // 'Notification',
                  strLable,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Whitney Medium',
                    fontSize: 14.0.sp,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0.0,
              bottom: 0.0,
              right: 10.0.sp,
              child: Icon(
                FontAwesomeIcons.angleRight,
                color: Colors.black,
                size: 14.0.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
