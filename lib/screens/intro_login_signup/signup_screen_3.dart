import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:cpe_flutter/components/SpinKitSample1.dart';
import 'package:cpe_flutter/components/round_icon_button.dart';
import 'package:cpe_flutter/const_signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';

import '../../constant.dart';
import '../../rest_api.dart';
import 'intro_screen.dart';
import 'model/city_list_model.dart';
import 'model/country_list_model.dart';
import 'model/state_list_model.dart';

class SignUpScreen3 extends StatefulWidget {
  @override
  _SignUpScreen3State createState() => _SignUpScreen3State();
}

class _SignUpScreen3State extends State<SignUpScreen3> {
  final scaffoldState = GlobalKey<ScaffoldState>();

  TextEditingController ptinController = TextEditingController();
  TextEditingController ctecController = TextEditingController();
  TextEditingController cfpController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();

  // var strPTIN = '';
  // var strCTEC = '';
  // var strCFP = '';
  // var strZipCode = '';

  bool isLoaderShowing = false;

  var respStatus;
  var respMessage;

  var respRegistration;
  var respRegistrationStatus;
  var respRegistrationMessage;

  // List<Country> listCountry;
  // int arrCountCountry = 0;
  // var respCountry;
  // var respCountryData;
  // var selectedCountryName = '';
  // var selectedCountryId = 0;
  // bool isCountrySelected = false;

  // List<State_Name> listState;
  // int arrCountState = 0;
  // var respState;
  // var respStateData;
  // var selectedStateName = '';
  // var selectedStateId = 0;
  // bool isStateSelected = false;

  // List<City> listCity;
  // int arrCountCity = 0;
  // var respCity;
  // var respCityData;
  // var selectedCityName = '';
  // var selectedCityId = 0;
  // bool isCitySelected = false;

