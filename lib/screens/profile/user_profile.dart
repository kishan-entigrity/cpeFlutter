import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:cpe_flutter/components/SpinKitSample1.dart';
import 'package:cpe_flutter/components/custom_dialog.dart';
import 'package:cpe_flutter/components/round_icon_button.dart';
import 'package:cpe_flutter/screens/intro_login_signup/model/city_list_model.dart';
import 'package:cpe_flutter/screens/intro_login_signup/model/country_list_model.dart';
import 'package:cpe_flutter/screens/intro_login_signup/model/state_list_model.dart';
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
import '../../rest_api.dart';

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

  var isEditable = true;

  String strProfilePic = '';
  String strDummyPic = 'https://testing-website.in/images/avatar-place-holder.png';
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
  List<String> orgSizeList = ['0-9', '10-15', '16-50', '51-500', '501-1000', '1000+'];

  // var companySizeSelectedPos = 0;
  var strOrgSize = '';

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
  static List<String> smallTitles = [];
  static List<String> smallTitlesId = [];
  static var user_type_ids = '';

  var isJobTitleSelected = false;
  var isIndustrySelected = false;
  var jobTitle = '';

  String strNameInitials = '';

  TextEditingController ptinController = TextEditingController();
  TextEditingController ctecController = TextEditingController();
  TextEditingController cfpController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();

  var strPTIN = '';
  var strCTEC = '';
  var strCFP = '';
  var strZipCode = '';

  List<Country> listCountry;
  int arrCountCountry = 0;
  var respCountry;
  var respCountryData;
  var selectedCountryName = '';
  var selectedCountryId = 0;
  bool isCountrySelected = false;

  List<State_Name> listState;
  int arrCountState = 0;
  var respState;
  var respStateData;
  var selectedStateName = '';
  var selectedStateId = 0;
  bool isStateSelected = false;

  List<City> listCity;
  int arrCountCity = 0;
  var respCity;
  var respCityData;
  var selectedCityName = '';
  var selectedCityId = 0;
  bool isCitySelected = false;

  var dataIntentProfCreds;
  var dataIntentProfCredsSize;

  var respEditProf;
  var respEditProfStatus;
  var respEditProfMessage;

  SharedPreferences sharedPreferences;

  Future<List<Job_title>> getJobTitleList(String authToken) async {
    // String urls = 'https://my-cpe.com/api/v3/job-title/list';
    String urls = URLs.BASE_URL + 'job-title/list';

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
    // String urls = 'https://my-cpe.com/api/v3/industry/list';
    String urls = URLs.BASE_URL + 'industry/list';

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

    smallTitles.clear();
    smallTitlesId.clear();
    getProfessionalCreds(authToken);

    return list_industries;
  }

  Future<List<User_type>> getProfessionalCreds(String authToken) async {
    // String urls = 'https://my-cpe.com/api/v3/user-type';
    String urls = URLs.BASE_URL + 'user-type';

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

    for (int j = 0; j < dataIntentProfCredsSize; j++) {
      print('Data for the inner loop is : ${dataIntentProfCreds[j]['id']}');
      for (int i = 0; i < list_profcreds.length; i++) {
        if (dataIntentProfCreds[j]['id'].toString() == list_profcreds[i].id.toString()) {
          list_profcreds[i].isSelected = true;
          smallTitles.add(list_profcreds[i].shortTitle.toString());
          smallTitlesId.add(list_profcreds[i].id.toString());
        }
      }
    }
    getCountryListAPI();

    return list_profcreds;
  }

  Future<List<Country>> getCountryListAPI() async {
    // String urls = 'https://my-cpe.com/api/v3/country';
    String urls = URLs.BASE_URL + 'country';

    final response = await http.get(
      urls,
      headers: {
        'Accept': 'Application/json',
      },
    );

    this.setState(() {
      respCountry = jsonDecode(response.body);
      isLoaderShowing = false;
    });

    setState(() {
      print('API response is : $respCountry');
      arrCountCountry = respCountry['payload']['country'].length;
      respCountryData = respCountry['payload']['country'];
      print('Size for array is : $respCountryData');
    });

    if (listCountry != null && listCountry.isNotEmpty) {
      listCountry.addAll(List.from(respCountryData).map<Country>((item) => Country.fromJson(item)).toList());
    } else {
      listCountry = List.from(respCountryData).map<Country>((item) => Country.fromJson(item)).toList();
    }

    print('Size for the list is : $listCountry.length');
    return listCountry;
  }

  Future<List<State_Name>> getStateNameListAPI(int selectedCountryId) async {
    // String urls = 'https://my-cpe.com/api/v3/state';
    String urls = URLs.BASE_URL + 'state';

    final response = await http.post(
      urls,
      headers: {
        'Accept': 'Application/json',
      },
      body: {
        'country_id': selectedCountryId.toString(),
      },
    );

    this.setState(() {
      respState = jsonDecode(response.body);
      isLoaderShowing = false;
    });

    setState(() {
      print('API response is : $respState');
      arrCountState = respState['payload']['state'].length;
      respStateData = respState['payload']['state'];
      print('Size for array is : $respStateData');
    });

    if (listState != null && listState.isNotEmpty) {
      listState.addAll(List.from(respStateData).map<State_Name>((item) => State_Name.fromJson(item)).toList());
    } else {
      listState = List.from(respStateData).map<State_Name>((item) => State_Name.fromJson(item)).toList();
    }

    print('Size for the list is : ${listState.length}');
    return listState;
  }

  Future<List<City>> getCityNameListAPI(int selectedStateId) async {
    // String urls = 'https://my-cpe.com/api/v3/city';
    String urls = URLs.BASE_URL + 'city';

    final response = await http.post(
      urls,
      headers: {
        'Accept': 'Application/json',
      },
      body: {
        'state_id': selectedStateId.toString(),
      },
    );

    this.setState(() {
      respCity = jsonDecode(response.body);
      isLoaderShowing = false;
    });

    setState(() {
      print('API response is : $respCity');
      arrCountCity = respCity['payload']['city'].length;
      respCityData = respCity['payload']['city'];
      print('Size for array is : $respStateData');
    });

    if (listCity != null && listCity.isNotEmpty) {
      listCity.addAll(List.from(respCityData).map<City>((item) => City.fromJson(item)).toList());
    } else {
      listCity = List.from(respCityData).map<City>((item) => City.fromJson(item)).toList();
    }

    print('Size for the list is : ${listState.length}');
    return listCity;
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
      industryId = dataIntent['industry_id'];
      strOrgSize = dataIntent['co_emp_size'];

      print('User profile screen profile pic is : $strProfilePic');

      strNameInitials = strFName.toString()[0] + ' ' + strLName.toString()[0];

      selectedCountryName = dataIntent['country'];
      selectedStateName = dataIntent['state'];
      selectedCityName = dataIntent['city'];
      selectedCountryId = dataIntent['country_id'];
      selectedStateId = dataIntent['state_id'];
      selectedCityId = dataIntent['city_id'];
      strZipCode = dataIntent['zipcode'];
      if (dataIntent['ptin_number'].toString().startsWith('P')) {
        strPTIN = dataIntent['ptin_number'].toString().substring(1);
      } else {
        strPTIN = dataIntent['ptin_number'];
      }

      if (strPhone.contains('-')) {
        print('Yes Phone number contains - ');
        String s = strPhone;
        int idx = s.indexOf("-");

        strPhone = s.substring(0, idx).trim();
        strExt = s.substring(idx + 1).trim();
        print('Phone number is : ${s.substring(0, idx).trim()}');
        print('Ext number is : ${s.substring(idx + 1).trim()}');
      }

      setState(() {
        strPhone = strPhone.replaceAll(' ', '');
        strPhone = strPhone.replaceAll('(', '');
        strPhone = strPhone.replaceAll(')', '');

        print('After trimming number is like : $strPhone');

        strMobile = strMobile.replaceAll(' ', '');
        strMobile = strMobile.replaceAll('-', '');
        strMobile = strMobile.replaceAll('(', '');
        strMobile = strMobile.replaceAll(')', '');

        print('Mobile number after trimming is : $strMobile');
      });

      if (strPTIN.contains('-')) {
        String s = strPTIN;
        int idx = s.indexOf("-");

        strPTIN = s.substring(idx + 1).trim();
      }

      if (dataIntent['ctec_id'].toString().startsWith('A')) {
        strCTEC = dataIntent['ctec_id'].toString().substring(1);
      } else {
        strCTEC = dataIntent['ctec_id'];
      }
      dataIntentProfCreds = dataIntent['professional_cred_cert'];
      dataIntentProfCredsSize = dataIntent['professional_cred_cert'].length;

      print('dataIntentProfCreds size is : ${dataIntentProfCredsSize}');

      if (selectedCountryName != '') {
        isCountrySelected = true;
      }

      if (selectedStateName != '') {
        isStateSelected = true;
      }

      if (selectedCityName != '') {
        isCitySelected = true;
      }

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
    extController.text = strExt;
    mobileController.text = strMobile;
    companyNameController.text = strCompany;
    zipCodeController.text = strZipCode;
    ptinController.text = strPTIN;
    ctecController.text = strCTEC;

    checkForSP();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldState,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned(
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
                          child: Visibility(
                            visible: false,
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
                                child: strProfilePic == '' || strProfilePic == strDummyPic
                                    ? Container(
                                        height: 30.0.w,
                                        width: 30.0.w,
                                        decoration: BoxDecoration(
                                          color: Colors.blueGrey,
                                          borderRadius: BorderRadius.circular(25.0.w),
                                        ),
                                        child: Center(
                                          child: Text(
                                            '${strNameInitials.toUpperCase()}',
                                            style: TextStyle(
                                              fontSize: 25.0.sp,
                                              color: Colors.white,
                                              fontFamily: 'Whitney Bold',
                                            ),
                                          ),
                                        ),
                                      )
                                    : CircleAvatar(
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
                                enabled: false,
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
                                maxLength: 10,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  counter: SizedBox.shrink(),
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
                                      maxLength: 10,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        counter: SizedBox.shrink(),
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
                                                  Expanded(
                                                    child: ListView.builder(
                                                      itemCount: orgSizeList.length,
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
                                                                color: strOrgSize == orgSizeList[index] ? themeYellow : testColor,
                                                                borderRadius: BorderRadius.circular(7.0),
                                                                // color: Colors.teal,
                                                              ),
                                                              child: Padding(
                                                                padding: EdgeInsets.symmetric(vertical: 3.5.w, horizontal: 3.5.w),
                                                                child: Row(
                                                                  children: <Widget>[
                                                                    Expanded(
                                                                      child: Text(
                                                                        // list[index].shortTitle,
                                                                        orgSizeList[index],
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
                                                    ),
                                                  ),
                                                ],
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
                                      // 'Company Size',
                                      strOrgSize == '' ? 'Company Size' : strOrgSize,
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
                                                    child: ListView.builder(
                                                      itemCount: list_job_title.length,
                                                      itemBuilder: (context, index) {
                                                        return ConstrainedBox(
                                                          constraints: BoxConstraints(
                                                            minHeight: 15.0.w,
                                                          ),
                                                          child: GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                clickEventJobTitle(index);
                                                              });
                                                            },
                                                            child: Container(
                                                              margin: EdgeInsets.fromLTRB(3.0.w, 3.0.w, 3.0.w, 0.0),
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(7.0),
                                                                color: strJobTitleName == list_job_title[index].name ? themeYellow : testColor,
                                                              ),
                                                              child: Padding(
                                                                padding: EdgeInsets.symmetric(vertical: 3.5.w, horizontal: 3.5.w),
                                                                child: Row(
                                                                  children: <Widget>[
                                                                    Expanded(
                                                                      child: Text(
                                                                        list_job_title[index].name,
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
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      });
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
                                                    child: ListView.builder(
                                                      itemCount: list_industries.length,
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
                                                                color: list_industries[index].name == industryName ? themeYellow : testColor,
                                                              ),
                                                              child: Padding(
                                                                padding: EdgeInsets.symmetric(vertical: 3.5.w, horizontal: 3.5.w),
                                                                child: Row(
                                                                  children: <Widget>[
                                                                    Expanded(
                                                                      child: Text(
                                                                        list_industries[index].name,
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
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      });
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
                            GestureDetector(
                              onTap: () {
                                print('Clicked on Professional creds');
                                if (isEditable) {
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
                                                  Expanded(
                                                    child: ListView.builder(
                                                      itemCount: list_profcreds.length,
                                                      itemBuilder: (context, index) {
                                                        return ConstrainedBox(
                                                          constraints: BoxConstraints(
                                                            minHeight: 15.0.w,
                                                          ),
                                                          child: GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                clickForProfCreds(index);
                                                              });
                                                            },
                                                            child: Container(
                                                              margin: EdgeInsets.fromLTRB(3.0.w, 3.0.w, 3.0.w, 0.0),
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(7.0),
                                                                color: list_profcreds[index].isSelected ? themeYellow : testColor,
                                                              ),
                                                              child: Padding(
                                                                padding: EdgeInsets.symmetric(vertical: 3.5.w, horizontal: 3.5.w),
                                                                child: Row(
                                                                  children: <Widget>[
                                                                    Icon(
                                                                      list_profcreds[index].isSelected
                                                                          ? FontAwesomeIcons.checkCircle
                                                                          : FontAwesomeIcons.circle,
                                                                      size: 12.0.sp,
                                                                    ),
                                                                    SizedBox(
                                                                      width: 3.5.w,
                                                                    ),
                                                                    Expanded(
                                                                      child: Text(
                                                                        list_profcreds[index].shortTitle,
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
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      });
                                }
                              },
                              child: Container(
                                color: Colors.white,
                                padding: EdgeInsets.fromLTRB(6.0.w, 4.0.w, 8.5.w, 4.0.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      // isIndustrySelected ? industryName : 'Industry',
                                      'Professional Credentials',
                                      style: TextStyle(
                                        fontFamily: 'Whitney Bold',
                                        fontSize: 15.0.sp,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Icon(FontAwesomeIcons.caretDown),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(6.0.w, 0, 6.0.w, 0),
                              child: Wrap(
                                children: List.generate(
                                  smallTitles.length,
                                  (i) {
                                    return Container(
                                      // margin: EdgeInsets.symmetric(horizontal: 4.0, vertical: 0.0),
                                      margin: EdgeInsets.only(right: 8.0),
                                      child: Chip(
                                        backgroundColor: themeYellow,
                                        label: Container(
                                          child: Text(
                                            '${smallTitles[i].toString()}',
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
                            Container(
                              child: Text(
                                'PTIN',
                                style: kLableSignUpHintLableStyle,
                              ),
                              margin: EdgeInsets.only(left: 6.0.w, right: 6.0.w, top: 2.0.w),
                            ),
                            Container(
                              // margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 6.0.w),
                              margin: EdgeInsets.only(left: 6.0.w, right: 6.0.w, top: 0.0.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      'P',
                                      style: kLableSignUpTextStyle,
                                    ),
                                    margin: EdgeInsets.only(bottom: 7.0.sp),
                                  ),
                                  Expanded(
                                    child: TextField(
                                      controller: ptinController,
                                      enabled: isEditable,
                                      maxLength: 8,
                                      style: kLableSignUpTextStyle,
                                      decoration: InputDecoration(
                                        counter: SizedBox.shrink(),
                                        border: InputBorder.none,
                                        hintText: '',
                                        hintStyle: kLableSignUpHintStyle,
                                      ),
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.next,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      scaffoldState.currentState.showSnackBar(
                                        SnackBar(
                                          content: Text(ptinInfoMsg),
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
                              margin: EdgeInsets.fromLTRB(6.0.w, 1.0.w, 6.0.w, 0),
                              child: Divider(
                                height: 5.0,
                                color: Colors.black87,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 6.0.w, right: 6.0.w, top: 2.0.w),
                              child: Text(
                                'CTEC ID',
                                style: kLableSignUpHintLableStyle,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 6.0.w),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      'A',
                                      style: kLableSignUpTextStyle,
                                    ),
                                    margin: EdgeInsets.only(bottom: 7.0.sp),
                                  ),
                                  Expanded(
                                    child: TextField(
                                      controller: ctecController,
                                      enabled: isEditable,
                                      maxLength: 6,
                                      keyboardType: TextInputType.number,
                                      style: kLableSignUpTextStyle,
                                      decoration: InputDecoration(
                                        counter: SizedBox.shrink(),
                                        border: InputBorder.none,
                                        hintText: '',
                                        hintStyle: kLableSignUpHintStyle,
                                      ),
                                      textInputAction: TextInputAction.next,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      scaffoldState.currentState.showSnackBar(
                                        SnackBar(
                                          content: Text(ctecInfoMsg),
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
                              margin: EdgeInsets.fromLTRB(6.0.w, 1.0.w, 6.0.w, 0),
                              child: Divider(
                                height: 5.0,
                                color: Colors.black87,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 6.0.w, right: 6.0.w, top: 2.0.w),
                              child: Text(
                                'CFP ID',
                                style: kLableSignUpHintLableStyle,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 6.0.w),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: TextField(
                                      controller: cfpController,
                                      enabled: isEditable,
                                      style: kLableSignUpTextStyle,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: '',
                                        hintStyle: kLableSignUpHintStyle,
                                      ),
                                      textInputAction: TextInputAction.next,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      scaffoldState.currentState.showSnackBar(
                                        SnackBar(
                                          content: Text(cfpInfoMsg),
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
                              margin: EdgeInsets.fromLTRB(6.0.w, 1.0.w, 6.0.w, 0),
                              child: Divider(
                                height: 5.0,
                                color: Colors.black87,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (isEditable) {
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
                                                              'Country',
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
                                                    child: ListView.builder(
                                                      itemCount: listCountry.length,
                                                      itemBuilder: (context, index) {
                                                        return ConstrainedBox(
                                                          constraints: BoxConstraints(
                                                            minHeight: 15.0.w,
                                                          ),
                                                          child: GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                /*listState.clear();
                                                                listCity.clear();*/
                                                                clickEventCountry(index);
                                                                /*Future.delayed(const Duration(milliseconds: 100), () {
                                                                  clickEventCountry(index);
                                                                });*/
                                                              });
                                                            },
                                                            child: Container(
                                                              margin: EdgeInsets.fromLTRB(3.0.w, 3.0.w, 3.0.w, 0.0),
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(7.0),
                                                                color: listCountry[index].id == selectedCountryId ? themeYellow : testColor,
                                                              ),
                                                              child: Padding(
                                                                padding: EdgeInsets.symmetric(vertical: 3.5.w, horizontal: 3.5.w),
                                                                child: Row(
                                                                  children: <Widget>[
                                                                    Expanded(
                                                                      child: Text(
                                                                        listCountry[index].name,
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
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      });
                                }
                              },
                              child: Container(
                                color: Colors.white,
                                padding: EdgeInsets.fromLTRB(6.0.w, 4.0.w, 8.5.w, 4.0.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      selectedCountryName == '' ? 'Country' : selectedCountryName,
                                      style: TextStyle(
                                        fontFamily: 'Whitney Bold',
                                        fontSize: 15.0.sp,
                                        color: isCountrySelected ? Colors.black : Color(0xFFBDBFCA),
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
                                if (selectedCountryId == 0) {
                                  scaffoldState.currentState.showSnackBar(
                                    SnackBar(
                                      content: Text(countryMsg),
                                      duration: Duration(seconds: 5),
                                    ),
                                  );
                                } else {
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
                                                              'State',
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
                                                    child: ListView.builder(
                                                      itemCount: listState.length,
                                                      itemBuilder: (context, index) {
                                                        return ConstrainedBox(
                                                          constraints: BoxConstraints(
                                                            minHeight: 15.0.w,
                                                          ),
                                                          child: GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                clickEventState(index);
                                                              });
                                                            },
                                                            child: Container(
                                                              margin: EdgeInsets.fromLTRB(3.0.w, 3.0.w, 3.0.w, 0.0),
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(7.0),
                                                                color: listState[index].id == selectedStateId ? themeYellow : testColor,
                                                              ),
                                                              child: Padding(
                                                                padding: EdgeInsets.symmetric(vertical: 3.5.w, horizontal: 3.5.w),
                                                                child: Row(
                                                                  children: <Widget>[
                                                                    Expanded(
                                                                      child: Text(
                                                                        listState[index].name,
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
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      });
                                }
                              },
                              child: Container(
                                color: Colors.white,
                                padding: EdgeInsets.fromLTRB(6.0.w, 4.0.w, 8.5.w, 4.0.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      selectedStateName == '' ? 'State' : selectedStateName,
                                      style: TextStyle(
                                        fontFamily: 'Whitney Bold',
                                        fontSize: 15.0.sp,
                                        color: isStateSelected ? Colors.black : Color(0xFFBDBFCA),
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
                                if (selectedStateId == 0) {
                                  scaffoldState.currentState.showSnackBar(
                                    SnackBar(
                                      content: Text(stateMsg),
                                      duration: Duration(seconds: 5),
                                    ),
                                  );
                                } else {
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
                                                              'City',
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
                                                    child: ListView.builder(
                                                      itemCount: listCity.length,
                                                      itemBuilder: (context, index) {
                                                        return ConstrainedBox(
                                                          constraints: BoxConstraints(
                                                            minHeight: 15.0.w,
                                                          ),
                                                          child: GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                clickEventCity(index);
                                                              });
                                                            },
                                                            child: Container(
                                                              margin: EdgeInsets.fromLTRB(3.0.w, 3.0.w, 3.0.w, 0.0),
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(7.0),
                                                                color: listCity[index].id == selectedCityId ? themeYellow : testColor,
                                                                // color: Colors.teal,
                                                              ),
                                                              child: Padding(
                                                                padding: EdgeInsets.symmetric(vertical: 3.5.w, horizontal: 3.5.w),
                                                                child: Row(
                                                                  children: <Widget>[
                                                                    Expanded(
                                                                      child: Text(
                                                                        listCity[index].name,
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
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      });
                                }
                              },
                              child: Container(
                                color: Colors.white,
                                padding: EdgeInsets.fromLTRB(6.0.w, 4.0.w, 8.5.w, 4.0.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      selectedCityName == '' ? 'City' : selectedCityName,
                                      style: TextStyle(
                                        fontFamily: 'Whitney Bold',
                                        fontSize: 15.0.sp,
                                        color: isCitySelected ? Colors.black : Color(0xFFBDBFCA),
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
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 6.0.w),
                              child: TextField(
                                controller: zipCodeController,
                                enabled: isEditable,
                                style: kLableSignUpTextStyle,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Zipcode',
                                  hintStyle: kLableSignUpHintStyle,
                                ),
                                textInputAction: TextInputAction.next,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(6.0.w, 1.0.w, 6.0.w, 15.0.w),
                              child: Divider(
                                height: 5.0,
                                color: Colors.black87,
                              ),
                            ),
                            Visibility(
                              visible: isEditable ? true : false,
                              child: Container(
                                // height: 100.0,
                                width: double.infinity,
                                // color: Colors.teal,
                                margin: EdgeInsets.symmetric(vertical: 10.0.w, horizontal: 25.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      'Update',
                                      style: kButtonLabelTextStyle,
                                    ),
                                    RoundIconButton(
                                      icon: FontAwesomeIcons.arrowRight,
                                      onPressed: () async {
                                        print('Clicked on update button');
                                        checkForValidations();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
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

  void clickEventOrgSize(int index) {
    setState(() {
      strOrgSize = '';
      strOrgSize = orgSizeList[index].toString();
      Navigator.pop(context);
      FocusManager.instance.primaryFocus.unfocus();
    });
  }

  void clickEventJobTitle(int index) {
    setState(() {
      strJobTitleName = list_job_title[index].name;
      jobTitleId = list_job_title[index].id;
      isJobTitleSelected = true;
      Navigator.pop(context);
      FocusManager.instance.primaryFocus.unfocus();
    });
  }

  void clickEventIndustry(int index) {
    setState(() {
      industryName = list_industries[index].name;
      industryId = list_industries[index].id;
      isIndustrySelected = true;
      Navigator.pop(context);
      FocusManager.instance.primaryFocus.unfocus();
    });
  }

  void clickForProfCreds(int index) {
    setState(() {
      if (list_profcreds[index].isSelected) {
        list_profcreds[index].isSelected = false;
        smallTitles.remove(list_profcreds[index].shortTitle.toString());
        smallTitlesId.remove(list_profcreds[index].id.toString());
      } else {
        list_profcreds[index].isSelected = true;
        smallTitles.add(list_profcreds[index].shortTitle.toString());
        smallTitlesId.add(list_profcreds[index].id.toString());
      }
      FocusManager.instance.primaryFocus.unfocus();
    });
  }

  void clickEventCountry(int index) {
    setState(() {
      selectedCountryName = listCountry[index].name;
      selectedCountryId = listCountry[index].id;
      isCountrySelected = true;
      isStateSelected = false;
      isCitySelected = false;
      selectedStateName = '';
      selectedCityName = '';
      selectedStateId = 0;
      selectedCityId = 0;

      if (listState != null) {
        listState.clear();
      }
      if (listCity != null) {
        listCity.clear();
      }

      FocusManager.instance.primaryFocus.unfocus();

      isLoaderShowing = true;

      getStateNameListAPI(selectedCountryId);
      Navigator.pop(context);
    });
  }

  void clickEventState(int index) {
    setState(() {
      selectedStateName = listState[index].name;
      selectedStateId = listState[index].id;
      isCountrySelected = true;
      isStateSelected = true;
      isCitySelected = false;
      selectedCityName = '';
      selectedCityId = 0;

      FocusManager.instance.primaryFocus.unfocus();

      if (listCity != null) {
        listCity.clear();
      }

      isLoaderShowing = true;

      getCityNameListAPI(selectedStateId);
      Navigator.pop(context);
    });
  }

  void clickEventCity(int index) {
    setState(() {
      selectedCityName = listCity[index].name;
      selectedCityId = listCity[index].id;
      isCountrySelected = true;
      isStateSelected = true;
      isCitySelected = true;
      Navigator.pop(context);

      FocusManager.instance.primaryFocus.unfocus();
    });
  }

  void checkForValidations() {
    if (fnameController.text == '' || fnameController.text.length == 0) {
      print('Validation failed for fName');
      scaffoldState.currentState.showSnackBar(
        SnackBar(
          content: Text(fnameEmptyMsg),
          duration: Duration(seconds: 3),
        ),
      );
    } else if (lnameController.text == '' || lnameController.text.length == 0) {
      print('Validation failed for lName');
      scaffoldState.currentState.showSnackBar(
        SnackBar(
          content: Text(lnameEmptyMsg),
          duration: Duration(seconds: 3),
        ),
      );
    } else if (phoneController.text == '' || phoneController.text.length == 0) {
      print('Validation failed for empty phone');
      scaffoldState.currentState.showSnackBar(
        SnackBar(
          content: Text(phoneEmptyMsg),
          duration: Duration(seconds: 3),
        ),
      );
    } else if (phoneController.text.trim().length < 10 || phoneController.text.trim().length > 10) {
      print('Validation failed for invalid length phone');
      scaffoldState.currentState.showSnackBar(
        SnackBar(
          content: Text(phoneLengthMsg),
          duration: Duration(seconds: 3),
        ),
      );
    } else if (companyNameController.text == '' || companyNameController.text.length == 0) {
      print('Validation failed for company');
      scaffoldState.currentState.showSnackBar(
        SnackBar(
          content: Text(companyEmptyMsg),
          duration: Duration(seconds: 3),
        ),
      );
    } else if (strOrgSize == '' || strOrgSize.length == 0) {
      print('Validation failed for organization size');
      scaffoldState.currentState.showSnackBar(
        SnackBar(
          content: Text(selectOrganizationSizeMsg),
          duration: Duration(seconds: 3),
        ),
      );
    } else if (strJobTitleName == '' || strJobTitleName.length == 0) {
      print('Validation failed for job title');
      scaffoldState.currentState.showSnackBar(
        SnackBar(
          content: Text(selectJobTitleMsg),
          duration: Duration(seconds: 3),
        ),
      );
    } else if (industryName == '' || industryName.length == 0) {
      print('Validation failed for industry');
      scaffoldState.currentState.showSnackBar(
        SnackBar(
          content: Text(selectIndustryMsg),
          duration: Duration(seconds: 3),
        ),
      );
    } else if (smallTitles.length == 0) {
      print('Validation failed for prof creds');
      scaffoldState.currentState.showSnackBar(
        SnackBar(
          content: Text(selectPrefCredsMsg),
          duration: Duration(seconds: 3),
        ),
      );
    } else if (ptinController.text.length > 8) {
      print('Validation failed for ptin');
      scaffoldState.currentState.showSnackBar(
        SnackBar(
          content: Text(ptinLenght),
          duration: Duration(seconds: 3),
        ),
      );
    } else if (ctecController.text.length > 6) {
      print('Validation failed for ctec');
      scaffoldState.currentState.showSnackBar(
        SnackBar(
          content: Text(ctecLenght),
          duration: Duration(seconds: 3),
        ),
      );
    } else if (selectedCountryId == 0) {
      print('Validation failed for country');
      scaffoldState.currentState.showSnackBar(
        SnackBar(
          content: Text(countryMsg),
          duration: Duration(seconds: 3),
        ),
      );
    } else if (selectedStateId == 0) {
      print('Validation failed for state');
      scaffoldState.currentState.showSnackBar(
        SnackBar(
          content: Text(stateMsg),
          duration: Duration(seconds: 3),
        ),
      );
    } else if (selectedCityId == 0) {
      print('Validation failed for city');
      scaffoldState.currentState.showSnackBar(
        SnackBar(
          content: Text(cityMsg),
          duration: Duration(seconds: 3),
        ),
      );
    } else {
      print('Validation passed..');
      checkForInternet();
    }
  }

  void checkForInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if ((connectivityResult == ConnectivityResult.mobile) || (connectivityResult == ConnectivityResult.wifi)) {
      setState(() {
        // strPTIN = 'P$strPTIN';
        strPTIN = 'P-${ptinController.text}';
        // strCTEC = 'A$strCTEC';
        strCTEC = 'A${ctecController.text}';
        for (int i = 0; i < smallTitlesId.length; i++) {
          // print('SmallTitleIds : ${ConstSignUp.smallTitlesId.toString()}');
          if (i == 0) {
            user_type_ids = smallTitlesId[i].toString();
          } else {
            user_type_ids = user_type_ids + ',' + smallTitlesId[i].toString();
          }
        }
      });
      isLoaderShowing = true;
      print('Edit Profile FName : ${fnameController.text.toString()}');
      print('Edit Profile LName : ${lnameController.text.toString()}');
      print('Edit Profile CountryID : ${selectedCountryId.toString()}');
      print('Edit Profile StateID : ${selectedStateId.toString()}');
      print('Edit Profile CityID : ${selectedCityId.toString()}');
      print('Edit Profile Company Name : ${companyNameController.text.toString()}');
      print('Edit Profile Mobile Number : ${mobileController.text.toString()}');
      print('Edit Profile Phone Number : ${phoneController.text.toString()}');
      print('Edit Profile ZipCode : ${zipCodeController.text.toString()}');
      print('Edit Profile PTIN : ${strPTIN}');
      print('Edit Profile CTEC : ${strCTEC}');
      print('Edit Profile Org Size : ${strOrgSize}');
      print('Edit Profile Job Title ID : ${jobTitleId.toString()}');
      print('Edit Profile Industry ID : ${industryId.toString()}');
      print('Edit Profile User Type : ${user_type_ids.toString()}');
      EditProfileCall();
    } else {
      scaffoldState.currentState.showSnackBar(
        SnackBar(
          content: Text("Please check your internet connectivity and try again"),
          duration: Duration(seconds: 5),
        ),
      );
    }
  }

  Future<String> EditProfileCall() async {
    // String urls = 'https://my-cpe.com/api/v3/edit-profile';
    String urls = URLs.BASE_URL + 'edit-profile';

    final response = await http.post(
      urls,
      headers: {
        'Accept': 'Application/json',
        'Authorization': '$_authToken',
      },
      body: {
        'first_name': fnameController.text.toString(),
        'last_name': lnameController.text.toString(),
        // 'email': ConstSignUp.strEmail.toString(),
        // 'password': ConstSignUp.strPass.toString(),
        // 'confirm_password': ConstSignUp.strConfPass.toString(),
        'country_id': selectedCountryId.toString(),
        'state_id': selectedStateId.toString(),
        'city_id': selectedCityId.toString(),
        'firm_name': companyNameController.text.toString(),
        'contact_no': mobileController.text.toString(),
        'phone': phoneController.text.toString(),
        'zipcode': zipCodeController.text.toString(),
        'ptin': strPTIN,
        'ctec_id': strCTEC,
        'co_emp_size': strOrgSize,
        'jobtitle_id': jobTitleId.toString(),
        'industry_id': industryId.toString(),
        'professional_cred_cert': user_type_ids.toString(),
      },
    );

    this.setState(() {
      respEditProf = jsonDecode(response.body);
      isLoaderShowing = false;
    });

    setState(() {
      print('API response is : $respEditProf');
      respEditProfMessage = respEditProf['message'];
      if (respEditProf['success']) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomDialog(
                "Edit Profile",
                "$respEditProfMessage",
                "Ok",
                () {
                  updateProfile();
                },
              );
            });
        /*showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => new AlertDialog(
                title: new Text('Edit Profile', style: new TextStyle(color: Colors.black, fontSize: 20.0)),
                content: new Text(respEditProfMessage),
                actions: <Widget>[
                  new FlatButton(
                    onPressed: () => setState(() {
                      updateProfile();

                      */ /*Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => IntroScreen(),
                        ),
                      );*/ /*
                    }), // this line dismisses the dialog
                    child: new Text('Ok', style: new TextStyle(fontSize: 18.0)),
                  )
                ],
              ),
            ) ??
            false;*/
      } else {
        scaffoldState.currentState.showSnackBar(
          SnackBar(
            content: Text(respEditProfMessage),
            duration: Duration(seconds: 3),
          ),
        );
      }
    });

    return 'Success';
  }

  void updateProfile() async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("spFName", fnameController.text.toString());
    sharedPreferences.setString("spLName", lnameController.text.toString());
    sharedPreferences.commit();

    // isEditable = false;
    Navigator.pop(context);
  }
}
