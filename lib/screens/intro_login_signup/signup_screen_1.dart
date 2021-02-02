import 'package:cpe_flutter/components/TopBar.dart';
import 'package:cpe_flutter/components/round_icon_button.dart';
import 'package:cpe_flutter/screens/intro_login_signup/signup_screen_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../constant.dart';

class SignUpScreen1 extends StatefulWidget {
  @override
  _SignUpScreen1State createState() => _SignUpScreen1State();
}

class _SignUpScreen1State extends State<SignUpScreen1> {
  bool obscurePass = true;
  bool obscureConfPass = true;

  bool isCountrySelected = false;
  bool isStateSelected = false;
  bool isCitySelected = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                TopBar(Colors.white, 'Sign Up'),
                Expanded(
                  child: SingleChildScrollView(
                    physics: ClampingScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: MediaQuery.of(context).size.width,
                        minHeight: MediaQuery.of(context).size.height,
                      ),
                      child: IntrinsicHeight(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Container(
                              height: 200.0,
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    25.0, 50.0, 0.0, 0.0),
                                child: Text(
                                  'Register\nYourself',
                                  style: kLabelTitleTextStyle,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 0.0, horizontal: 6.0.w),
                              child: TextField(
                                style: TextStyle(
                                  fontFamily: 'Whitney Bold',
                                  fontSize: 15.0.sp,
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'First Name',
                                  hintStyle: TextStyle(
                                    fontFamily: 'Whitney Bold',
                                    fontSize: 15.0.sp,
                                    color: Color(0xFFBDBFCA),
                                  ),
                                ),
                                textInputAction: TextInputAction.next,
                              ),
                            ),
                            Container(
                              margin:
                                  EdgeInsets.fromLTRB(6.0.w, 1.0.w, 6.0.w, 0),
                              child: Divider(
                                height: 5.0,
                                color: Colors.black87,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 1.0.w, horizontal: 6.0.w),
                              child: TextField(
                                style: TextStyle(
                                  fontFamily: 'Whitney Bold',
                                  fontSize: 15.0.sp,
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Last Name',
                                  hintStyle: TextStyle(
                                    fontFamily: 'Whitney Bold',
                                    fontSize: 15.0.sp,
                                    color: Color(0xFFBDBFCA),
                                  ),
                                ),
                                textInputAction: TextInputAction.next,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(6.0.w, 0, 6.0.w, 0),
                              child: Divider(
                                height: 5.0,
                                color: Colors.black87,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 1.0.w, horizontal: 6.0.w),
                              child: TextField(
                                style: TextStyle(
                                  fontFamily: 'Whitney Bold',
                                  fontSize: 15.0.sp,
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Email ID',
                                  hintStyle: TextStyle(
                                    fontFamily: 'Whitney Bold',
                                    fontSize: 15.0.sp,
                                    color: Color(0xFFBDBFCA),
                                  ),
                                ),
                                textInputAction: TextInputAction.next,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(6.0.w, 0, 6.0.w, 0),
                              child: Divider(
                                height: 5.0,
                                color: Colors.black87,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 1.0.w, horizontal: 6.0.w),
                              child: TextField(
                                style: TextStyle(
                                  fontFamily: 'Whitney Bold',
                                  fontSize: 15.0.sp,
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Phone Number',
                                  hintStyle: TextStyle(
                                    fontFamily: 'Whitney Bold',
                                    fontSize: 15.0.sp,
                                    color: Color(0xFFBDBFCA),
                                  ),
                                ),
                                textInputAction: TextInputAction.next,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(6.0.w, 0, 6.0.w, 0),
                              child: Divider(
                                height: 5.0,
                                color: Colors.black87,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 1.0.w, horizontal: 6.0.w),
                              child: TextField(
                                style: TextStyle(
                                  fontFamily: 'Whitney Bold',
                                  fontSize: 15.0.sp,
                                  color: Colors.black,
                                ),
                                obscureText: obscurePass,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Password',
                                  hintStyle: TextStyle(
                                    fontFamily: 'Whitney Bold',
                                    fontSize: 15.0.sp,
                                    color: Color(0xFFBDBFCA),
                                  ),
                                  suffixIcon: IconButton(
                                    // onPressed: () => _controller.clear(),
                                    onPressed: () {
                                      setState(() {
                                        if (obscurePass) {
                                          obscurePass = false;
                                        } else {
                                          obscurePass = true;
                                        }
                                      });
                                    },
                                    icon: Icon(
                                      FontAwesomeIcons.eye,
                                      size: 15.0.sp,
                                    ),
                                  ),
                                ),
                                textInputAction: TextInputAction.next,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(6.0.w, 0, 6.0.w, 0),
                              child: Divider(
                                height: 5.0,
                                color: Colors.black87,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 1.0.w, horizontal: 6.0.w),
                              child: TextField(
                                style: TextStyle(
                                  fontFamily: 'Whitney Bold',
                                  fontSize: 15.0.sp,
                                  color: Colors.black,
                                ),
                                obscureText: obscureConfPass,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Confirm Password',
                                  hintStyle: TextStyle(
                                    fontFamily: 'Whitney Bold',
                                    fontSize: 15.0.sp,
                                    color: Color(0xFFBDBFCA),
                                  ),
                                  suffixIcon: IconButton(
                                    // onPressed: () => _controller.clear(),
                                    onPressed: () {
                                      setState(() {
                                        if (obscureConfPass) {
                                          obscureConfPass = false;
                                        } else {
                                          obscureConfPass = true;
                                        }
                                      });
                                    },
                                    icon: Icon(
                                      FontAwesomeIcons.eye,
                                      size: 15.0.sp,
                                    ),
                                  ),
                                ),
                                textInputAction: TextInputAction.next,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(6.0.w, 0, 6.0.w, 0),
                              child: Divider(
                                height: 5.0,
                                color: Colors.black87,
                              ),
                            ),
                            Container(
                                padding: EdgeInsets.fromLTRB(
                                    6.0.w, 4.0.w, 8.5.w, 4.0.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      'Country',
                                      style: TextStyle(
                                        fontFamily: 'Whitney Bold',
                                        fontSize: 15.0.sp,
                                        color: isCountrySelected
                                            ? Colors.black
                                            : Color(0xFFBDBFCA),
                                      ),
                                    ),
                                    Icon(FontAwesomeIcons.caretDown),
                                  ],
                                )),
                            Container(
                              margin: EdgeInsets.fromLTRB(6.0.w, 0, 6.0.w, 0),
                              child: Divider(
                                height: 5.0,
                                color: Colors.black87,
                              ),
                            ),
                            Container(
                                padding: EdgeInsets.fromLTRB(
                                    6.0.w, 4.0.w, 8.5.w, 4.0.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      'State',
                                      style: TextStyle(
                                        fontFamily: 'Whitney Bold',
                                        fontSize: 15.0.sp,
                                        color: isStateSelected
                                            ? Colors.black
                                            : Color(0xFFBDBFCA),
                                      ),
                                    ),
                                    Icon(FontAwesomeIcons.caretDown),
                                  ],
                                )),
                            Container(
                              margin: EdgeInsets.fromLTRB(6.0.w, 0, 6.0.w, 0),
                              child: Divider(
                                height: 5.0,
                                color: Colors.black87,
                              ),
                            ),
                            Container(
                                padding: EdgeInsets.fromLTRB(
                                    6.0.w, 4.0.w, 8.5.w, 4.0.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      'City',
                                      style: TextStyle(
                                        fontFamily: 'Whitney Bold',
                                        fontSize: 15.0.sp,
                                        color: isCitySelected
                                            ? Colors.black
                                            : Color(0xFFBDBFCA),
                                      ),
                                    ),
                                    Icon(FontAwesomeIcons.caretDown),
                                  ],
                                )),
                            Container(
                              margin: EdgeInsets.fromLTRB(6.0.w, 0, 6.0.w, 0),
                              child: Divider(
                                height: 5.0,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(
                              height: 20.0.w,
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(6.0.w, 0, 6.0.w, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Next',
                                    style: kButtonLabelTextStyle,
                                  ),
                                  RoundIconButton(
                                    icon: FontAwesomeIcons.arrowRight,
                                    onPressed: () async {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SignUpScreen2(),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20.0.w,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
