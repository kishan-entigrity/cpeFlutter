import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Container(
                height: 60.0,
                width: double.infinity,
                color: Color(0xFFF3F5F9),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 0.0,
                      bottom: 0.0,
                      left: 0.0,
                      child: Container(
                        child: GestureDetector(
                          onTap: () {
                            print('Clicked on the back icon..');
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 30.0.sp,
                            height: double.infinity,
                            color: Color(0xFFF3F5F9),
                            child: Icon(
                              FontAwesomeIcons.angleLeft,
                              size: 12.0.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0.0,
                      bottom: 0.0,
                      right: 0.0,
                      left: 0.0,
                      child: Center(
                        child: Text(
                          'Profile',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0.sp,
                            fontFamily: 'Whitney Semi Bold',
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0.0,
                      top: 0.0,
                      bottom: 0.0,
                      child: Container(
                        // color: Color(0xFFF3F5F9),
                        // width: 20.0.sp,
                        height: double.infinity,
                        padding: EdgeInsets.all(10.0),
                        child: GestureDetector(
                          onTap: () {
                            print('Clicked on the search icon..');
                          },
                          child: Container(
                            width: 30.0.sp,
                            height: double.infinity,
                            color: Color(0xFFF3F5F9),
                            child: Icon(
                              FontAwesomeIcons.pencilAlt,
                              size: 12.0.sp,
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
}
