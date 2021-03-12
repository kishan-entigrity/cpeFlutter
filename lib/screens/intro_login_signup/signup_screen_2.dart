import 'package:connectivity/connectivity.dart';
import 'package:cpe_flutter/components/SpinKitSample1.dart';
import 'package:cpe_flutter/components/TopBar.dart';
import 'package:cpe_flutter/components/round_icon_button.dart';
import 'package:cpe_flutter/screens/intro_login_signup/hashmap.dart';
import 'package:cpe_flutter/screens/intro_login_signup/signup_screen_3.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../constant.dart';
import '../../rest_api.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Take API calls for the JobTitle, industry, Professional creds, Additional qualifications in serial manner..
    getProfCredsAPI();
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
                                    margin: EdgeInsets.only(left: 6.0.w, right: 6.0.w, top: 20.0.w),
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
                                    margin: EdgeInsets.fromLTRB(6.0.w, 1.0.w, 6.0.w, 0),
                                    child: Divider(
                                      height: 5.0,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      color: Colors.white,
                                      padding: EdgeInsets.fromLTRB(6.0.w, 4.0.w, 8.5.w, 4.0.w),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            isOrganizationSizeSelected ? organizationSize : 'Organization Size',
                                            style: TextStyle(
                                              fontFamily: 'Whitney Bold',
                                              fontSize: 15.0.sp,
                                              color: isOrganizationSizeSelected ? Colors.black : Color(0xFFBDBFCA),
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
                                    color: Colors.white,
                                    padding: EdgeInsets.fromLTRB(6.0.w, 4.0.w, 8.5.w, 4.0.w),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          isJobTitleSelected ? jobTitle : 'Job Title/Designation',
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
                                  Container(
                                    margin: EdgeInsets.fromLTRB(6.0.w, 0, 6.0.w, 0),
                                    child: Divider(
                                      height: 5.0,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  Container(
                                    color: Colors.white,
                                    padding: EdgeInsets.fromLTRB(6.0.w, 4.0.w, 8.5.w, 4.0.w),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          isIndustrySelected ? industry : 'Industry',
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
                                                                    var profId = respProfCreds['payload']['user_type'][index]['id'];
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
                                                                        mapProfCredsName[profId] =
                                                                            respProfCreds['payload']['user_type'][index]['title'];
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
                                  ),
                                  Container(
                                    color: Colors.white,
                                    padding: EdgeInsets.fromLTRB(6.0.w, 4.0.w, 8.5.w, 4.0.w),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          'Additional Qualifications',
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
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => HashMapSample(),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            // 'Next',
                                            'Step 2/3',
                                            // style: kButtonLabelTextStyle,
                                            style: kStepText,
                                          ),
                                        ),
                                        RoundIconButton(
                                          icon: FontAwesomeIcons.arrowRight,
                                          onPressed: () async {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => SignUpScreen3(),
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
        scaffoldState.currentState.showSnackBar(
          SnackBar(
            content: Text('$respMessage'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } else {
      scaffoldState.currentState.showSnackBar(
        SnackBar(
          content: Text("Please check your internet connectivity and try again"),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
}
