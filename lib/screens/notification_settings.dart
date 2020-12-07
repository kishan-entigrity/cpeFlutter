import 'package:cpe_flutter/components/round_icon_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NotificationSettings extends StatefulWidget {
  @override
  _NotificationSettingsState createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  bool isRegister = false;
  bool isReminder = false;
  bool isPendingEvolution = false;

  // Here we didn't have any scope(controller) for the taking API call in this screen...
  // So here we have to manage these cases on back press method...

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: null, //takeAPICall(),
      child: Scaffold(
        // backgroundColor: Colors.teal,
        /*appBar: AppBar(
        title: Text('Notificatin Settings'),
      ),*/
        body: SafeArea(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 70.0,
                width: double.infinity,
                color: Color(0xFFF3F5F9),
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      child: Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            FontAwesomeIcons.angleLeft,
                          ),
                        ),
                        flex: 1,
                      ),
                      onTap: () {
                        print('Back button is pressed..');
                        Navigator.pop(context);
                      },
                    ),
                    Flexible(
                      child: Center(
                        child: Text(
                          'Notification Settings',
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
                width: double.infinity,
                height: 1.0,
                color: Colors.black,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 18.0,
                ),
                child: Text(
                  'Webinar',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontFamily: 'Whitney Semi Bold',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(18.0, 10.0, 18.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Register',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontFamily: 'Whitney Medium',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isRegister) {
                            isRegister = false;
                          } else {
                            isRegister = true;
                          }
                        });
                      },
                      child: Image.asset(
                        isRegister
                            ? 'assets/toggle_checked.png'
                            : 'assets/toggle_unchecked.png',
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Reminder',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontFamily: 'Whitney Medium',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isReminder) {
                            isReminder = false;
                          } else {
                            isReminder = true;
                          }
                        });
                      },
                      child: Image.asset(
                        isReminder
                            ? 'assets/toggle_checked.png'
                            : 'assets/toggle_unchecked.png',
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0),
                height: 0.5,
                width: double.infinity,
                color: Colors.black,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 18.0,
                ),
                child: Text(
                  'Pending Action',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontFamily: 'Whitney Semi Bold',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Pending Evolution',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontFamily: 'Whitney Medium',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isPendingEvolution) {
                            isPendingEvolution = false;
                          } else {
                            isPendingEvolution = true;
                          }
                        });
                      },
                      child: Image.asset(
                        isPendingEvolution
                            ? 'assets/toggle_checked.png'
                            : 'assets/toggle_unchecked.png',
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 120.0),
                padding: EdgeInsets.only(right: 18.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: RoundIconButton(
                    icon: FontAwesomeIcons.arrowRight,
                    onPressed: () async {
                      // getUserData();
                      takeAPICall();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  takeAPICall() {
    // First print the checkbox states here..
    print('Register state is $isRegister');
    print('Reminder state is $isReminder');
    print('Pending Evolution state is $isPendingEvolution');
  }
}
