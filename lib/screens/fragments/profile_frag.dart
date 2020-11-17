import 'package:cpe_flutter/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileFrag extends StatefulWidget {
  @override
  _ProfileFragState createState() => _ProfileFragState();
}

class _ProfileFragState extends State<ProfileFrag> {
  String strEmail, strFName, strLName, strContact, strProfilePic;
  int strID;

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
      body: SingleChildScrollView(
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
        ),
      ),
    );
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
          builder: (context) => Login(),
        ),
        (Route<dynamic> route) => false);
    // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: context) => , (route) => false);
  }
}
