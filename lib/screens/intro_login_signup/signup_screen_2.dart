import 'package:cpe_flutter/components/SpinKitSample1.dart';
import 'package:cpe_flutter/components/TopBar.dart';
import 'package:cpe_flutter/components/round_icon_button.dart';
import 'package:cpe_flutter/screens/intro_login_signup/signup_screen_3.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../constant.dart';

class SignUpScreen2 extends StatefulWidget {
  @override
  _SignUpScreen2State createState() => _SignUpScreen2State();
}

class _SignUpScreen2State extends State<SignUpScreen2> {
  final scaffoldState = GlobalKey<ScaffoldState>();

  TextEditingController companyNameController = TextEditingController();

  bool isLoaderShowing = false;

  var organizationSize = '';
  var jobTitle = '';
  var industry = '';
  var isOrganizationSizeSelected = false;
  var isJobTitleSelected = false;
  var isIndustrySelected = false;
  var isProfCredsSelected = false;
  var isAdditionalQuaSelected = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Take API calls for the JobTitle, industry, Professional creds, Additional qualifications in serial manner..
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Scaffold(
        key: scaffoldState,
        body: SafeArea(
          child: Stack(
            children: [
              Positioned(
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
                                    margin: EdgeInsets.only(
                                        left: 6.0.w, right: 6.0.w, top: 20.0.w),
                                    child: TextField(
                                      controller: companyNameController,
                                      style: kLableSignUpTextStyle,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Company name',
                                        hintStyle: kLableSignUpHintStyle,
                                      ),
                                      textInputAction: TextInputAction.next,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(
                                        6.0.w, 1.0.w, 6.0.w, 0),
                                    child: Divider(
                                      height: 5.0,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      color: Colors.white,
                                      padding: EdgeInsets.fromLTRB(
                                          6.0.w, 4.0.w, 8.5.w, 4.0.w),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            isOrganizationSizeSelected
                                                ? organizationSize
                                                : 'Organization Size',
                                            style: TextStyle(
                                              fontFamily: 'Whitney Bold',
                                              fontSize: 15.0.sp,
                                              color: isOrganizationSizeSelected
                                                  ? Colors.black
                                                  : Color(0xFFBDBFCA),
                                            ),
                                          ),
                                          Icon(FontAwesomeIcons.caretDown),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.fromLTRB(6.0.w, 0, 6.0.w, 0),
                                    child: Divider(
                                      height: 5.0,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  Container(
                                    color: Colors.white,
                                    padding: EdgeInsets.fromLTRB(
                                        6.0.w, 4.0.w, 8.5.w, 4.0.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          isJobTitleSelected
                                              ? jobTitle
                                              : 'Job Title/Designation',
                                          style: TextStyle(
                                            fontFamily: 'Whitney Bold',
                                            fontSize: 15.0.sp,
                                            color: isJobTitleSelected
                                                ? Colors.black
                                                : Color(0xFFBDBFCA),
                                          ),
                                        ),
                                        Icon(FontAwesomeIcons.caretDown),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.fromLTRB(6.0.w, 0, 6.0.w, 0),
                                    child: Divider(
                                      height: 5.0,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  Container(
                                    color: Colors.white,
                                    padding: EdgeInsets.fromLTRB(
                                        6.0.w, 4.0.w, 8.5.w, 4.0.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          isIndustrySelected
                                              ? industry
                                              : 'Industry',
                                          style: TextStyle(
                                            fontFamily: 'Whitney Bold',
                                            fontSize: 15.0.sp,
                                            color: isIndustrySelected
                                                ? Colors.black
                                                : Color(0xFFBDBFCA),
                                          ),
                                        ),
                                        Icon(FontAwesomeIcons.caretDown),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.fromLTRB(6.0.w, 0, 6.0.w, 0),
                                    child: Divider(
                                      height: 5.0,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  Container(
                                    color: Colors.white,
                                    padding: EdgeInsets.fromLTRB(
                                        6.0.w, 4.0.w, 8.5.w, 4.0.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          'Professional Credentials',
                                          style: TextStyle(
                                            fontFamily: 'Whitney Bold',
                                            fontSize: 15.0.sp,
                                            color: isProfCredsSelected
                                                ? Colors.black
                                                : Color(0xFFBDBFCA),
                                          ),
                                        ),
                                        Icon(
                                          FontAwesomeIcons.plusCircle,
                                          color: themeYellow,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.fromLTRB(6.0.w, 0, 6.0.w, 0),
                                    child: Divider(
                                      height: 5.0,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  Container(
                                    color: Colors.white,
                                    padding: EdgeInsets.fromLTRB(
                                        6.0.w, 4.0.w, 8.5.w, 4.0.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          'Professional Credentials',
                                          style: TextStyle(
                                            fontFamily: 'Whitney Bold',
                                            fontSize: 15.0.sp,
                                            color: isProfCredsSelected
                                                ? Colors.black
                                                : Color(0xFFBDBFCA),
                                          ),
                                        ),
                                        Icon(
                                          FontAwesomeIcons.plusCircle,
                                          color: themeYellow,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.fromLTRB(6.0.w, 0, 6.0.w, 0),
                                    child: Divider(
                                      height: 5.0,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0.w,
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.fromLTRB(6.0.w, 0, 6.0.w, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Text(
                                          // 'Next',
                                          'Step 2/3',
                                          // style: kButtonLabelTextStyle,
                                          style: kStepText,
                                        ),
                                        RoundIconButton(
                                          icon: FontAwesomeIcons.arrowRight,
                                          onPressed: () async {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    SignUpScreen3(),
                                              ),
                                            );
                                            // checkForValidations();
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
              Positioned(
                top: 0.0,
                right: 0.0,
                bottom: 0.0,
                left: 0.0,
                child: Visibility(
                  visible: isLoaderShowing ? true : false,
                  child: SpinKitSample1(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