  bool isTermsAccepted = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkInternetConnection();
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
                      Row(
                        children: <Widget>[
                          // BackIcon(),
                          GestureDetector(
                            onTap: () {
                              ConstSignUp.strPTIN = ptinController.text;
                              ConstSignUp.strCTEC = ctecController.text;
                              ConstSignUp.strCFP = cfpController.text;
                              ConstSignUp.strZipCode = zipCodeController.text;
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
                                    child: Text(
                                      'PTIN',
                                      style: kLableSignUpHintLableStyle,
                                    ),
                                    margin: EdgeInsets.only(left: 6.0.w, right: 6.0.w, top: 20.0.w),
                                  ),
                                  Container(
                                    // margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 6.0.w),
                                    margin: EdgeInsets.only(left: 6.0.w, right: 6.0.w, top: 0.0.w),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          'P',
                                          style: kLableSignUpTextStyle,
                                        ),
                                        Expanded(
                                          child: TextField(
                                            controller: ptinController,
                                            // maxLength: 8,
                                            style: kLableSignUpTextStyle,
                                            decoration: InputDecoration(
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
                                        Text(
                                          'A',
                                          style: kLableSignUpTextStyle,
                                        ),
                                        Expanded(
                                          child: TextField(
                                            controller: ctecController,
                                            // maxLength: 6,
                                            keyboardType: TextInputType.number,
                                            style: kLableSignUpTextStyle,
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
                                                          itemCount: ConstSignUp.listCountry.length,
                                                          itemBuilder: (context, index) {
                                                            return ConstrainedBox(
                                                              constraints: BoxConstraints(
                                                                minHeight: 15.0.w,
                                                              ),
                                                              child: GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    clickEventCountry(index);
                                                                  });
                                                                },
                                                                child: Container(
                                                                  margin: EdgeInsets.fromLTRB(3.0.w, 3.0.w, 3.0.w, 0.0),
                                                                  decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(7.0),
                                                                    color: ConstSignUp.listCountry[index].name == ConstSignUp.selectedCountryName
                                                                        ? themeYellow
                                                                        : testColor,
                                                                  ),
                                                                  child: Padding(
                                                                    padding: EdgeInsets.symmetric(vertical: 3.5.w, horizontal: 3.5.w),
                                                                    child: Row(
                                                                      children: <Widget>[
                                                                        Expanded(
                                                                          child: Text(
                                                                            ConstSignUp.listCountry[index].name,
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
                                    },
                                    child: Container(
                                      color: Colors.white,
                                      padding: EdgeInsets.fromLTRB(6.0.w, 4.0.w, 8.5.w, 4.0.w),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            ConstSignUp.selectedCountryName == '' ? 'Country' : ConstSignUp.selectedCountryName,
                                            style: TextStyle(
                                              fontFamily: 'Whitney Bold',
                                              fontSize: 15.0.sp,
                                              color: ConstSignUp.isCountrySelected ? Colors.black : Color(0xFFBDBFCA),
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
                                      if (ConstSignUp.selectedCountryId == 0) {
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
                                                            itemCount: ConstSignUp.listState.length,
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
                                                                      color: ConstSignUp.listState[index].name == ConstSignUp.selectedStateName
                                                                          ? themeYellow
                                                                          : testColor,
                                                                    ),
                                                                    child: Padding(
                                                                      padding: EdgeInsets.symmetric(vertical: 3.5.w, horizontal: 3.5.w),
                                                                      child: Row(
                                                                        children: <Widget>[
                                                                          Expanded(
                                                                            child: Text(
                                                                              ConstSignUp.listState[index].name,
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
                                            ConstSignUp.selectedStateName == '' ? 'State' : ConstSignUp.selectedStateName,
                                            style: TextStyle(
                                              fontFamily: 'Whitney Bold',
                                              fontSize: 15.0.sp,
                                              color: ConstSignUp.isStateSelected ? Colors.black : Color(0xFFBDBFCA),
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
                                      if (ConstSignUp.selectedStateId == 0) {
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
                                                            itemCount: ConstSignUp.listCity.length,
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
                                                                      color: ConstSignUp.listCity[index].name == ConstSignUp.selectedCityName
                                                                          ? themeYellow
                                                                          : testColor,
                                                                    ),
                                                                    child: Padding(
                                                                      padding: EdgeInsets.symmetric(vertical: 3.5.w, horizontal: 3.5.w),
                                                                      child: Row(
                                                                        children: <Widget>[
                                                                          Expanded(
                                                                            child: Text(
                                                                              ConstSignUp.listCity[index].name,
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
                                            ConstSignUp.selectedCityName == '' ? 'City' : ConstSignUp.selectedCityName,
                                            style: TextStyle(
                                              fontFamily: 'Whitney Bold',
                                              fontSize: 15.0.sp,
                                              color: ConstSignUp.isCitySelected ? Colors.black : Color(0xFFBDBFCA),
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
                                    margin: EdgeInsets.fromLTRB(6.0.w, 1.0.w, 6.0.w, 0),
                                    child: Divider(
                                      height: 5.0,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(6.0.w, 10.0.w, 6.0.w, 0),
                                    child: Row(
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              isTermsAccepted ? isTermsAccepted = false : isTermsAccepted = true;
                                            });
                                          },
                                          child: Icon(
                                            isTermsAccepted ? FontAwesomeIcons.checkSquare : FontAwesomeIcons.square,
                                          ),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            style: TextStyle(
                                              fontFamily: 'Whitney Bold',
                                              fontSize: 13.0.sp,
                                              color: Color(0xFFBDBFCA),
                                            ),
                                            children: <TextSpan>[
                                              TextSpan(text: '  I accept these'),
                                              TextSpan(
                                                text: ' Terms and Conditions',
                                                style: TextStyle(
                                                  fontFamily: 'Whitney Bold',
                                                  fontSize: 13.0.sp,
                                                  color: Color(0xFF0F2138),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0.w,
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(6.0.w, 0, 6.0.w, 0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          'SignUp',
                                          style: kButtonLabelTextStyle,
                                        ),
                                        RoundIconButton(
                                          icon: FontAwesomeIcons.arrowRight,
                                          onPressed: () async {
                                            ConstSignUp.strPTIN = ptinController.text;
                                            ConstSignUp.strCTEC = ctecController.text;
                                            ConstSignUp.strCFP = cfpController.text;
                                            ConstSignUp.strZipCode = zipCodeController.text;

                                            checkForValidations();
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

  void checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if ((connectivityResult == ConnectivityResult.mobile) || (connectivityResult == ConnectivityResult.wifi)) {
      setState(() {
        isLoaderShowing = true;
      });
      getCountryListAPI();
    } else {
      scaffoldState.currentState.showSnackBar(
        SnackBar(
          content: Text("Please check your internet connectivity and try again"),
          duration: Duration(seconds: 3),
        ),
      );
    }
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
      ConstSignUp.respCountry = jsonDecode(response.body);
      isLoaderShowing = false;
    });

    setState(() {
      print('API response is : ${ConstSignUp.respCountry}');
      ConstSignUp.arrCountCountry = ConstSignUp.respCountry['payload']['country'].length;
      ConstSignUp.respCountryData = ConstSignUp.respCountry['payload']['country'];
      print('Size for array is : ${ConstSignUp.respCountryData}');
    });

    if (ConstSignUp.listCountry != null && ConstSignUp.listCountry.isNotEmpty) {
      ConstSignUp.listCountry.addAll(List.from(ConstSignUp.respCountryData).map<Country>((item) => Country.fromJson(item)).toList());
    } else {
      ConstSignUp.listCountry = List.from(ConstSignUp.respCountryData).map<Country>((item) => Country.fromJson(item)).toList();
    }

    print('Size for the list is : ${ConstSignUp.listCountry.length}');
    return ConstSignUp.listCountry;
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
      ConstSignUp.respState = jsonDecode(response.body);
      isLoaderShowing = false;
    });

    setState(() {
      print('API response is : ${ConstSignUp.respState}');
      ConstSignUp.arrCountState = ConstSignUp.respState['payload']['state'].length;
      ConstSignUp.respStateData = ConstSignUp.respState['payload']['state'];
      print('Size for array is : ${ConstSignUp.respStateData}');
    });

    if (ConstSignUp.listState != null && ConstSignUp.listState.isNotEmpty) {
      ConstSignUp.listState.addAll(List.from(ConstSignUp.respStateData).map<State_Name>((item) => State_Name.fromJson(item)).toList());
    } else {
      ConstSignUp.listState = List.from(ConstSignUp.respStateData).map<State_Name>((item) => State_Name.fromJson(item)).toList();
    }

    print('Size for the list is : ${ConstSignUp.listState.length}');
    return ConstSignUp.listState;
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
      ConstSignUp.respCity = jsonDecode(response.body);
      isLoaderShowing = false;
    });

    setState(() {
      print('API response is : ${ConstSignUp.respCity}');
      ConstSignUp.arrCountCity = ConstSignUp.respCity['payload']['city'].length;
      ConstSignUp.respCityData = ConstSignUp.respCity['payload']['city'];
      print('Size for array is : ${ConstSignUp.respStateData}');
    });

    if (ConstSignUp.listCity != null && ConstSignUp.listCity.isNotEmpty) {
      ConstSignUp.listCity.addAll(List.from(ConstSignUp.respCityData).map<City>((item) => City.fromJson(item)).toList());
    } else {
      ConstSignUp.listCity = List.from(ConstSignUp.respCityData).map<City>((item) => City.fromJson(item)).toList();
    }

    print('Size for the list is : ${ConstSignUp.listState.length}');
    return ConstSignUp.listCity;
  }

  /*void getStateNameApi(int selectedCountryId) async {
    isLoaderShowing = true;
    print('Selected Country ID : $selectedCountryId');

    var connectivityResult = await (Connectivity().checkConnectivity());
    if ((connectivityResult == ConnectivityResult.mobile) || (connectivityResult == ConnectivityResult.wifi)) {
      respState = await getStateList(selectedCountryId.toString());
      print('Response for State list api is : $respState');

      respStatus = respState['success'];
      respMessage = respState['message'];
      isLoaderShowing = false;

      if (respStatus) {
        // Do something to load data for country list from here..
        setState(() {
          arrCountState = respState['payload']['state'].length;
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
  }*/

  /*void getCityNameApi(int selectedStateId) async {
    isLoaderShowing = true;
    var connectivityResult = await (Connectivity().checkConnectivity());
    if ((connectivityResult == ConnectivityResult.mobile) || (connectivityResult == ConnectivityResult.wifi)) {
      respCity = await getCityList(selectedStateId.toString());
      print('Response for City list api is : $respCity');

      respStatus = respCity['success'];
      respMessage = respCity['message'];
      isLoaderShowing = false;

      if (respStatus) {
        // Do something to load data for country list from here..
        setState(() {
          arrCountCity = respCity['payload']['city'].length;
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
  }*/

  void clickEventCountry(int index) {
    setState(() {
      ConstSignUp.selectedCountryName = ConstSignUp.listCountry[index].name;
      ConstSignUp.selectedCountryId = ConstSignUp.listCountry[index].id;
      ConstSignUp.isCountrySelected = true;
      ConstSignUp.isStateSelected = false;
      ConstSignUp.isCitySelected = false;
      ConstSignUp.selectedStateName = '';
      ConstSignUp.selectedCityName = '';
      ConstSignUp.selectedStateId = 0;
      ConstSignUp.selectedCityId = 0;

      FocusManager.instance.primaryFocus.unfocus();

      getStateNameListAPI(ConstSignUp.selectedCountryId);
      Navigator.pop(context);
    });
  }

  void clickEventState(int index) {
    setState(() {
      ConstSignUp.selectedStateName = ConstSignUp.listState[index].name;
      ConstSignUp.selectedStateId = ConstSignUp.listState[index].id;
      ConstSignUp.isCountrySelected = true;
      ConstSignUp.isStateSelected = true;
      ConstSignUp.isCitySelected = false;
      ConstSignUp.selectedCityName = '';
      ConstSignUp.selectedCityId = 0;

      FocusManager.instance.primaryFocus.unfocus();

      getCityNameListAPI(ConstSignUp.selectedStateId);
      Navigator.pop(context);
    });
  }

  void clickEventCity(int index) {
    setState(() {
      ConstSignUp.selectedCityName = ConstSignUp.listCity[index].name;
      ConstSignUp.selectedCityId = ConstSignUp.listCity[index].id;
      ConstSignUp.isCountrySelected = true;
      ConstSignUp.isStateSelected = true;
      ConstSignUp.isCitySelected = true;
      Navigator.pop(context);

      FocusManager.instance.primaryFocus.unfocus();
    });
  }

  void checkForValidations() {
    if (ConstSignUp.strPTIN.length > 8) {
      scaffoldState.currentState.showSnackBar(
        SnackBar(
          content: Text(ptinLenght),
          duration: Duration(seconds: 3),
        ),
      );
    } else if (ConstSignUp.strCTEC.length > 6) {
      scaffoldState.currentState.showSnackBar(
        SnackBar(
          content: Text(ctecLenght),
          duration: Duration(seconds: 3),
        ),
      );
    } else if (ConstSignUp.selectedCountryId == 0) {
      scaffoldState.currentState.showSnackBar(
        SnackBar(
          content: Text(countryMsg),
          duration: Duration(seconds: 3),
        ),
      );
    } else if (ConstSignUp.selectedStateId == 0) {
      scaffoldState.currentState.showSnackBar(
        SnackBar(
          content: Text(stateMsg),
          duration: Duration(seconds: 3),
        ),
      );
    } else if (ConstSignUp.selectedCityId == 0) {
      scaffoldState.currentState.showSnackBar(
        SnackBar(
          content: Text(cityMsg),
          duration: Duration(seconds: 3),
        ),
      );
    } else if (!isTermsAccepted) {
      scaffoldState.currentState.showSnackBar(
        SnackBar(
          content: Text(termsConditionMsg),
          duration: Duration(seconds: 3),
        ),
      );
    } else {
      ConstSignUp.strPTIN = 'P' + ConstSignUp.strPTIN;
      ConstSignUp.strCTEC = 'A' + ConstSignUp.strCTEC;
      for (int i = 0; i < ConstSignUp.smallTitlesId.length; i++) {
        print('SmallTitleIds : ${ConstSignUp.smallTitlesId.toString()}');
        if (i == 0) {
          ConstSignUp.user_type_ids = ConstSignUp.smallTitlesId[i].toString();
        } else {
          ConstSignUp.user_type_ids = ConstSignUp.user_type_ids + ',' + ConstSignUp.smallTitlesId[i].toString();
        }
      }
      checkInternetRegistration();
    }
  }

  void checkInternetRegistration() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if ((connectivityResult == ConnectivityResult.mobile) || (connectivityResult == ConnectivityResult.wifi)) {
      setState(() {
        isLoaderShowing = true;
      });
      takeAPICallRegistration();
      // printData();
    } else {
      scaffoldState.currentState.showSnackBar(
        SnackBar(
          content: Text("Please check your internet connectivity and try again"),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  void printData() {
    print('First Name : ${ConstSignUp.strFname.toString()}');
    print('last_name : ${ConstSignUp.strLname.toString()}');
    print('email : ${ConstSignUp.strEmail.toString()}');
    print('password : ${ConstSignUp.strPass.toString()}');
    print('confirm_password : ${ConstSignUp.strConfPass.toString()}');
    print('country_id : ${ConstSignUp.selectedCountryId.toString()}');
    print('state_id : ${ConstSignUp.selectedStateId.toString()}');
    print('city_id : ${ConstSignUp.selectedCityId.toString()}');
    print('firm_name : ${ConstSignUp.strCompanyName.toString()}');
    print('contact_no : ${ConstSignUp.strMobile.toString()}');
    print('phone : ${ConstSignUp.strPhone.toString()}');
    print('zipcode : ${ConstSignUp.strZipCode.toString()}');
    print('ptin : ${ConstSignUp.strPTIN.toString()}');
    print('ctec : ${ConstSignUp.strCTEC.toString()}');
    print('cfp : ${ConstSignUp.strCFP.toString()}');
    print('jobtitle_id : ${ConstSignUp.jobTitleId.toString()}');
    print('industry_id : ${ConstSignUp.industryId.toString()}');
    print('user_type_id : ${ConstSignUp.user_type_ids.toString()}');
    print('device_id : aaaaaaa');
    print('device_token : asdfghjklqwertyuiooooooopzxcvbnm');
    print('device_type : A');
  }

  Future<String> takeAPICallRegistration() async {
    // String urls = 'https://my-cpe.com/api/v3/registration';
    String urls = URLs.BASE_URL + 'registration';

    final response = await http.post(
      urls,
      headers: {
        'Accept': 'Application/json',
      },
      body: {
        'first_name': ConstSignUp.strFname.toString(),
        'last_name': ConstSignUp.strLname.toString(),
        'email': ConstSignUp.strEmail.toString(),
        'password': ConstSignUp.strPass.toString(),
        'confirm_password': ConstSignUp.strConfPass.toString(),
        'country_id': ConstSignUp.selectedCountryId.toString(),
        'state_id': ConstSignUp.selectedStateId.toString(),
        'city_id': ConstSignUp.selectedCityId.toString(),
        'firm_name': ConstSignUp.strCompanyName.toString(),
        'contact_no': ConstSignUp.strMobile.toString(),
        'phone': ConstSignUp.strPhone.toString() + '-' + ConstSignUp.strExt,
        'zipcode': ConstSignUp.strZipCode.toString(),
        'ptin': ConstSignUp.strPTIN.toString(),
        'ctec_id': ConstSignUp.strCTEC.toString(),
        'co_emp_size': ConstSignUp.organizationSize.toString(),
        'jobtitle_id': ConstSignUp.jobTitleId.toString(),
        'industry_id': ConstSignUp.industryId.toString(),
        'professional_cred_cert': ConstSignUp.user_type_ids.toString(),
        'device_id': 'aaaaaaa',
        'device_token': 'asdfghjklqwertyuiooooooopzxcvbnm',
        'device_type': 'A',
      },
    );

    this.setState(() {
      respRegistration = jsonDecode(response.body);
      isLoaderShowing = false;
    });

    setState(() {
      print('API response is : $respRegistration');
      respRegistrationMessage = respRegistration['message'];
      if (respRegistration['success']) {
        showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => new AlertDialog(
                title: new Text('Registration', style: new TextStyle(color: Colors.black, fontSize: 20.0)),
                content: new Text(respRegistrationMessage),
                actions: <Widget>[
                  new FlatButton(
                    onPressed: () => setState(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => IntroScreen(),
                        ),
                      );
                    }), // this line dismisses the dialog
                    child: new Text('ok', style: new TextStyle(fontSize: 18.0)),
                  )
                ],
              ),
            ) ??
            false;
        /*scaffoldState.currentState.showSnackBar(
          SnackBar(
            content: Text(respRegistrationMessage),
            duration: Duration(seconds: 3),
          ),
        );*/
        // cleanData();
        /*ConstSignUp.cleanSignUpData();
        Future.delayed(const Duration(seconds: 3), () {
          setState(() {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => IntroScreen(),
              ),
            );
          });
        });*/
      } else {
        scaffoldState.currentState.showSnackBar(
          SnackBar(
            content: Text(respRegistrationMessage),
            duration: Duration(seconds: 3),
          ),
        );
      }
      // ConstSignUp.arrCountState = ConstSignUp.respState['payload']['state'].length;
      // ConstSignUp.respStateData = ConstSignUp.respState['payload']['state'];
      // print('Size for array is : ${ConstSignUp.respStateData}');
    });

    print('Size for the list is : ${ConstSignUp.listState.length}');
    return 'Success';
  }
}
