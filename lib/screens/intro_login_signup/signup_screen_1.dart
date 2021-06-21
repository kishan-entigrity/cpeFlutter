import 'package:connectivity/connectivity.dart';
import 'package:cpe_flutter/components/SpinKitSample1.dart';
import 'package:cpe_flutter/components/TopBar.dart';
import 'package:cpe_flutter/components/round_icon_button.dart';
import 'package:cpe_flutter/const_signup.dart';
import 'package:cpe_flutter/screens/intro_login_signup/signup_screen_2.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../constant.dart';
import '../../rest_api.dart';

class SignUpScreen1 extends StatefulWidget {
  @override
  _SignUpScreen1State createState() => _SignUpScreen1State();
}

class _SignUpScreen1State extends State<SignUpScreen1> {
  final scaffoldState = GlobalKey<ScaffoldState>();
  bool obscurePass = true;
  bool obscureConfPass = true;

  // bool isCountrySelected = false;
  // bool isStateSelected = false;
  // bool isCitySelected = false;

  var respStatus;
  var respMessage;

  // int arrCountCountry = 0;
  // int arrCountState = 0;
  // int arrCountCity = 0;

  // var respCountry;
  // var respState;
  // var respCity;

  // var selectedCountryName = '';
  // var selectedStateName = '';
  // var selectedCityName = '';

  // var strFname = '';
  // var strLname = '';
  // var strEmail = '';
  // var strPhone = '';
  // var strPass = '';
  // var strConfPass = '';
  // var selectedCountryId = 0;
  // var selectedStateId = 0;
  // var selectedCityId = 0;

  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController extController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confPassController = TextEditingController();

  bool isLoaderShowing = false;

