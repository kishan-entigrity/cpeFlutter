import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../constant.dart';

class UserProfile extends StatefulWidget {
  UserProfile(this.data);

  final data;
  var strProfilePic = "";

  @override
  _UserProfileState createState() => _UserProfileState(data);
}

class _UserProfileState extends State<UserProfile> {
  _UserProfileState(this.data);

  final data;
  final scaffoldState = GlobalKey<ScaffoldState>();

  var isEditable = false;

  String strProfilePic = '';
  String strFName = '';
  String strLName = '';
  String strEmail = '';
  String strPhone = '';
  String strExt = '';
  String strMobile = '';

  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController extController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('Resp: $data');

    setState(() {
      strProfilePic = data['profile_picture'];
      strFName = data['first_name'];
      strLName = data['last_name'];
      strEmail = data['email'];
      strPhone = data['phone'];
      strExt = data[''];
      strMobile = data['contact_no'];
    });
    print('Profile pic on init state is : $strProfilePic');
    print('FName on init state is : $strFName');
    print('LName on init state is : $strLName');

    fnameController.text = strFName;
    lnameController.text = strLName;
    emailController.text = strEmail;
    phoneController.text = strPhone;
    mobileController.text = strMobile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldState,
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
                            if (isEditable) {
                              setState(() {
                                isEditable = false;
                              });
                            } else {
                              setState(() {
                                isEditable = true;
                              });
                            }
                            print('State for isEditable is: $isEditable');
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
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 0.0),
                child: Center(
                  child: CircleAvatar(
                    radius: 14.0.w,
                    backgroundImage: NetworkImage(strProfilePic),
                  ),
                ),
              ),
              Container(
                // margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 6.0.w),
                margin: EdgeInsets.only(top: 10.0.w, right: 6.0.w, left: 6.0.w),
                child: TextField(
                  enabled: isEditable,
                  controller: fnameController,
                  style: kLableSignUpTextStyle,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'First Name',
                    hintStyle: kLableSignUpHintStyle,
                  ),
                  textInputAction: TextInputAction.next,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(6.0.w, 1.0.w, 6.0.w, 0),
                child: Divider(
                  height: 5.0,
                  color: Colors.black87,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 1.0.w, horizontal: 6.0.w),
                child: TextField(
                  enabled: isEditable,
                  controller: lnameController,
                  style: kLableSignUpTextStyle,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Last Name',
                    hintStyle: kLableSignUpHintStyle,
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
                margin: EdgeInsets.symmetric(vertical: 1.0.w, horizontal: 6.0.w),
                child: TextField(
                  enabled: isEditable,
                  controller: emailController,
                  style: kLableSignUpTextStyle,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Email ID',
                    hintStyle: kLableSignUpHintStyle,
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
                margin: EdgeInsets.symmetric(vertical: 1.0.w, horizontal: 6.0.w),
                child: TextField(
                  enabled: isEditable,
                  controller: phoneController,
                  style: kLableSignUpTextStyle,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Phone Number',
                    hintStyle: kLableSignUpHintStyle,
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
                margin: EdgeInsets.symmetric(vertical: 1.0.w, horizontal: 6.0.w),
                child: TextField(
                  enabled: isEditable,
                  controller: extController,
                  style: kLableSignUpTextStyle,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Ext',
                    hintStyle: kLableSignUpHintStyle,
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
                // margin: EdgeInsets.symmetric(vertical: 1.0.w, horizontal: 6.0.w),
                margin: EdgeInsets.fromLTRB(6.0.w, 1.0.w, 9.5.w, 1.0.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextField(
                        enabled: isEditable,
                        controller: mobileController,
                        style: kLableSignUpTextStyle,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Mobile No.',
                          hintStyle: kLableSignUpHintStyle,
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        scaffoldState.currentState.showSnackBar(
                          SnackBar(
                            content: Text(mobileInfoMsg),
                            duration: Duration(seconds: 5),
                          ),
                        );
                      },
                      child: Icon(
                        FontAwesomeIcons.infoCircle,
                        size: 15.0.sp,
                        color: Color(0xFFBDBFCA),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(6.0.w, 0, 6.0.w, 0),
                child: Divider(
                  height: 5.0,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
