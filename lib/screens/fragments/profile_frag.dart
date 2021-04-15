import 'package:connectivity/connectivity.dart';
import 'package:cpe_flutter/screens/fragments/pagination/sample_pagination.dart';
import 'package:cpe_flutter/screens/fragments/test_class_1.dart';
import 'package:cpe_flutter/screens/intro_login_signup/login.dart';
import 'package:cpe_flutter/screens/profile/cards_frag.dart';
import 'package:cpe_flutter/screens/profile/change_password.dart';
import 'package:cpe_flutter/screens/profile/contact_us.dart';
import 'package:cpe_flutter/screens/profile/faq.dart';
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

import '../../rest_api.dart';
import '../profile/contact_us.dart';
import 'certificate_frag.dart';
import 'my_webinar_frag.dart';

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
  String strDummyUserURL = 'https://testing-website.in/images/avatar-place-holder.png';
  String strNameInitials = '';
  int strID = 0;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool isLoaderShowing = false;
  String _authToken = "";
  var resp;
  bool isGuestMode = false;

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
      key: _scaffoldKey,
      /*appBar: AppBar(
        title: Text(
          'Profile Frag Screen',
          style: kTextTitleFragc,
        ),
      ),*/
      body: new WillPopScope(
          child: SafeArea(
            child: Container(
              child: Stack(
                children: <Widget>[
                  Positioned(
                    child: SingleChildScrollView(
                      child: Column(
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
                          Stack(
                            children: <Widget>[
                              Positioned(
                                child: Visibility(
                                  visible: isLoaderShowing ? false : true,
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 0.0),
                                        child: Center(
                                          child: strProfilePic == ''
                                              ? Container(
                                                  height: 30.0.w,
                                                  width: 30.0.w,
                                                  decoration: BoxDecoration(
                                                    color: Colors.blueGrey,
                                                    borderRadius: BorderRadius.circular(25.0.w),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      '$strNameInitials',
                                                      style: TextStyle(
                                                        fontSize: 25.0.sp,
                                                        color: Colors.white,
                                                        fontFamily: 'Whitney Bold',
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : CircleAvatar(
                                                  radius: 14.0.w,
                                                  backgroundImage: NetworkImage(isGuestMode ? strDummyUserURL : strProfilePic),
                                                ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          if (resp.isNotEmpty) {
                                            var respStr = resp.toString();
                                            Navigator.of(context)
                                                .push(
                                              MaterialPageRoute(
                                                builder: (context) => UserProfile(resp['payload']['data']),
                                              ),
                                            )
                                                .then((_) {
                                              getUserData();
                                            });
                                            /*Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => UserProfile(resp['payload']['data']),
                                                // builder: (context) => UserProfile(respStr),
                                              ),
                                            );*/
                                          } else {
                                            _scaffoldKey.currentState.showSnackBar(
                                              SnackBar(
                                                content: Text("Oops we are getting issue while loading data."),
                                                duration: Duration(seconds: 5),
                                              ),
                                            );
                                          }
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Center(
                                            child: Text(
                                              isGuestMode ? 'Guest User' : '$strFName $strLName',
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
                                            // My Webinar controller..
                                            Visibility(
                                              visible: isGuestMode ? false : true,
                                              child: profilce_cell_image(
                                                image_path: 'assets/my_webinar.png',
                                                strLable: "My Webinar",
                                                onPress: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      // builder: (context) => MyCredit(),
                                                      builder: (context) => MyWebinarFrag(true),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                            // My Credit controller..
                                            Visibility(
                                              visible: isGuestMode ? false : true,
                                              child: profilce_cell_image(
                                                image_path: 'assets/certificate.png',
                                                strLable: "My Certificates",
                                                onPress: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      // builder: (context) => MyCredit(),
                                                      builder: (context) => CertificateFrag(true),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                            // My Transaction controller..
                                            Visibility(
                                              visible: isGuestMode ? false : true,
                                              child: profilce_cell_image(
                                                image_path: 'assets/receipt_icon.png',
                                                strLable: "My Receipts",
                                                onPress: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => MyTranscation(),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                            // My Transaction controller..
                                            Visibility(
                                              visible: isGuestMode ? false : true,
                                              child: profile_cell(
                                                childIcon: FontAwesomeIcons.creditCard,
                                                strLable: "Cards",
                                                onPress: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => CardFrag(),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                            Visibility(
                                              visible: isGuestMode ? false : true,
                                              child: profilce_cell_image(
                                                // childIcon: FontAwesomeIcons.creditCard,
                                                image_path: 'assets/account.png',
                                                strLable: "Profile",
                                                onPress: () {
                                                  if (resp.isNotEmpty) {
                                                    var respStr = resp.toString();
                                                    Navigator.of(context)
                                                        .push(
                                                      MaterialPageRoute(
                                                        builder: (context) => UserProfile(resp['payload']['data']),
                                                      ),
                                                    )
                                                        .then((_) {
                                                      getUserData();
                                                    });
                                                  } else {
                                                    _scaffoldKey.currentState.showSnackBar(
                                                      SnackBar(
                                                        content: Text("Oops we are getting issue while loading data."),
                                                        duration: Duration(seconds: 5),
                                                      ),
                                                    );
                                                  }
                                                },
                                              ),
                                            ),
                                            // Change password controller..
                                            Visibility(
                                              visible: isGuestMode ? false : true,
                                              child: profile_cell(
                                                childIcon: FontAwesomeIcons.lock,
                                                strLable: "Change Password",
                                                onPress: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => ChangePassword(),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                            // Notification controller..
                                            Visibility(
                                              visible: isGuestMode ? false : true,
                                              child: profile_cell(
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
                                            ),
                                            Divider(
                                              height: 1.0,
                                              color: Colors.black,
                                            ),
                                            // FAQ Controller..
                                            profile_cell(
                                              childIcon: FontAwesomeIcons.solidQuestionCircle,
                                              strLable: "FAQs",
                                              onPress: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => FAQ(),
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
                                            // Chat with US controller..
                                            Visibility(
                                              visible: false,
                                              child: profile_cell(
                                                childIcon: FontAwesomeIcons.solidComments,
                                                strLable: "Chat with us",
                                                onPress: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => TestClass1(),
                                                    ),
                                                  );
                                                },
                                              ),
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
                                            // Logout controller if in Guest mode is false..
                                            Visibility(
                                              visible: isGuestMode ? false : true,
                                              child: profile_cell(
                                                childIcon: FontAwesomeIcons.signOutAlt,
                                                strLable: "Logout",
                                                onPress: () {
                                                  showDialog(
                                                        context: context,
                                                        builder: (context) => new AlertDialog(
                                                          title: new Text('Logout?', style: new TextStyle(color: Colors.black, fontSize: 20.0)),
                                                          content: new Text('Are you sure you want to Logout?'),
                                                          actions: <Widget>[
                                                            new FlatButton(
                                                              onPressed: () {
                                                                // this line exits the app.
                                                                logoutUser();
                                                              },
                                                              child: new Text('Yes', style: new TextStyle(fontSize: 18.0)),
                                                            ),
                                                            new FlatButton(
                                                              onPressed: () => Navigator.pop(context), // this line dismisses the dialog
                                                              child: new Text('No', style: new TextStyle(fontSize: 18.0)),
                                                            )
                                                          ],
                                                        ),
                                                      ) ??
                                                      false;
                                                },
                                              ),
                                            ),
                                            // Login controller if in guest mode true..
                                            Visibility(
                                              visible: isGuestMode ? true : false,
                                              child: profile_cell(
                                                childIcon: FontAwesomeIcons.signInAlt,
                                                strLable: "Login",
                                                onPress: () {
                                                  logoutUser();
                                                  /*Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => Login(),
                                                  ),
                                                );*/
                                                },
                                              ),
                                            ),
                                            // Review US controller..
                                            profile_cell(
                                              childIcon: FontAwesomeIcons.solidStar,
                                              strLable: "Review US",
                                              onPress: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => TermsCondition(),
                                                  ),
                                                );
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
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: isLoaderShowing ? true : false,
                    child: Positioned(
                      child: Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
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
            title: new Text('Confirm Exit?', style: new TextStyle(color: Colors.black, fontSize: 20.0)),
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
        isGuestMode = false;
        setState(() {
          String token = preferences.getString("spToken");
          _authToken = 'Bearer $token';
          strEmail = preferences.getString("spEmail");
          strID = preferences.getInt("spID");
          strFName = preferences.getString("spFName");
          strLName = preferences.getString("spLName");
          strContact = preferences.getString("spContact");
          strProfilePic = preferences.getString("spProfilePic");

          strNameInitials = strFName.toString()[0] + ' ' + strLName.toString()[0];
          // String pass = sharedPreferences.getString("password");

          print('Email on home screen from SP is : $strEmail');
          print('ID on home screen from SP is : $strID');
          print('FName on home screen from SP is : $strFName');
          print('LName on home screen from SP is : $strLName');
          print('Contact on home screen from SP is : $strContact');
          print('ProfilePic on home screen from SP is : $strProfilePic');
          print('Name Initials on home screen from SP is : $strNameInitials');

          getUserDataAPI();
        });
      } else {
        setState(() {
          isGuestMode = true;
          print('Check value : $checkValue');
          preferences.clear();
        });
      }
    } else {
      print('Null value else part');
      setState(() {
        checkValue = false;
        isGuestMode = true;
      });
    }
  }

  void logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    // Navigator.pushAndRemoveUntil(context, newRoute, (route) => false)
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => Login(),
          // builder: (context) => IntroScreen(),
        ),
        (Route<dynamic> route) => false);
    // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: context) => , (route) => false);
  }

  void getUserDataAPI() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if ((connectivityResult == ConnectivityResult.mobile) || (connectivityResult == ConnectivityResult.wifi)) {
      setState(() {
        isLoaderShowing = true;
      });
      resp = await getViewProfile(_authToken);
      print(resp);
      setState(() {
        isLoaderShowing = false;
      });
    } else {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Please check your internet connectivity and try again"),
          duration: Duration(seconds: 5),
        ),
      );
      setState(() {
        isLoaderShowing = false;
      });
    }
  }
}

class profilce_cell_image extends StatelessWidget {
  profilce_cell_image({this.image_path, this.strLable, this.onPress});

  final String image_path;
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
              child: Image.asset(
                '$image_path',
                height: 18.0.sp,
                width: 18.0.sp,
                color: Colors.black,
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
