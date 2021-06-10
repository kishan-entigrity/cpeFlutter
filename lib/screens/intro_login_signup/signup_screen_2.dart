import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:cpe_flutter/components/SpinKitSample1.dart';
import 'package:cpe_flutter/components/round_icon_button.dart';
import 'package:cpe_flutter/screens/intro_login_signup/signup_screen_3.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';

import '../../const_signup.dart';
import '../../constant.dart';
import '../../rest_api.dart';
import 'model/industries_model.dart';
import 'model/job_titles_model.dart';
import 'model/prof_creds_model.dart';

class SignUpScreen2 extends StatefulWidget {
  @override
  _SignUpScreen2State createState() => _SignUpScreen2State();
}

class _SignUpScreen2State extends State<SignUpScreen2> {
  final scaffoldState = GlobalKey<ScaffoldState>();

  TextEditingController companyNameController = TextEditingController();

  bool isLoaderShowing = false;

  var isProfCredsSelected = false;
  var isAdditionalQuaSelected = false;

  var respStatus;
  var respMessage;

  var respProfCreds;

  int arrProfCredsCount = 0;
  int selectedProfCount = 0;

  Map mapProfCreds = new Map<String, String>();

  // Map mapProfCredsN = new Map<String, bool>();
  // Map mapProfCredsN = new Map<int, bool>();
  // Map mapProfCredsN = new Map<String, bool>();
  Map mapProfCredsN = new Map<String, String>();
  Map mapProfCredsT = new Map<dynamic, bool>();
  Map mapProfCredsName = new Map<dynamic, String>();
  var mapResult = '';
  bool isProfChecked = false;

  // List<String> orgSizeList = ['0-9', '10-15', '16-50', '51-500', '501-1000', '1000+'];
  // var strOrgSize = '';
  // var isOrganizationSizeSelected = false;
  // var organizationSize = '';

  // List<Job_title> listJobTitle;
  // int arrCountJTitle = 0;
  // var data_web_jtitle;
  // var dataJTitle;
  // var jobTitle = '';
  // var isJobTitleSelected = false;

  // List<Industries_list> listIndustries;
  // int arrCountIndustries = 0;
  // var data_web_industries;
  // var dataIndustries;
  // var industry = '';
  // var isIndustrySelected = false;

  // List<User_type> listProfCreds;
  // List<String> smallTitles = [];
  // int arrCountProf = 0;
  // var data_web_prof;
  // var data_prof;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Take API calls for the JobTitle, industry, Professional creds, Additional qualifications in serial manner..
    checkForInternet();
    print('Fname from global class is : ${ConstSignUp.strFname}');

