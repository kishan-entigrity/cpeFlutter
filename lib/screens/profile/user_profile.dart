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
  String strCompany = '';

  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController extController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();

  List<int> tempInt = [1, 4, 5, 7];
  List<String> companySizeData = ['0-9', '10-15', '16-50', '51-500', '501-1000', '1000+'];
  var companySizeSelectedPos = 0;

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
      strCompany = data['company_name'];
    });
    print('Profile pic on init state is : $strProfilePic');
    print('FName on init state is : $strFName');
    print('LName on init state is : $strLName');

    fnameController.text = strFName;
    lnameController.text = strLName;
    emailController.text = strEmail;
    phoneController.text = strPhone;
    mobileController.text = strMobile;
    companyNameController.text = strCompany;
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
              Expanded(
                child: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
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
                        Container(
                          margin: EdgeInsets.only(left: 6.0.w, right: 6.0.w, top: 1.0.w, bottom: 1.0.w),
                          child: TextField(
                            enabled: isEditable,
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
                          margin: EdgeInsets.fromLTRB(6.0.w, 1.0.w, 6.0.w, 0),
                          child: Divider(
                            height: 5.0,
                            color: Colors.black87,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            print('Clicked on Company size');
                            if (isEditable) {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (builder) {
                                    return StatefulBuilder(
                                      builder: (BuildContext context, void Function(void Function()) setState) {
                                        return Container(
                                          color: Colors.white,
                                          height: 70.0.h,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              // color: Colors.grey[900],
                                              // color: Colors.transparent,
                                              color: Color(0xFF757575),
                                            ),
                                            child: Column(
                                              children: <Widget>[
                                                Container(
                                                  height: 17.0.w,
                                                  decoration: BoxDecoration(
                                                    // color: Color(0xF0F3F5F9),
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.only(
                                                      topRight: Radius.circular(30.0),
                                                      topLeft: Radius.circular(30.0),
                                                    ),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: <Widget>[
                                                      GestureDetector(
                                                        onTap: () {
                                                          Navigator.pop(context);
                                                        },
                                                        child: Container(
                                                          width: 20.0.w,
                                                          child: Center(
                                                            child: Text(
                                                              'Cancel',
                                                              style: kDateTestimonials,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 50.0.w,
                                                        child: Center(
                                                          child: Text(
                                                            'Select your Organization',
                                                            style: kOthersTitle,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 20.0.w,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  height: 0.5,
                                                  color: Colors.black45,
                                                ),
                                                Expanded(
                                                  child: ListView.builder(
                                                    itemCount: companySizeData.length,
                                                    itemBuilder: (context, index) {
                                                      return ConstrainedBox(
                                                        constraints: BoxConstraints(
                                                          minHeight: 15.0.w,
                                                        ),
                                                        child: Container(
                                                          color: Colors.white,
                                                          child: GestureDetector(
                                                            onTap: () {
                                                              print('Clicked on the search icon..');
                                                              setState(() {
                                                                companySizeSelectedPos = index;
                                                              });
                                                            },
                                                            child: Container(
                                                              margin: EdgeInsets.fromLTRB(1.5.w, 3.0.w, 3.0.w, 1.5.w),
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(7.0),
                                                                color: companySizeSelectedPos == index ? Color(0xFFFEF0D5) : Color(0xFFF3F5F9),
                                                              ),
                                                              child: Flexible(
                                                                child: Container(
                                                                  child: Padding(
                                                                    padding: EdgeInsets.symmetric(vertical: 3.5.w, horizontal: 3.5.w),
                                                                    child: Row(
                                                                      children: <Widget>[
                                                                        Expanded(
                                                                          child: Text(
                                                                            // '${respProfCreds['payload']['user_type'][index]['title']}',
                                                                            '${companySizeData[index]}',
                                                                            textAlign: TextAlign.start,
                                                                            style: kDataSingleSelectionBottomNav,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  });
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 6.0.w, right: 6.0.w, top: 1.0.w, bottom: 1.0.w),
                            child: Text(
                              'Company Size',
                              style: kLableSignUpTextStyle,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(6.0.w, 1.0.w, 6.0.w, 0),
                          child: Divider(
                            height: 5.0,
                            color: Colors.black87,
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
}
