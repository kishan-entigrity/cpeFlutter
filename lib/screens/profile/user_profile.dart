import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:cpe_flutter/screens/profile/pagination_industries/industry_list.dart';
import 'package:cpe_flutter/screens/profile/pagination_job_titles/jobtitle_list.dart';
import 'package:cpe_flutter/screens/profile/pagination_profcreds/profcreds_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
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
  _UserProfileState(this.dataIntent);

  final dataIntent;
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
  String strJobTitleName = '';
  String industryName = '';

  var jobTitleId = 0;
  var industryId = 0;

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

  bool isLoaderShowing = false;
  String _authToken = "";
  var resp;
  var data;
  var data_web;
  var data_indus;
  var data_prof;

  List<Job_title> list_job_title;
  int arrCountJobTitle = 0;
  bool isLast = false;

  List<Industries_list> list_industries;
  int arrCountIndustries = 0;

  List<User_type> list_profcreds;
  int arrProfCredsCount = 0;
  Map mapProfCredsT = new Map<dynamic, bool>();

  var isJobTitleSelected = false;
  var isIndustrySelected = false;
  var jobTitle = '';

  Future<List<Job_title>> getJobTitleList(String authToken) async {
    String urls = 'https://my-cpe.com/api/v3/job-title/list';

    final response = await http.get(
      urls,
      headers: {
        'Accept': 'Application/json',
        'Authorization': '$authToken',
      },
    );

    this.setState(() {
      // data = JSON.decode(response.body);
      data = jsonDecode(response.body);
      // isLoaderShowing = false;
      isLast = true;
    });

    print('API response jobtitles is : $data');
    arrCountJobTitle = data['payload']['job_title'].length;
    data_web = data['payload']['job_title'];
    print('Size for array jobtitles is : $arrCountJobTitle');

    if (list_job_title != null && list_job_title.isNotEmpty) {
      list_job_title.addAll(List.from(data_web).map<Job_title>((item) => Job_title.fromJson(item)).toList());
    } else {
      list_job_title = List.from(data_web).map<Job_title>((item) => Job_title.fromJson(item)).toList();
    }

    getIndustryList(authToken);

    return list_job_title;
  }

  Future<List<Industries_list>> getIndustryList(String authToken) async {
    String urls = 'https://my-cpe.com/api/v3/industry/list';

    final response = await http.get(
      urls,
      headers: {
        'Accept': 'Application/json',
        'Authorization': '$authToken',
      },
    );

    this.setState(() {
      // data = JSON.decode(response.body);
      data = jsonDecode(response.body);
      // isLoaderShowing = false;
      isLast = true;
    });

    print('API response industries is : $data');
    arrCountIndustries = data['payload']['industries_list'].length;
    data_indus = data['payload']['industries_list'];
    print('Size for array industries is : $arrCountIndustries');

    if (list_industries != null && list_industries.isNotEmpty) {
      list_industries.addAll(List.from(data_indus).map<Industries_list>((item) => Industries_list.fromJson(item)).toList());
    } else {
      list_industries = List.from(data_indus).map<Industries_list>((item) => Industries_list.fromJson(item)).toList();
    }

    getProfessionalCreds(authToken);

    return list_industries;
  }

  Future<List<User_type>> getProfessionalCreds(String authToken) async {
    String urls = 'https://my-cpe.com/api/v3/user-type';

    final response = await http.get(
      urls,
      headers: {
        'Accept': 'Application/json',
        'Authorization': '$authToken',
      },
    );

    this.setState(() {
      // data = JSON.decode(response.body);
      data = jsonDecode(response.body);
      isLoaderShowing = false;
      isLast = true;
    });

    print('API response prof creds is : $data');
    arrProfCredsCount = data['payload']['user_type'].length;
    data_prof = data['payload']['user_type'];
    print('Size for array prof creds is : $arrProfCredsCount');

    if (list_profcreds != null && list_profcreds.isNotEmpty) {
      list_profcreds.addAll(List.from(data_prof).map<User_type>((item) => User_type.fromJson(item)).toList());
    } else {
      list_profcreds = List.from(data_prof).map<User_type>((item) => User_type.fromJson(item)).toList();
    }

    /*for (int i = 0; i < list_profcreds.length; i++) {
      print('data on forloop pos : ${list_profcreds[i].id}');
    }*/

    return list_profcreds;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('Resp: $dataIntent');

    setState(() {
      strProfilePic = dataIntent['profile_picture'];
      strFName = dataIntent['first_name'];
      strLName = dataIntent['last_name'];
      strEmail = dataIntent['email'];
      strPhone = dataIntent['phone'];
      strExt = dataIntent[''];
      strMobile = dataIntent['contact_no'];
      strCompany = dataIntent['company_name'];
      strJobTitleName = dataIntent['jobtitle_name'];
      industryName = dataIntent['industry_name'];

      jobTitleId = dataIntent['jobtitle_id'];
      // industryId = dataIntent['industry_id'];

      if (strJobTitleName.isNotEmpty) {
        isJobTitleSelected = true;
      } else {
        isJobTitleSelected = false;
      }

      if (industryName.isNotEmpty) {
        isIndustrySelected = true;
      } else {
        isIndustrySelected = false;
      }
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

    checkForSP();
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
                            color: Colors.white,
                            margin: EdgeInsets.only(left: 6.0.w, right: 8.5.w, top: 4.0.w, bottom: 4.0.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Company Size',
                                  style: kLableSignUpTextStyle,
                                ),
                                Icon(FontAwesomeIcons.caretDown),
                              ],
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
                        GestureDetector(
                          onTap: () {
                            if (isEditable) {
                              print('Clicked on Job Title..');
                            }
                          },
                          child: Container(
                            color: Colors.white,
                            padding: EdgeInsets.fromLTRB(6.0.w, 4.0.w, 8.5.w, 4.0.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  isJobTitleSelected ? strJobTitleName : 'Job Title/Designation',
                                  style: TextStyle(
                                    fontFamily: 'Whitney Bold',
                                    fontSize: 15.0.sp,
                                    color: isJobTitleSelected ? Colors.black : Color(0xFFBDBFCA),
                                  ),
                                ),
                                Icon(FontAwesomeIcons.caretDown),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(6.0.w, 0, 6.0.w, 0.0),
                          child: Divider(
                            height: 5.0,
                            color: Colors.black87,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (isEditable) {
                              print('Clicked on Industry list data..');
                            }
                          },
                          child: Container(
                            color: Colors.white,
                            padding: EdgeInsets.fromLTRB(6.0.w, 4.0.w, 8.5.w, 4.0.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  isIndustrySelected ? industryName : 'Industry',
                                  style: TextStyle(
                                    fontFamily: 'Whitney Bold',
                                    fontSize: 15.0.sp,
                                    color: isIndustrySelected ? Colors.black : Color(0xFFBDBFCA),
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
                        /*GestureDetector(
                          onTap: () {
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
                                            color: Colors.transparent,
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(30.0),
                                              topLeft: Radius.circular(30.0),
                                            ),
                                          ),
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                height: 17.0.w,
                                                decoration: BoxDecoration(
                                                  color: Color(0xF0F3F5F9),
                                                  // color: Colors.blueGrey,
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
                                                          'Prefessional Credentials',
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
                                                  itemCount: arrProfCredsCount,
                                                  itemBuilder: (context, index) {
                                                    return ConstrainedBox(
                                                      constraints: BoxConstraints(
                                                        minHeight: 15.0.w,
                                                      ),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          print('Check status for : $isProfChecked');
                                                          // var profId = respProfCreds['payload']['user_type'][index]['id'];
                                                          var profId = list_profcreds[index].id;
                                                          setState(() {
                                                            if (mapProfCredsT[profId]) {
                                                              selectedProfCount--;
                                                              mapProfCredsT[profId] = false;
                                                              mapProfCredsName.remove(profId);
                                                              // mapProfCredsName[profId]
                                                              print('array data : ${mapProfCredsName.values}');
                                                            } else {
                                                              selectedProfCount++;
                                                              mapProfCredsT[profId] = true;
                                                              mapProfCredsName[profId] = respProfCreds['payload']['user_type'][index]['title'];
                                                              print('array data : ${mapProfCredsName.values}');
                                                            }
                                                          });
                                                        },
                                                        child: Container(
                                                          margin: EdgeInsets.fromLTRB(3.0.w, 3.0.w, 3.0.w, 0.0),
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(7.0),
                                                            color: mapProfCredsT[respProfCreds['payload']['user_type'][index]['id']]
                                                                ? themeYellow
                                                                : Colors.teal,
                                                          ),
                                                          child: Flexible(
                                                            child: Container(
                                                              child: Padding(
                                                                padding: EdgeInsets.symmetric(vertical: 3.5.w, horizontal: 3.5.w),
                                                                child: Row(
                                                                  children: <Widget>[
                                                                    Icon(
                                                                      // isProfChecked ? FontAwesomeIcons.checkCircle : FontAwesomeIcons.circle,
                                                                      mapProfCredsT[respProfCreds['payload']['user_type'][index]['id']]
                                                                          ? FontAwesomeIcons.checkCircle
                                                                          : FontAwesomeIcons.circle,
                                                                      size: 12.0.sp,
                                                                    ),
                                                                    SizedBox(
                                                                      width: 3.5.w,
                                                                    ),
                                                                    Expanded(
                                                                      child: Text(
                                                                        '${respProfCreds['payload']['user_type'][index]['title']}',
                                                                        // 'Test Name',
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
                          },
                          child: Container(
                            color: Colors.white,
                            padding: EdgeInsets.fromLTRB(6.0.w, 4.0.w, 8.5.w, 4.0.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Professional Credentials',
                                  style: TextStyle(
                                    fontFamily: 'Whitney Bold',
                                    fontSize: 15.0.sp,
                                    color: isProfCredsSelected ? Colors.black : Color(0xFFBDBFCA),
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
                        Visibility(
                          // visible: selectedProfCount>0? true : false,
                          visible: true,
                          child: Container(
                            margin: EdgeInsets.fromLTRB(6.0.w, 0, 6.0.w, 0),
                            child: Wrap(
                              children: List.generate(
                                // arrProfCredsCount,
                                // selectedProfCount,
                                mapProfCredsName.length,
                                (i) {
                                  // (mapProfCredsName.keys.forEach((k) => i)) {
                                  // (mapProfCredsName.forEach((key, value) {k})){
                                  // (i = mapProfCredsName.keys) {
                                  return Container(
                                    margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
                                    child: Chip(
                                      label: Container(
                                        child: Text(
                                          // '${respProfCreds['payload']['user_type'][i]['title']}',
                                          '${mapProfCredsName[i]}',
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(6.0.w, 0, 6.0.w, 0),
                          child: Divider(
                            height: 5.0,
                            color: Colors.black87,
                          ),
                        ),*/
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

  void checkForSP() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool checkValue = preferences.getBool("check");

    if (checkValue != null) {
      if (checkValue) {
        setState(() {
          String token = preferences.getString("spToken");
          _authToken = 'Bearer $token';
        });
      } else {
        print('Check value : $checkValue');
        preferences.clear();
      }
    } else {
      print('Null value else part');
      checkValue = false;
    }
    getJobTitleAPI();
  }

  void getJobTitleAPI() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if ((connectivityResult == ConnectivityResult.mobile) || (connectivityResult == ConnectivityResult.wifi)) {
      setState(() {
        isLoaderShowing = true;
      });
      resp = await getJobTitleList(_authToken);
      print(resp);
      setState(() {
        isLoaderShowing = false;
      });
    } else {
      scaffoldState.currentState.showSnackBar(
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