    setData();
    // getProfCredsAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Scaffold(
        key: scaffoldState,
        body: WillPopScope(
            child: SafeArea(
              child: Stack(
                children: [
                  Positioned(
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              // BackIcon(),
                              GestureDetector(
                                onTap: () {
                                  ConstSignUp.strCompanyName = companyNameController.text;
                                  Navigator.pop(context);
                                },
                                child: Flexible(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Icon(
                                      FontAwesomeIcons.angleLeft,
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 12,
                                child: Center(
                                  child: Text(
                                    'Sign Up',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.0,
                                      fontFamily: 'Whitney Semi Bold',
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 2,
                                child: Text(''),
                              ),
                            ],
                          ),
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
                                        padding: EdgeInsets.only(left: 25.0),
                                        margin: EdgeInsets.only(bottom: 25.0, top: 20.0),
                                        child: Text(
                                          'Professional Details',
                                          style: kLableSignUpNewTitle,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 6.0.w, right: 6.0.w, top: 5.0.w),
                                        child: TextField(
                                          controller: companyNameController,
                                          style: kLableSignUpTextStyle,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Company name *',
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
                                          print('Clicked on OrgSize');
                                          showModalBottomSheet(
                                              context: context,
                                              builder: (builder) {
                                                return StatefulBuilder(
                                                  builder: (BuildContext context, void Function(void Function()) setState) {
                                                    return Container(
                                                      // height: 80.0.w,
                                                      child: Column(
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: <Widget>[
                                                          Container(
                                                            height: 17.0.w,
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
                                                                      'Organization Size',
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
                                                          SingleChildScrollView(
                                                            child: Container(
                                                              margin: EdgeInsets.fromLTRB(3.0.w, 0, 3.0.w, 5.0.w),
                                                              child: Wrap(
                                                                children: List.generate(
                                                                  ConstSignUp.orgSizeList.length,
                                                                  (i) {
                                                                    return GestureDetector(
                                                                      onTap: () {
                                                                        setState(() {
                                                                          clickEventOrgSize(i);
                                                                        });
                                                                      },
                                                                      child: Container(
                                                                        margin: EdgeInsets.only(right: 8.0, bottom: 8.0),
                                                                        child: ConstrainedBox(
                                                                          constraints: BoxConstraints(
                                                                            minWidth: 25.0.sp,
                                                                          ),
                                                                          child: Container(
                                                                            padding: EdgeInsets.only(left: 8.0.sp, right: 8.0.sp, top: 5.0.sp),
                                                                            height: 25.0.sp,
                                                                            decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(30.0),
                                                                              border: Border.all(
                                                                                color: ConstSignUp.organizationSize == ConstSignUp.orgSizeList[i]
                                                                                    ? themeYellow
                                                                                    : Color(0xFFB4C2D3),
                                                                                width: 1.0,
                                                                              ),
                                                                              color: Color(0xFFFFFFFF),
                                                                              // color: listQualifications[i].isSelected ? Colors.blue : Color(0xFFFFFFFF),
                                                                            ),
                                                                            child: Text(
                                                                              '${ConstSignUp.orgSizeList[i]}',
                                                                              style: TextStyle(
                                                                                fontFamily: 'Whitney Medium',
                                                                                fontSize: 11.0.sp,
                                                                                color: Colors.black,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          /*child: ListView.builder(
                                                              itemCount: ConstSignUp.orgSizeList.length,
                                                              itemBuilder: (context, index) {
                                                                return ConstrainedBox(
                                                                  constraints: BoxConstraints(
                                                                    minHeight: 15.0.w,
                                                                  ),
                                                                  child: GestureDetector(
                                                                    onTap: () {
                                                                      setState(() {
                                                                        clickEventOrgSize(index);
                                                                      });
                                                                    },
                                                                    child: Container(
                                                                      margin: EdgeInsets.fromLTRB(3.0.w, 3.0.w, 3.0.w, 0.0),
                                                                      decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(7.0),
                                                                        color: ConstSignUp.organizationSize == ConstSignUp.orgSizeList[index]
                                                                            ? themeYellow
                                                                            : testColor,
                                                                      ),
                                                                      child: Padding(
                                                                        padding: EdgeInsets.symmetric(vertical: 3.5.w, horizontal: 3.5.w),
                                                                        child: Row(
                                                                          children: <Widget>[
                                                                            Expanded(
                                                                              child: Text(
                                                                                // list[index].shortTitle,
                                                                                ConstSignUp.orgSizeList[index],
                                                                                textAlign: TextAlign.start,
                                                                                style: kDataSingleSelectionBottomNav,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            ),*/
                                                          // ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                );
                                              });
                                        },
                                        child: Container(
                                          color: Colors.white,
                                          padding: EdgeInsets.fromLTRB(6.0.w, 4.0.w, 8.5.w, 4.0.w),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                ConstSignUp.isOrganizationSizeSelected ? ConstSignUp.organizationSize : 'Organization Size *',
                                                style: TextStyle(
                                                  fontFamily: 'Whitney Bold',
                                                  fontSize: 15.0.sp,
                                                  color: ConstSignUp.isOrganizationSizeSelected ? Colors.black : Color(0xFFBDBFCA),
                                                ),
                                              ),
                                              Icon(FontAwesomeIcons.caretDown),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.fromLTRB(6.0.w, 0, 6.0.w, 0),
                                        child: Divider(
                                          height: 5.0,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          print('Clicked on Job Titles');
                                          showModalBottomSheet(
                                              context: context,
                                              builder: (builder) {
                                                return StatefulBuilder(
                                                  builder: (BuildContext context, void Function(void Function()) setState) {
                                                    return Container(
                                                      height: 150.0.w,
                                                      child: Column(
                                                        children: <Widget>[
                                                          Container(
                                                            height: 17.0.w,
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
                                                                      'Job Title/Designation',
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
                                                          Expanded(
                                                            child: SingleChildScrollView(
                                                              child: Container(
                                                                margin: EdgeInsets.fromLTRB(3.0.w, 0, 3.0.w, 5.0.w),
                                                                child: Wrap(
                                                                  children: List.generate(
                                                                    ConstSignUp.listJobTitle.length,
                                                                    (i) {
                                                                      return GestureDetector(
                                                                        onTap: () {
                                                                          setState(() {
                                                                            clickEventJobTitle(i);
                                                                          });
                                                                        },
                                                                        child: Container(
                                                                          margin: EdgeInsets.only(right: 8.0, bottom: 8.0),
                                                                          child: ConstrainedBox(
                                                                            constraints: BoxConstraints(
                                                                              minWidth: 25.0.sp,
                                                                            ),
                                                                            child: Container(
                                                                              padding: EdgeInsets.only(left: 8.0.sp, right: 8.0.sp, top: 5.0.sp),
                                                                              height: 25.0.sp,
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(30.0),
                                                                                border: Border.all(
                                                                                  color: ConstSignUp.jobTitle == ConstSignUp.listJobTitle[i].name
                                                                                      ? themeYellow
                                                                                      : Color(0xFFB4C2D3),
                                                                                  width: 1.0,
                                                                                ),
                                                                                color: Color(0xFFFFFFFF),
                                                                                // color: listQualifications[i].isSelected ? Colors.blue : Color(0xFFFFFFFF),
                                                                              ),
                                                                              child: Text(
                                                                                '${ConstSignUp.listJobTitle[i].name.toString()}',
                                                                                style: TextStyle(
                                                                                  fontFamily: 'Whitney Medium',
                                                                                  fontSize: 11.0.sp,
                                                                                  color: Colors.black,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            /*child: ListView.builder(
                                                              itemCount: ConstSignUp.listJobTitle.length,
                                                              itemBuilder: (context, index) {
                                                                return ConstrainedBox(
                                                                  constraints: BoxConstraints(
                                                                    minHeight: 15.0.w,
                                                                  ),
                                                                  child: GestureDetector(
                                                                    onTap: () {
                                                                      setState(() {
                                                                        // checkForClickBottom(index);
                                                                        clickEventJobTitle(index);
                                                                      });
                                                                    },
                                                                    child: Container(
                                                                      margin: EdgeInsets.fromLTRB(3.0.w, 3.0.w, 3.0.w, 0.0),
                                                                      decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(7.0),
                                                                        color: ConstSignUp.jobTitle == ConstSignUp.listJobTitle[index].name
                                                                            ? themeYellow
                                                                            : testColor,
                                                                      ),
                                                                      child: Padding(
                                                                        padding: EdgeInsets.symmetric(vertical: 3.5.w, horizontal: 3.5.w),
                                                                        child: Row(
                                                                          children: <Widget>[
                                                                            Expanded(
                                                                              child: Text(
                                                                                ConstSignUp.listJobTitle[index].name,
                                                                                textAlign: TextAlign.start,
                                                                                style: kDataSingleSelectionBottomNav,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            ),*/
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                );
                                              });
                                        },
                                        child: Container(
                                          color: Colors.white,
                                          padding: EdgeInsets.fromLTRB(6.0.w, 4.0.w, 8.5.w, 4.0.w),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Expanded(
                                                child: Container(
                                                  child: Text(
                                                    ConstSignUp.isJobTitleSelected ? ConstSignUp.jobTitle : 'Job Title/Designation *',
                                                    style: TextStyle(
                                                      fontFamily: 'Whitney Bold',
                                                      fontSize: 15.0.sp,
                                                      color: ConstSignUp.isJobTitleSelected ? Colors.black : Color(0xFFBDBFCA),
                                                    ),
                                                    // maxLines: 1,
                                                    // overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ),
                                              Icon(FontAwesomeIcons.caretDown),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.fromLTRB(6.0.w, 0, 6.0.w, 0),
                                        child: Divider(
                                          height: 5.0,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          showModalBottomSheet(
                                              context: context,
                                              builder: (builder) {
                                                return StatefulBuilder(
                                                  builder: (BuildContext context, void Function(void Function()) setState) {
                                                    return Container(
                                                      height: 150.0.w,
                                                      child: Column(
                                                        children: <Widget>[
                                                          Container(
                                                            height: 17.0.w,
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
                                                                      'Industry',
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
                                                          Expanded(
                                                            child: SingleChildScrollView(
                                                              child: Container(
                                                                margin: EdgeInsets.fromLTRB(3.0.w, 0, 3.0.w, 5.0.w),
                                                                child: Wrap(
                                                                  children: List.generate(
                                                                    ConstSignUp.listIndustries.length,
                                                                    (i) {
                                                                      return GestureDetector(
                                                                        onTap: () {
                                                                          /*print('Clicked on id: ${listQualifications[i].id} & title : ${listQualifications[i].title} & short title : '
                                                                              '${listQualifications[i].shortTitle}');*/
                                                                          setState(() {
                                                                            clickEventIndustry(i);
                                                                          });
                                                                        },
                                                                        child: Container(
                                                                          margin: EdgeInsets.only(right: 8.0, bottom: 8.0),
                                                                          child: ConstrainedBox(
                                                                            constraints: BoxConstraints(
                                                                              minWidth: 25.0.sp,
                                                                            ),
                                                                            child: Container(
                                                                              padding: EdgeInsets.only(left: 8.0.sp, right: 8.0.sp, top: 5.0.sp),
                                                                              height: 25.0.sp,
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(30.0),
                                                                                border: Border.all(
                                                                                  color: ConstSignUp.listIndustries[i].name == ConstSignUp.industry
                                                                                      ? themeYellow
                                                                                      : Color(0xFFB4C2D3),
                                                                                  width: 1.0,
                                                                                ),
                                                                                color: Color(0xFFFFFFFF),
                                                                                // color: listQualifications[i].isSelected ? Colors.blue : Color(0xFFFFFFFF),
                                                                              ),
                                                                              child: Text(
                                                                                '${ConstSignUp.listIndustries[i].name.toString()}',
                                                                                style: TextStyle(
                                                                                  fontFamily: 'Whitney Medium',
                                                                                  fontSize: 11.0.sp,
                                                                                  color: Colors.black,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            /*child: ListView.builder(
                                                              itemCount: ConstSignUp.listIndustries.length,
                                                              itemBuilder: (context, index) {
                                                                return ConstrainedBox(
                                                                  constraints: BoxConstraints(
                                                                    minHeight: 15.0.w,
                                                                  ),
                                                                  child: GestureDetector(
                                                                    onTap: () {
                                                                      setState(() {
                                                                        clickEventIndustry(index);
                                                                      });
                                                                    },
                                                                    child: Container(
                                                                      margin: EdgeInsets.fromLTRB(3.0.w, 3.0.w, 3.0.w, 0.0),
                                                                      decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(7.0),
                                                                        color: ConstSignUp.listIndustries[index].name == ConstSignUp.industry
                                                                            ? themeYellow
                                                                            : testColor,
                                                                      ),
                                                                      child: Padding(
                                                                        padding: EdgeInsets.symmetric(vertical: 3.5.w, horizontal: 3.5.w),
                                                                        child: Row(
                                                                          children: <Widget>[
                                                                            Expanded(
                                                                              child: Text(
                                                                                ConstSignUp.listIndustries[index].name,
                                                                                textAlign: TextAlign.start,
                                                                                style: kDataSingleSelectionBottomNav,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            ),*/
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                );
                                              });
                                        },
                                        child: Container(
                                          color: Colors.white,
                                          padding: EdgeInsets.fromLTRB(6.0.w, 4.0.w, 8.5.w, 4.0.w),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                ConstSignUp.isIndustrySelected ? ConstSignUp.industry : 'Industry *',
                                                style: TextStyle(
                                                  fontFamily: 'Whitney Bold',
                                                  fontSize: 15.0.sp,
                                                  color: ConstSignUp.isIndustrySelected ? Colors.black : Color(0xFFBDBFCA),
                                                ),
                                              ),
                                              Icon(FontAwesomeIcons.caretDown),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.fromLTRB(6.0.w, 0, 6.0.w, 0),
                                        child: Divider(
                                          height: 5.0,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          showModalBottomSheet(
                                              context: context,
                                              builder: (builder) {
                                                return StatefulBuilder(
                                                  builder: (BuildContext context, void Function(void Function()) setState) {
                                                    return Container(
                                                      height: 150.0.w,
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: <Widget>[
                                                          Container(
                                                            height: 17.0.w,
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
                                                                      'Professional Credentials',
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
                                                          Visibility(
                                                            visible: ConstSignUp.smallTitles.length > 0 ? true : false,
                                                            child: SingleChildScrollView(
                                                              child: Container(
                                                                margin: EdgeInsets.fromLTRB(3.0.w, 0, 3.0.w, 1.5.w),
                                                                child: Wrap(
                                                                  children: List.generate(ConstSignUp.listProfCreds.length, (i) {
                                                                    return Visibility(
                                                                      visible: ConstSignUp.listProfCreds[i].isSelected ? true : false,
                                                                      child: ConstrainedBox(
                                                                        constraints: BoxConstraints(
                                                                          minWidth: 25.0.sp,
                                                                        ),
                                                                        child: Container(
                                                                          margin: EdgeInsets.only(right: 8.0, bottom: 8.0),
                                                                          padding: EdgeInsets.only(left: 8.0.sp, right: 8.0.sp),
                                                                          height: 25.0.sp,
                                                                          decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.circular(30.0),
                                                                            border: Border.all(
                                                                              color: ConstSignUp.listProfCreds[i].isSelected
                                                                                  ? themeYellow
                                                                                  : Color(0xFFB4C2D3),
                                                                              width: 1.0,
                                                                            ),
                                                                            color: Color(0xFFFFFFFF),
                                                                            // color: listQualifications[i].isSelected ? Colors.blue : Color(0xFFFFFFFF),
                                                                          ),
                                                                          child: Row(
                                                                            mainAxisSize: MainAxisSize.min,
                                                                            children: <Widget>[
                                                                              GestureDetector(
                                                                                onTap: () {
                                                                                  /*print('Clicked on UNCHECK id: ${listQualifications[i].id} & title : ${listQualifications[i].title} & '
                                                                                      'short'
                                                                                      ' title : '
                                                                                      '${listQualifications[i].shortTitle}');*/
                                                                                  setState(() {
                                                                                    checkForClickBottom(i);
                                                                                  });
                                                                                },
                                                                                child: Icon(
                                                                                  FontAwesomeIcons.times,
                                                                                  color: themeYellow,
                                                                                  size: 11.0.sp,
                                                                                ),
                                                                              ),
                                                                              SizedBox(
                                                                                width: 5.0.sp,
                                                                              ),
                                                                              Text(
                                                                                '${ConstSignUp.listProfCreds[i].shortTitle}',
                                                                                style: TextStyle(
                                                                                  fontFamily: 'Whitney Medium',
                                                                                  fontSize: 11.0.sp,
                                                                                  color: Colors.black,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Visibility(
                                                            visible: ConstSignUp.smallTitles.length > 0 ? true : false,
                                                            child: Container(
                                                              height: 1.0,
                                                              color: Colors.black,
                                                              margin: EdgeInsets.fromLTRB(3.0.w, 0, 3.0.w, 3.0.w),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: SingleChildScrollView(
                                                              child: Container(
                                                                margin: EdgeInsets.fromLTRB(3.0.w, 0, 3.0.w, 5.0.w),
                                                                child: Wrap(
                                                                  children: List.generate(
                                                                    ConstSignUp.listProfCreds.length,
                                                                    (i) {
                                                                      return GestureDetector(
                                                                        onTap: () {
                                                                          /*print('Clicked on id: ${listQualifications[i].id} & title : ${listQualifications[i].title} & short title : '
                                                                              '${listQualifications[i].shortTitle}');*/
                                                                          setState(() {
                                                                            checkForClickBottom(i);
                                                                          });
                                                                        },
                                                                        child: Visibility(
                                                                          visible: ConstSignUp.listProfCreds[i].isSelected ? false : true,
                                                                          child: Container(
                                                                            // margin: EdgeInsets.symmetric(horizontal: 4.0, vertical: 0.0),
                                                                            margin: EdgeInsets.only(right: 8.0, bottom: 8.0),
                                                                            // child: FilterChip(
                                                                            child: ConstrainedBox(
                                                                              constraints: BoxConstraints(
                                                                                minWidth: 25.0.sp,
                                                                              ),
                                                                              child: Container(
                                                                                padding: EdgeInsets.only(left: 8.0.sp, right: 8.0.sp, top: 5.0.sp),
                                                                                height: 25.0.sp,
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(30.0),
                                                                                  border: Border.all(
                                                                                    color: Color(0xFFB4C2D3),
                                                                                    width: 1.0,
                                                                                  ),
                                                                                  color: Color(0xFFFFFFFF),
                                                                                  // color: listQualifications[i].isSelected ? Colors.blue : Color(0xFFFFFFFF),
                                                                                ),
                                                                                child: Text(
                                                                                  '${ConstSignUp.listProfCreds[i].shortTitle.toString()}',
                                                                                  style: TextStyle(
                                                                                    fontFamily: 'Whitney Medium',
                                                                                    fontSize: 11.0.sp,
                                                                                    color: Colors.black,
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
                                                              ),
                                                            ),
                                                            /*child: ListView.builder(
                                                              itemCount: ConstSignUp.listProfCreds.length,
                                                              itemBuilder: (context, index) {
                                                                return ConstrainedBox(
                                                                  constraints: BoxConstraints(
                                                                    minHeight: 15.0.w,
                                                                  ),
                                                                  child: GestureDetector(
                                                                    onTap: () {
                                                                      setState(() {
                                                                        checkForClickBottom(index);
                                                                      });
                                                                    },
                                                                    child: Container(
                                                                      margin: EdgeInsets.fromLTRB(3.0.w, 3.0.w, 3.0.w, 0.0),
                                                                      decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(7.0),
                                                                        color: ConstSignUp.listProfCreds[index].isSelected ? themeYellow : testColor,
                                                                      ),
                                                                      child: Padding(
                                                                        padding: EdgeInsets.symmetric(vertical: 3.5.w, horizontal: 3.5.w),
                                                                        child: Row(
                                                                          children: <Widget>[
                                                                            Icon(
                                                                              ConstSignUp.listProfCreds[index].isSelected
                                                                                  ? FontAwesomeIcons.checkCircle
                                                                                  : FontAwesomeIcons.circle,
                                                                              size: 12.0.sp,
                                                                            ),
                                                                            SizedBox(
                                                                              width: 3.5.w,
                                                                            ),
                                                                            Expanded(
                                                                              child: Text(
                                                                                ConstSignUp.listProfCreds[index].shortTitle,
                                                                                textAlign: TextAlign.start,
                                                                                style: kDataSingleSelectionBottomNav,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            ),*/
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                );
                                              });
                                        },
                                        child: Container(
                                          color: Colors.white,
                                          padding: EdgeInsets.fromLTRB(6.0.w, 4.0.w, 8.5.w, 4.0.w),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                'Professional Credentials *',
                                                style: TextStyle(
                                                  fontFamily: 'Whitney Bold',
                                                  fontSize: 15.0.sp,
                                                  // color: isProfCredsSelected ? Colors.black : Color(0xFFBDBFCA),
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Icon(
                                                FontAwesomeIcons.plusCircle,
                                                color: themeYellow,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.fromLTRB(6.0.w, 0, 6.0.w, 0),
                                        child: Wrap(
                                          children: List.generate(
                                            ConstSignUp.smallTitles.length,
                                            (i) {
                                              return Container(
                                                // margin: EdgeInsets.symmetric(horizontal: 4.0, vertical: 0.0),
                                                margin: EdgeInsets.only(right: 8.0),
                                                child: Chip(
                                                  backgroundColor: themeYellow,
                                                  label: Container(
                                                    child: Text(
                                                      '${ConstSignUp.smallTitles[i].toString()}',
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
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
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.end,
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
                                                ConstSignUp.strCompanyName = companyNameController.text;
                                                checkForValidation();
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      /*SizedBox(
                                        height: 5.0.w,
                                      ),*/
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
            onWillPop: _onWillPop),
      ),
    );
  }

  Future<bool> _onWillPop() {
    return onBackPressEvent();
  }

  void getProfCredsAPI() async {
    isLoaderShowing = true;
    var connectivityResult = await (Connectivity().checkConnectivity());
    // print('Connectivity Result is : $connectivityResult');

    if ((connectivityResult == ConnectivityResult.mobile) || (connectivityResult == ConnectivityResult.wifi)) {
      respProfCreds = await getProfessionalCreds();
      print('Response for Country list api is : $respProfCreds');

      respStatus = respProfCreds['success'];
      respMessage = respProfCreds['message'];
      isLoaderShowing = false;
      if (respStatus) {
        // Do something to load data for country list from here..
        setState(() {
          arrProfCredsCount = respProfCreds['payload']['user_type'].length;
          print('ProfCreds Length is : $arrProfCredsCount');
          // Add data to map from the API response..
          for (int i = 0; i < arrProfCredsCount; i++) {
            int id_key = respProfCreds['payload']['user_type'][i]['id'];
            // mapProfCredsT[{respProfCreds['payload']['user_type'][i]['id']}] = false;
            mapProfCredsT[id_key] = false;
            respProfCreds['payload']['user_type'][i]['select_state'] = false;
            // print('Data from the loop : ${respProfCreds['payload']['user_type'][i]['id'].toString()}');
          }
        });
      } else {
        Fluttertoast.showToast(
            msg: respMessage,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: toastBackgroundColor,
            textColor: toastTextColor,
            fontSize: 16.0);
        /*scaffoldState.currentState.showSnackBar(
          SnackBar(
            content: Text('$respMessage'),
            duration: Duration(seconds: 3),
          ),
        );*/
      }
    } else {
      Fluttertoast.showToast(
          msg: "Please check your internet connectivity and try again",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: toastBackgroundColor,
          textColor: toastTextColor,
          fontSize: 16.0);
      /*scaffoldState.currentState.showSnackBar(
        SnackBar(
          content: Text("Please check your internet connectivity and try again"),
          duration: Duration(seconds: 3),
        ),
      );*/
    }
  }

  void checkForInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if ((connectivityResult == ConnectivityResult.mobile) || (connectivityResult == ConnectivityResult.wifi)) {
      setState(() {
        isLoaderShowing = true;
      });
      getJobTitles();
    } else {
      Fluttertoast.showToast(
          msg: "Please check your internet connectivity and try again",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: toastBackgroundColor,
          textColor: toastTextColor,
          fontSize: 16.0);
      /*scaffoldState.currentState.showSnackBar(
        SnackBar(
          content: Text("Please check your internet connectivity and try again"),
          duration: Duration(seconds: 3),
        ),
      );*/
    }
  }

  // Need to test this scenario..
  Future<List<Job_title>> getJobTitles() async {
    // String urls = 'https://my-cpe.com/api/v3/job-title/list';
    var urls = Uri.parse(URLs.BASE_URL + 'job-title/list');

    final response = await http.get(
      urls,
      headers: {
        'Accept': 'Application/json',
      },
    );

    this.setState(() {
      ConstSignUp.dataJTitle = jsonDecode(response.body);
      isLoaderShowing = false;
    });

    setState(() {
      print('API response is : ${ConstSignUp.dataJTitle}');
      ConstSignUp.arrCountJTitle = ConstSignUp.dataJTitle['payload']['job_title'].length;
      ConstSignUp.data_web_jtitle = ConstSignUp.dataJTitle['payload']['job_title'];
      print('Size for array is : ${ConstSignUp.arrCountJTitle}');
    });

    if (ConstSignUp.listJobTitle != null && ConstSignUp.listJobTitle.isNotEmpty) {
      ConstSignUp.listJobTitle.addAll(List.from(ConstSignUp.data_web_jtitle).map<Job_title>((item) => Job_title.fromJson(item)).toList());
    } else {
      ConstSignUp.listJobTitle = List.from(ConstSignUp.data_web_jtitle).map<Job_title>((item) => Job_title.fromJson(item)).toList();
    }

    getIndustries();

    print('Size for the list is : ${ConstSignUp.listJobTitle.length}');
    return ConstSignUp.listJobTitle;
  }

  Future<List<Industries_list>> getIndustries() async {
    isLoaderShowing = true;
    // String urls = 'https://my-cpe.com/api/v3/industry/list';
    var urls = Uri.parse(URLs.BASE_URL + 'industry/list');

    final response = await http.get(
      urls,
      headers: {
        'Accept': 'Application/json',
      },
    );

    this.setState(() {
      ConstSignUp.dataIndustries = jsonDecode(response.body);
      isLoaderShowing = false;
    });

    setState(() {
      print('API response Industries is : ${ConstSignUp.dataIndustries}');
      ConstSignUp.arrCountIndustries = ConstSignUp.dataIndustries['payload']['industries_list'].length;
      ConstSignUp.data_web_industries = ConstSignUp.dataIndustries['payload']['industries_list'];
      print('Size for array is : ${ConstSignUp.arrCountIndustries}');
    });

    if (ConstSignUp.listIndustries != null && ConstSignUp.listIndustries.isNotEmpty) {
      ConstSignUp.listIndustries
          .addAll(List.from(ConstSignUp.data_web_industries).map<Industries_list>((item) => Industries_list.fromJson(item)).toList());
    } else {
      ConstSignUp.listIndustries = List.from(ConstSignUp.data_web_industries).map<Industries_list>((item) => Industries_list.fromJson(item)).toList();
    }

    getProfessionalCredsAPI();

    print('Size for the list is : ${ConstSignUp.listJobTitle.length}');
    return ConstSignUp.listIndustries;
  }

  Future<List<User_type>> getProfessionalCredsAPI() async {
    isLoaderShowing = true;
    // String urls = 'https://my-cpe.com/api/v3/user-type';
    var urls = Uri.parse(URLs.BASE_URL + 'user-type');

    final response = await http.get(
      urls,
      headers: {
        'Accept': 'Application/json',
      },
    );

    this.setState(() {
      // data = JSON.decode(response.body);
      ConstSignUp.data_prof = jsonDecode(response.body);
      isLoaderShowing = false;
    });

    // print(data[1]["title"]);
    setState(() {
      print('API response is : ${ConstSignUp.data_prof}');
      ConstSignUp.arrCountProf = ConstSignUp.data_prof['payload']['user_type'].length;
      ConstSignUp.data_web_prof = ConstSignUp.data_prof['payload']['user_type'];
      print('Size for array is : ${ConstSignUp.arrCountProf}');
    });

    if (ConstSignUp.listProfCreds != null && ConstSignUp.listProfCreds.isNotEmpty) {
      ConstSignUp.listProfCreds.addAll(List.from(ConstSignUp.data_web_prof).map<User_type>((item) => User_type.fromJson(item)).toList());
    } else {
      ConstSignUp.listProfCreds = List.from(ConstSignUp.data_web_prof).map<User_type>((item) => User_type.fromJson(item)).toList();
    }

    print('Size for the list is : ${ConstSignUp.listProfCreds.length}');
    return ConstSignUp.listProfCreds;
  }

  void clickEventOrgSize(int index) {
    setState(() {
      ConstSignUp.organizationSize = '';
      ConstSignUp.organizationSize = ConstSignUp.orgSizeList[index];
      ConstSignUp.isOrganizationSizeSelected = true;

      FocusManager.instance.primaryFocus.unfocus();
      Navigator.pop(context);
    });
  }

  void clickEventJobTitle(int index) {
    setState(() {
      ConstSignUp.jobTitle = ConstSignUp.listJobTitle[index].name;
      ConstSignUp.isJobTitleSelected = true;
      ConstSignUp.jobTitleId = ConstSignUp.listJobTitle[index].id;

      FocusManager.instance.primaryFocus.unfocus();
      Navigator.pop(context);
    });
  }

  void clickEventIndustry(int index) {
    setState(() {
      ConstSignUp.industry = ConstSignUp.listIndustries[index].name;
      ConstSignUp.isIndustrySelected = true;
      ConstSignUp.industryId = ConstSignUp.listIndustries[index].id;

      FocusManager.instance.primaryFocus.unfocus();
      Navigator.pop(context);
    });
  }

  void checkForClickBottom(int index) {
    if (ConstSignUp.listProfCreds[index].isSelected) {
      ConstSignUp.listProfCreds[index].isSelected = false;
      setState(() {
        ConstSignUp.smallTitles.remove(ConstSignUp.listProfCreds[index].shortTitle);
        ConstSignUp.smallTitlesId.remove(ConstSignUp.listProfCreds[index].id.toString());
        print('Length of smallTitles : ${ConstSignUp.smallTitles.length}');
        print('Data for smallTitles : ${ConstSignUp.smallTitles.toString()}');
      });
    } else {
      ConstSignUp.listProfCreds[index].isSelected = true;
      setState(() {
        ConstSignUp.smallTitles.add(ConstSignUp.listProfCreds[index].shortTitle);
        ConstSignUp.smallTitlesId.add(ConstSignUp.listProfCreds[index].id.toString());
        print('Length of smallTitles : ${ConstSignUp.smallTitles.length}');
        print('Data for smallTitles : ${ConstSignUp.smallTitles.toString()}');
      });
    }
    FocusManager.instance.primaryFocus.unfocus();
  }

  void checkForValidation() {
    if (ConstSignUp.strCompanyName == '' || ConstSignUp.strCompanyName.length == 0) {
      Fluttertoast.showToast(
          msg: companyEmptyMsg,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: toastBackgroundColor,
          textColor: toastTextColor,
          fontSize: 16.0);
      /*scaffoldState.currentState.showSnackBar(
        SnackBar(
          content: Text(companyEmptyMsg),
          duration: Duration(seconds: 3),
        ),
      );*/
    } else if (ConstSignUp.organizationSize == '' || ConstSignUp.organizationSize.length == 0) {
      Fluttertoast.showToast(
          msg: selectOrganizationSizeMsg,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: toastBackgroundColor,
          textColor: toastTextColor,
          fontSize: 16.0);
      /*scaffoldState.currentState.showSnackBar(
        SnackBar(
          content: Text(selectOrganizationSizeMsg),
          duration: Duration(seconds: 3),
        ),
      );*/
    } else if (ConstSignUp.jobTitle == '' || ConstSignUp.jobTitle.length == 0) {
      Fluttertoast.showToast(
          msg: selectJobTitleMsg,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: toastBackgroundColor,
          textColor: toastTextColor,
          fontSize: 16.0);
      /*scaffoldState.currentState.showSnackBar(
        SnackBar(
          content: Text(selectJobTitleMsg),
          duration: Duration(seconds: 3),
        ),
      );*/
    } else if (ConstSignUp.industry == '' || ConstSignUp.industry.length == 0) {
      Fluttertoast.showToast(
          msg: selectIndustryMsg,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: toastBackgroundColor,
          textColor: toastTextColor,
          fontSize: 16.0);
      /*scaffoldState.currentState.showSnackBar(
        SnackBar(
          content: Text(selectIndustryMsg),
          duration: Duration(seconds: 3),
        ),
      );*/
    } else if (ConstSignUp.smallTitles.length == 0) {
      Fluttertoast.showToast(
          msg: selectPrefCredsMsg,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: toastBackgroundColor,
          textColor: toastTextColor,
          fontSize: 16.0);
      /*scaffoldState.currentState.showSnackBar(
        SnackBar(
          content: Text(selectPrefCredsMsg),
          duration: Duration(seconds: 3),
        ),
      );*/
    } else {
      // if (ConstSignUp.listCountry != null || ConstSignUp.listCountry.length > 0) {
      if (ConstSignUp.listCountry != null) {
        ConstSignUp.listCountry.clear();
      }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SignUpScreen3(),
        ),
      );
    }
  }

  void setData() {
    companyNameController.text = ConstSignUp.strCompanyName;

    Future.delayed(const Duration(milliseconds: 500), () {
      FocusManager.instance.primaryFocus.unfocus();
    });
  }

  Future<bool> onBackPressEvent() {
    ConstSignUp.strCompanyName = companyNameController.text;
    Navigator.pop(context);
  }
}
