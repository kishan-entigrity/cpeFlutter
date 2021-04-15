import 'package:cpe_flutter/screens/fragments/certificate_frag.dart';
import 'package:cpe_flutter/screens/fragments/my_webinar_frag.dart';
import 'package:cpe_flutter/screens/fragments/profile_frag.dart';
import 'package:cpe_flutter/screens/intro_login_signup/login.dart';
import 'package:cpe_flutter/screens/intro_login_signup/signup_screen_1.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import 'fragments/home_fragment.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _email;
  String _password;

  String strEmail, strFName, strLName, strContact, strProfilePic;
  int strID;

  bool isGuestUser = false;

  int currentTab = 0;
  final List<Widget> screens = [
    // HomeSampleFrag(),
    HomeFragment(),
    MyWebinarFrag(false),
    CertificateFrag(false),
    // PremiumFrag(),
    ProfileFrag(),
  ];

  // Something that stores the stack..
  final PageStorageBucket bucket = PageStorageBucket();

  // Widget currentScreen = HomeSampleFrag();
  Widget currentScreen = HomeFragment();

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
      // backgroundColor: Colors.blueGrey,
      backgroundColor: Color(0xFFF3F5F9),
      /*appBar: AppBar(
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
      ),*/
      /*body: SafeArea(
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
                    fontSize: 17.0,
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
                  radius: 50.0,
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
                    fontSize: 24.0,
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
                  Card(
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
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                  Card(
                    margin:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
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
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                  Card(
                    margin:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
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
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                  Card(
                    margin:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
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
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    height: 1.0,
                    color: Colors.black,
                  ),
                  Card(
                    margin:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
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
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                  Card(
                    margin:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
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
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                  Card(
                    margin:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
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
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // print('clicked on LogOut button');
                      logoutUser();
                    },
                    child: Card(
                      margin:
                          EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
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
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),*/
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        // notchMargin: 10.0,
        child: Container(
          width: double.infinity,
          height: 15.5.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  setState(() {
                    // currentScreen = HomeSampleFrag();
                    currentScreen = HomeFragment();
                    currentTab = 0;
                  });
                },
                child: Expanded(
                  child: Container(
                    // width: 15.5.w,
                    height: 15.5.w,
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'assets/home.png',
                          height: 18.0.sp,
                          width: 18.0.sp,
                          color: currentTab == 0 ? Color(0xFF193F70) : Color(0xFFABAAAA),
                        ),
                        /*Icon(
                          FontAwesomeIcons.home,
                          size: 20.0,
                          color: currentTab == 0 ? Color(0xFF193F70) : Color(0xFFABAAAA),
                        ),*/
                        SizedBox(
                          height: 3.0,
                        ),
                        Text(
                          'Home',
                          style: TextStyle(
                            fontSize: 10.0.sp,
                            fontFamily: 'Whitney Medium',
                            color: currentTab == 0 ? Color(0xFF193F70) : Color(0xFFABAAAA),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isGuestUser ? redirectToLogin() : redirectToMyWebinar();
                  });
                },
                child: Expanded(
                  child: Container(
                    height: 15.5.w,
                    // width: 18.0.w,
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          isGuestUser ? 'assets/login_icon.png' : 'assets/my_webinar.png',
                          height: 18.0.sp,
                          width: 18.0.sp,
                          color: currentTab == 1 ? Color(0xFF193F70) : Color(0xFFABAAAA),
                        ),
                        /*Icon(
                          FontAwesomeIcons.desktop,
                          size: 20.0,
                          color: currentTab == 1 ? Color(0xFF193F70) : Color(0xFFABAAAA),
                        ),*/
                        SizedBox(
                          height: 3.0,
                        ),
                        Text(
                          isGuestUser ? 'Login' : 'My Webinar',
                          style: TextStyle(
                            fontSize: 10.0.sp,
                            fontFamily: 'Whitney Medium',
                            color: currentTab == 1 ? Color(0xFF193F70) : Color(0xFFABAAAA),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isGuestUser ? redirectToSignUp() : redirectToCertificate();
                  });
                },
                child: Expanded(
                  child: Container(
                    height: 15.5.w,
                    // width: 15.5.w,
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          isGuestUser ? 'assets/signup_icon.png' : 'assets/certificate.png',
                          height: 18.0.sp,
                          width: 18.0.sp,
                          color: currentTab == 2 ? Color(0xFF193F70) : Color(0xFFABAAAA),
                        ),
                        /*Icon(
                          FontAwesomeIcons.certificate,
                          size: 20.0,
                          color: currentTab == 2 ? Color(0xFF193F70) : Color(0xFFABAAAA),
                        ),*/
                        SizedBox(
                          height: 3.0,
                        ),
                        Text(
                          isGuestUser ? 'SignUp' : 'Certificate',
                          style: TextStyle(
                            fontSize: 10.0.sp,
                            fontFamily: 'Whitney Medium',
                            color: currentTab == 2 ? Color(0xFF193F70) : Color(0xFFABAAAA),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              /*GestureDetector(
                onTap: () {
                  setState(() {
                    currentScreen = PremiumFrag();
                    currentTab = 3;
                  });
                },
                child: Container(
                  height: 15.5.w,
                  width: 15.5.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets/package.png',
                        height: 18.0.sp,
                        width: 18.0.sp,
                        color: currentTab == 3 ? Color(0xFF193F70) : Color(0xFFABAAAA),
                      ),
                      */ /*Icon(
                        FontAwesomeIcons.amazon,
                        size: 20.0,
                        color: currentTab == 3 ? Color(0xFF193F70) : Color(0xFFABAAAA),
                      ),*/ /*
                      SizedBox(
                        height: 3.0,
                      ),
                      Text(
                        // 'Premium',
                        'Package',
                        style: TextStyle(
                          fontSize: 10.0.sp,
                          fontFamily: 'Whitney Medium',
                          color: currentTab == 3 ? Color(0xFF193F70) : Color(0xFFABAAAA),
                        ),
                      ),
                    ],
                  ),
                ),
              ),*/
              GestureDetector(
                onTap: () {
                  setState(() {
                    currentScreen = ProfileFrag();
                    currentTab = 3;
                  });
                },
                child: Expanded(
                  child: Container(
                    height: 15.5.w,
                    // width: 15.5.w,
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          // isGuestUser ? 'assets/menu_icon.png' : 'assets/account.png',
                          'assets/menu_icon.png',
                          height: 18.0.sp,
                          width: 18.0.sp,
                          color: currentTab == 3 ? Color(0xFF193F70) : Color(0xFFABAAAA),
                        ),
                        /*Icon(
                          FontAwesomeIcons.user,
                          size: 20.0,
                          color: currentTab == 4 ? Color(0xFF193F70) : Color(0xFFABAAAA),
                        ),*/
                        SizedBox(
                          height: 3.0,
                        ),
                        Text(
                          // isGuestUser ? 'Menu' : 'Profile',
                          'Menu',
                          style: TextStyle(
                            fontSize: 10.0.sp,
                            fontFamily: 'Whitney Medium',
                            color: currentTab == 3 ? Color(0xFF193F70) : Color(0xFFABAAAA),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
    // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: context) => , (route) => false);
  }

  void getUserData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool checkValue = preferences.getBool("check");

    print('Status for checkValue is : $checkValue');
    if (checkValue != null) {
      if (checkValue) {
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
        setState(() {
          isGuestUser = false;
        });
      } else {
        print('Check value : $checkValue');
        // username.clear();
        // password.clear();
        preferences.clear();
        setState(() {
          isGuestUser = true;
        });
      }
    } else {
      print('Null value else part');
      checkValue = false;
      setState(() {
        isGuestUser = true;
      });
    }
  }

  redirectToLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Login(true),
      ),
    );
  }

  redirectToMyWebinar() {
    currentScreen = MyWebinarFrag(false);
    currentTab = 1;
  }

  redirectToSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SignUpScreen1(),
      ),
    );
  }

  redirectToCertificate() {
    currentScreen = CertificateFrag(false);
    currentTab = 2;
  }
}