  // Pattern pattern1 = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$';
  Pattern pattern1 = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$';
  RegExp regExp;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAnalytics().setCurrentScreen(screenName: 'SignUp page 1');
    regExp = new RegExp(pattern1);
    // getCountryListAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Scaffold(
        key: scaffoldState,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 0.0,
                right: 0.0,
                left: 0.0,
                bottom: 0.0,
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      TopBar(Colors.white, 'Sign Up'),
                      Expanded(
                        child: SingleChildScrollView(
                          // physics: ClampingScrollPhysics(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Visibility(
                                visible: false,
                                child: Container(
                                  height: 200.0,
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(25.0, 50.0, 0.0, 0.0),
                                    child: Text(
                                      'Register\nYourself',
                                      style: kLabelTitleTextStyle,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 25.0),
                                margin: EdgeInsets.only(bottom: 25.0, top: 20.0),
                                child: Text(
                                  'Basic Details',
                                  style: kLableSignUpNewTitle,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 6.0.w),
                                child: TextField(
                                  controller: fnameController,
                                  style: kLableSignUpTextStyle,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'First Name *',
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
                                  controller: lnameController,
                                  style: kLableSignUpTextStyle,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Last Name *',
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
                                  controller: emailController,
                                  style: kLableSignUpTextStyle,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Email ID *',
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
                                  controller: phoneController,
                                  style: kLableSignUpTextStyle,
                                  keyboardType: TextInputType.number,
                                  maxLength: 10,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    counter: SizedBox.shrink(),
                                    hintText: 'Phone Number *',
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
                                        Fluttertoast.showToast(
                                            msg: mobileInfoMsg,
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: toastBackgroundColor,
                                            textColor: toastTextColor,
                                            fontSize: 16.0);
                                        /*scaffoldState.currentState.showSnackBar(
                                          SnackBar(
                                            content: Text(mobileInfoMsg),
                                            duration: Duration(seconds: 5),
                                          ),
                                        );*/
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
                                margin: EdgeInsets.symmetric(vertical: 1.0.w, horizontal: 6.0.w),
                                child: TextField(
                                  controller: passController,
                                  style: kLableSignUpTextStyle,
                                  obscureText: obscurePass,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Password *',
                                    hintStyle: kLableSignUpHintStyle,
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
                                        color: Color(0xFFBDBFCA),
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
                                margin: EdgeInsets.symmetric(vertical: 1.0.w, horizontal: 6.0.w),
                                child: TextField(
                                  controller: confPassController,
                                  style: kLableSignUpTextStyle,
                                  obscureText: obscureConfPass,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Confirm Password *',
                                    hintStyle: kLableSignUpHintStyle,
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
                                        color: Color(0xFFBDBFCA),
                                      ),
                                    ),
                                  ),
                                  textInputAction: TextInputAction.done,
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
                                      'Step 1/3',
                                      // style: kButtonLabelTextStyle,
                                      style: kStepText,
                                    ),
                                    RoundIconButton(
                                      icon: FontAwesomeIcons.arrowRight,
                                      onPressed: () async {
                                        /*ConstSignUp.strFname = fnameController.text;
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => SignUpScreen2(),
                                            // SignUpScreen3(),
                                          ),
                                        );*/
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
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0.0,
                right: 0.0,
                left: 0.0,
                top: 0.0,
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

  /*void getCountryListAPI() async {
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
  }*/

  void checkForValidations() {
    ConstSignUp.strFname = fnameController.text;
    ConstSignUp.strLname = lnameController.text;
    ConstSignUp.strEmail = emailController.text;
    ConstSignUp.strPhone = phoneController.text;
    ConstSignUp.strExt = extController.text;
    ConstSignUp.strMobile = mobileController.text;
    ConstSignUp.strPass = passController.text;
    ConstSignUp.strConfPass = confPassController.text;

    if (ConstSignUp.strFname == '' || ConstSignUp.strFname.length == 0) {
      Fluttertoast.showToast(
          msg: fnameEmptyMsg,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: toastBackgroundColor,
          textColor: toastTextColor,
          fontSize: 16.0);
      /*scaffoldState.currentState.showSnackBar(
        SnackBar(
          content: Text(fnameEmptyMsg),
          duration: Duration(seconds: 3),
        ),
      );*/
    } else if (ConstSignUp.strLname == '' || ConstSignUp.strLname.length == 0) {
      Fluttertoast.showToast(
          msg: lnameEmptyMsg,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: toastBackgroundColor,
          textColor: toastTextColor,
          fontSize: 16.0);
      /*scaffoldState.currentState.showSnackBar(
        SnackBar(
          content: Text(lnameEmptyMsg),
          duration: Duration(seconds: 3),
        ),
      );*/
    } else if (ConstSignUp.strEmail == '' || ConstSignUp.strEmail.length == 0) {
      Fluttertoast.showToast(
          msg: emailEmptyMsg,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: toastBackgroundColor,
          textColor: toastTextColor,
          fontSize: 16.0);
      /*scaffoldState.currentState.showSnackBar(
        SnackBar(
          content: Text(emailEmptyMsg),
          duration: Duration(seconds: 5),
        ),
      );*/
    } else if (!EmailValidator.validate(ConstSignUp.strEmail)) {
      Fluttertoast.showToast(
          msg: emailInValidMsg,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: toastBackgroundColor,
          textColor: toastTextColor,
          fontSize: 16.0);
      /*scaffoldState.currentState.showSnackBar(
        SnackBar(
          content: Text(emailInValidMsg),
          duration: Duration(seconds: 5),
        ),
      );*/
    } else if (ConstSignUp.strPhone == '' || ConstSignUp.strPhone.length == 0) {
      Fluttertoast.showToast(
          msg: phoneEmptyMsg,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: toastBackgroundColor,
          textColor: toastTextColor,
          fontSize: 16.0);
      /*scaffoldState.currentState.showSnackBar(
        SnackBar(
          content: Text(phoneEmptyMsg),
          duration: Duration(seconds: 5),
        ),
      );*/
    } else if (ConstSignUp.strPhone.length < 10 || ConstSignUp.strPhone.length > 10) {
      Fluttertoast.showToast(
          msg: phoneLengthMsg,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: toastBackgroundColor,
          textColor: toastTextColor,
          fontSize: 16.0);
      /*scaffoldState.currentState.showSnackBar(
        SnackBar(
          content: Text(phoneLengthMsg),
          duration: Duration(seconds: 5),
        ),
      );*/
    } else if (ConstSignUp.strPass == '' || ConstSignUp.strPass.length == 0) {
      Fluttertoast.showToast(
          msg: passLengthMsg,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: toastBackgroundColor,
          textColor: toastTextColor,
          fontSize: 16.0);
      /*scaffoldState.currentState.showSnackBar(
        SnackBar(
          content: Text(passLengthMsg),
          duration: Duration(seconds: 5),
        ),
      );*/
    } else if (ConstSignUp.strPass.length < 6) {
      Fluttertoast.showToast(
          msg: passValidLengthMsg,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: toastBackgroundColor,
          textColor: toastTextColor,
          fontSize: 16.0);
      /*scaffoldState.currentState.showSnackBar(
        SnackBar(
          content: Text(passValidLengthMsg),
          duration: Duration(seconds: 5),
        ),
      );*/
    } else if (!regExp.hasMatch(ConstSignUp.strPass)) {
      print('Regx Issue..');
      Fluttertoast.showToast(
          msg: passValidMsg,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: toastBackgroundColor,
          textColor: toastTextColor,
          fontSize: 16.0);
    } else if (ConstSignUp.strConfPass == '' || ConstSignUp.strConfPass.length == 0) {
      Fluttertoast.showToast(
          msg: confPassLengthMsg,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: toastBackgroundColor,
          textColor: toastTextColor,
          fontSize: 16.0);
      /*scaffoldState.currentState.showSnackBar(
        SnackBar(
          content: Text(confPassLengthMsg),
          duration: Duration(seconds: 5),
        ),
      );*/
    } else if (ConstSignUp.strConfPass.length < 6) {
      Fluttertoast.showToast(
          msg: confPassValidLengthMsg,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: toastBackgroundColor,
          textColor: toastTextColor,
          fontSize: 16.0);
      /*scaffoldState.currentState.showSnackBar(
        SnackBar(
          content: Text(confPassValidLengthMsg),
          duration: Duration(seconds: 5),
        ),
      );*/
    } else if (ConstSignUp.strPass != ConstSignUp.strConfPass) {
      Fluttertoast.showToast(
          msg: passConfPassEqualMsg,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: toastBackgroundColor,
          textColor: toastTextColor,
          fontSize: 16.0);
      /*scaffoldState.currentState.showSnackBar(
        SnackBar(
          content: Text(passConfPassEqualMsg),
          duration: Duration(seconds: 5),
        ),
      );*/
    } else {
      print('Validation passed..');
      checkForEmail(ConstSignUp.strEmail);
    }
  }

  void checkForEmail(String strEmail) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if ((connectivityResult == ConnectivityResult.mobile) || (connectivityResult == ConnectivityResult.wifi)) {
      setState(() {
        isLoaderShowing = true;
      });
      var resp = await emailExists(strEmail);
      print('Response is : $resp');

      respStatus = resp['success'];
      respMessage = resp['message'];

      // Now we need to add these above data on shared prefs and then
      // we can proceed for next screen.
      if (respStatus) {
        setState(() {
          isLoaderShowing = false;
        });
        // RedirectToSecondScreen..
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SignUpScreen2(),
          ),
        );
      } else {
        setState(() {
          isLoaderShowing = false;
        });
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
            duration: Duration(seconds: 5),
          ),
        );*/
      }
    } else {
      setState(() {
        isLoaderShowing = false;
      });
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
}
