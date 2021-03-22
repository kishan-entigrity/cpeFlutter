import 'package:connectivity/connectivity.dart';
import 'package:cpe_flutter/components/SpinKitSample1.dart';
import 'package:cpe_flutter/components/TopBar.dart';
import 'package:cpe_flutter/components/round_icon_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../constant.dart';
import '../../rest_api.dart';

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

  bool isLoaderShowing = false;

  var respStatus;
  var respMessage;

  int arrCountCountry = 0;
  int arrCountState = 0;
  int arrCountCity = 0;

  var respCountry;
  var respState;
  var respCity;

  var selectedCountryName = '';
  var selectedStateName = '';
  var selectedCityName = '';

  var selectedCountryId = 0;
  var selectedStateId = 0;
  var selectedCityId = 0;

  bool isCountrySelected = false;
  bool isStateSelected = false;
  bool isCitySelected = false;

  bool isTermsAccepted = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCountryListAPI();
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
                                    child: Text(
                                      'PTIN',
                                      style: kLableSignUpHintLableStyle,
                                    ),
                                    margin: EdgeInsets.only(left: 6.0.w, right: 6.0.w, top: 20.0.w),
                                  ),
                                  Container(
                                    // margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 6.0.w),
                                    margin: EdgeInsets.only(left: 6.0.w, right: 6.0.w, top: 0.0.w),
                                    child: TextField(
                                      controller: ptinController,
                                      style: kLableSignUpTextStyle,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'PTIN',
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
                                    margin: EdgeInsets.only(left: 6.0.w, right: 6.0.w, top: 2.0.w),
                                    child: Text(
                                      'CTEC ID',
                                      style: kLableSignUpHintLableStyle,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 6.0.w),
                                    child: TextField(
                                      controller: ctecController,
                                      style: kLableSignUpTextStyle,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'CTEC ID',
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
                                    margin: EdgeInsets.only(left: 6.0.w, right: 6.0.w, top: 2.0.w),
                                    child: Text(
                                      'CFP ID',
                                      style: kLableSignUpHintLableStyle,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 6.0.w),
                                    child: TextField(
                                      controller: cfpController,
                                      style: kLableSignUpTextStyle,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'CFP ID',
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
                                      scaffoldState.currentState.showBottomSheet(
                                        (context) => Container(
                                          color: Colors.white,
                                          height: 70.0.h,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              // color: Colors.grey[900],
                                              color: Colors.white,
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
                                                        width: 20.0.w,
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
                                                Container(
                                                  height: 0.5,
                                                  color: Colors.black45,
                                                ),
                                                // TopBar(Colors.white, 'Country'),
                                                Expanded(
                                                  child: ListView.builder(
                                                    itemCount: arrCountCountry,
                                                    itemBuilder: (context, index) {
                                                      return GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            selectedCountryName = respCountry['payload']['country'][index]['name'];
                                                            selectedCountryId = respCountry['payload']['country'][index]['id'];
                                                            isCountrySelected = true;
                                                            isStateSelected = false;
                                                            isCitySelected = false;
                                                            selectedStateName = '';
                                                            selectedCityName = '';
                                                            selectedStateId = 0;
                                                            selectedCityId = 0;

                                                            getStateNameApi(selectedCountryId);
                                                            Navigator.pop(context);
                                                          });
                                                        },
                                                        child: Container(
                                                          margin: EdgeInsets.fromLTRB(3.0.w, 3.0.w, 3.0.w, 0.0),
                                                          height: 12.0.w,
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(7.0),
                                                            color: Color(0xF0F3F5F9),
                                                            // color: Colors.blueGrey,
                                                          ),
                                                          child: Container(
                                                            padding: EdgeInsets.only(left: 3.5.w, top: 3.5.w),
                                                            child: Text(
                                                              '${respCountry['payload']['country'][index]['name']}',
                                                              textAlign: TextAlign.start,
                                                              style: kDataSingleSelectionBottomNav,
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
                                        ),
                                      );
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
                                        scaffoldState.currentState.showBottomSheet(
                                          (context) => Container(
                                            color: Colors.white,
                                            height: 70.0.h,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                // color: Colors.grey[900],
                                                color: Colors.white,
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
                                                          width: 20.0.w,
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
                                                  Container(
                                                    height: 0.5,
                                                    color: Colors.black45,
                                                  ),
                                                  // TopBar(Colors.white, 'Country'),
                                                  Expanded(
                                                    child: ListView.builder(
                                                      itemCount: arrCountState,
                                                      itemBuilder: (context, index) {
                                                        return GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              selectedStateName = respState['payload']['state'][index]['name'];
                                                              selectedStateId = respState['payload']['state'][index]['id'];
                                                              isCountrySelected = true;
                                                              isStateSelected = true;
                                                              isCitySelected = false;
                                                              selectedCityName = '';
                                                              selectedCityId = 0;

                                                              getCityNameApi(selectedStateId);
                                                              Navigator.pop(context);
                                                            });
                                                          },
                                                          child: Container(
                                                            margin: EdgeInsets.fromLTRB(3.0.w, 3.0.w, 3.0.w, 0.0),
                                                            height: 12.0.w,
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(7.0),
                                                              color: Color(0xF0F3F5F9),
                                                              // color: Colors.blueGrey,
                                                            ),
                                                            child: Container(
                                                              padding: EdgeInsets.only(left: 3.5.w, top: 3.5.w),
                                                              child: Text(
                                                                '${respState['payload']['state'][index]['name']}',
                                                                textAlign: TextAlign.start,
                                                                style: kDataSingleSelectionBottomNav,
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
                                          ),
                                        );
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
                                        scaffoldState.currentState.showBottomSheet(
                                          (context) => Container(
                                            color: Colors.white,
                                            height: 70.0.h,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                // color: Colors.grey[900],
                                                color: Colors.white,
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
                                                          width: 20.0.w,
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
                                                  Container(
                                                    height: 0.5,
                                                    color: Colors.black45,
                                                  ),
                                                  // TopBar(Colors.white, 'Country'),
                                                  Expanded(
                                                    child: ListView.builder(
                                                      itemCount: arrCountCity,
                                                      itemBuilder: (context, index) {
                                                        return GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              selectedCityName = respCity['payload']['city'][index]['name'];
                                                              selectedCityId = respCity['payload']['city'][index]['id'];
                                                              isCountrySelected = true;
                                                              isStateSelected = true;
                                                              isCitySelected = true;
                                                              Navigator.pop(context);
                                                            });
                                                          },
                                                          child: Container(
                                                            margin: EdgeInsets.fromLTRB(3.0.w, 3.0.w, 3.0.w, 0.0),
                                                            height: 12.0.w,
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(7.0),
                                                              color: Color(0xF0F3F5F9),
                                                              // color: Colors.blueGrey,
                                                            ),
                                                            child: Container(
                                                              padding: EdgeInsets.only(left: 3.5.w, top: 3.5.w),
                                                              child: Text(
                                                                '${respCity['payload']['city'][index]['name']}',
                                                                textAlign: TextAlign.start,
                                                                style: kDataSingleSelectionBottomNav,
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
                                          ),
                                        );
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
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    // SignUpScreen2(),
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

  void getCountryListAPI() async {
    isLoaderShowing = true;
    var connectivityResult = await (Connectivity().checkConnectivity());
    print('Connectivity Result is : $connectivityResult');

    if ((connectivityResult == ConnectivityResult.mobile) || (connectivityResult == ConnectivityResult.wifi)) {
      respCountry = await getCountryList();
      print('Response for Country list api is : $respCountry');

      respStatus = respCountry['success'];
      respMessage = respCountry['message'];
      isLoaderShowing = false;
      if (respStatus) {
        // Do something to load data for country list from here..
        setState(() {
          arrCountCountry = respCountry['payload']['country'].length;
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

  void getStateNameApi(int selectedCountryId) async {
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
  }

  void getCityNameApi(int selectedStateId) async {
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
  }
}
