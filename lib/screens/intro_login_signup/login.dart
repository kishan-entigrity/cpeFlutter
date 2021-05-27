import 'package:connectivity/connectivity.dart';
import 'package:cpe_flutter/components/custom_dialog_two.dart';
import 'package:cpe_flutter/components/round_icon_button.dart';
import 'package:cpe_flutter/constant.dart';
import 'package:cpe_flutter/rest_api.dart';
import 'package:cpe_flutter/screens/home_screen.dart';
import 'package:cpe_flutter/screens/intro_login_signup/forget_password.dart';
import 'package:cpe_flutter/screens/intro_login_signup/signup_screen_1.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class Login extends StatefulWidget {
  Login(this.isFromIntroScreen);

  final bool isFromIntroScreen;

  @override
  _LoginState createState() => _LoginState(isFromIntroScreen);
}

class _LoginState extends State<Login> {
  _LoginState(this.isFromIntroScreen);

  final bool isFromIntroScreen;

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  String _email;
  String _password;

  bool checkValue = false;

  SharedPreferences sharedPreferences;

  var respStrId;
  var respStrEmail;
  var respStrFName;
  var respStrLName;
  var respStrContactNumber;
  var respStrProfilePic;
  var respToken;

  var respStatus;
  var respMessage;

  bool isLoading = false;

  bool obscurePass = true;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          key: _scaffoldKey,
          resizeToAvoidBottomInset: false,
          /*appBar: AppBar(
          title: Text('Login Screen'),
        ),*/
          body: SafeArea(
            child: Stack(
              children: <Widget>[
                Positioned(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 170.0.sp,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(25.0, 100.0, 0.0, 0.0),
                          child: Text(
                            'Welcome\nBack',
                            style: kLabelTitleTextStyle,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 4.0.w, horizontal: 6.0.w),
                        child: TextField(
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
                      /*Container(
                      height: 30.0,
                      width: double.infinity,
                      margin: EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
                      child: TextField(
                        controller: emailController,
                        obscureText: false,
                        decoration: lTextFlieldStyleEmail,
                        textInputAction: TextInputAction.next,
                      ),
                    ),*/
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 4.0.w, horizontal: 6.0.w),
                        child: TextField(
                          controller: passController,
                          style: kLableSignUpTextStyle,
                          obscureText: obscurePass,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Password',
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
                      /*Container(
                      height: 30.0,
                      width: double.infinity,
                      margin: EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 0.0),
                      child: TextField(
                        controller: passController,
                        obscureText: true,
                        decoration: lTextFlieldStylePass,
                        textInputAction: TextInputAction.done,
                      ),
                    ),*/
                      Container(
                        height: 100.0,
                        width: double.infinity,
                        // color: Colors.teal,
                        margin: EdgeInsets.symmetric(vertical: 50.0, horizontal: 25.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Log In',
                              style: kButtonLabelTextStyle,
                            ),
                            RoundIconButton(
                              icon: FontAwesomeIcons.arrowRight,
                              onPressed: () async {
                                getUserData();
                              },
                            ),
                            /*FloatingActionButton(
                        onPressed: null,
                        backgroundColor: Color(0xFFFBB42C),
                      ),*/
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 5.0.h,
                  right: 0.0,
                  left: 0.0,
                  child: Container(
                    height: 50.0,
                    width: double.infinity,
                    // color: Colors.teal,
                    margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpScreen1(),
                              ),
                            );
                          },
                          child: Text(
                            'Sign Up',
                            style: kTextLableLoginUnderline,
                          ),
                        ),
                        /*Text(
                        'Forget Password',
                        style: kTextLableLoginUnderlineGray,
                      ),*/
                        GestureDetector(
                          child: Text(
                            'Forget Password',
                            style: kTextLableLoginUnderlineGray,
                          ),
                          // onTap: redirectToForgetPass(),
                          onTap: () {
                            // print('Temp Pressed');
                            redirectToForgetPass();
                          },
                        ),
                        /*RoundIconButton(
                        icon: FontAwesomeIcons.arrowRight,
                      ),*/
                        /*FloatingActionButton(
                        onPressed: null,
                        backgroundColor: Color(0xFFFBB42C),
                      ),*/
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      print('Clicked on skip button..');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                      child: Text(
                        'Skip',
                        style: kTextLableLoginUnderline,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  child: Visibility(
                    visible: isLoading ? true : false,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // );
        onWillPop: _onWillPop);
  }

  Future<bool> _onWillPop() {
    return showExitDialog();
  }

  getUserData() {
    // setState(() {
    _email = emailController.text;
    _password = passController.text;
    print('Email is : $_email');
    print('Password is $_password');

    checkForValidation();
    // });
  }

  redirectToForgetPass() {
    // print('Forget Password is called');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ForgetPassword(),
      ),
    );
  }

  checkForValidation() {
    if (_email.length == 0) {
      print('Length for email is valid');
      Fluttertoast.showToast(
          msg: "Please enter email",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: toastBackgroundColor,
          textColor: toastTextColor,
          fontSize: 16.0);
      /*_scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Please enter email"),
        duration: Duration(seconds: 5),
      ));*/
    } else if (_password.length == 0) {
      Fluttertoast.showToast(
          msg: "Please enter password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: toastBackgroundColor,
          textColor: toastTextColor,
          fontSize: 16.0);
      /*_scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Please enter password"),
          duration: Duration(seconds: 5),
        ),
      );*/
    } else if (!EmailValidator.validate(_email)) {
      Fluttertoast.showToast(
          msg: "Please enter valid email address",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: toastBackgroundColor,
          textColor: toastTextColor,
          fontSize: 16.0);
      /*_scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Please enter valid email address"),
          duration: Duration(seconds: 5),
        ),
      );*/
    } else {
      /*_scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Validation successful"),
          duration: Duration(seconds: 3),
        ),
      );*/
      // Add data to shared prefs..
      // saveData();
      takeLoginApi();

      // Need to take redirection call once we are getting success on API call..
      /*Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );*/
    }
  }

  void takeLoginApi() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    print('Connectivity Result is : $connectivityResult');
    print('Connectivity Result is empty');

    if ((connectivityResult == ConnectivityResult.mobile) || (connectivityResult == ConnectivityResult.wifi)) {
      setState(() {
        isLoading = true;
      });
      var resp = await loginUser(_email, _password, 'android', 'ddddddddddddddddddddddddddddd', 'A');
      print('Response is : $resp');

      respStatus = resp['success'];
      respMessage = resp['message'];

      // Now we need to add these above data on shared prefs and then
      // we can proceed for next screen.
      if (respStatus) {
        var respStrPayload = resp['payload'];
        respStrId = resp['payload']['id'];
        respStrEmail = resp['payload']['email'];
        respStrFName = resp['payload']['first_name'];
        respStrLName = resp['payload']['last_name'];
        respStrContactNumber = resp['payload']['contact_no'];
        respStrProfilePic = resp['payload']['profile_picture'];
        respToken = resp['payload']['token'];

        print('Response id is : $respStrId');
        print('Response email is : $respStrEmail');
        print('Response FName is : $respStrFName');
        print('Response LName is : $respStrLName');
        print('Response contact is : $respStrContactNumber');
        print('Response profile-pic is : $respStrProfilePic');
        setState(() {
          isLoading = false;
        });
        saveData();
      } else {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(
            msg: respMessage,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: toastBackgroundColor,
            textColor: toastTextColor,
            fontSize: 16.0);
        /*_scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text('$respMessage'),
            duration: Duration(seconds: 5),
          ),
        );*/
      }
    } else {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(
          msg: "Please check your internet connectivity and try again",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: toastBackgroundColor,
          textColor: toastTextColor,
          fontSize: 16.0);
      /*_scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Please check your internet connectivity and try again"),
          duration: Duration(seconds: 5),
        ),
      );*/
    }
  }

  saveData() async {
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences = await SharedPreferences.getInstance();
    // prefs.setString('logged_email', _email);
    // prefs.setString('logged_pass', _password);
    checkValue = true;
    sharedPreferences.setBool("check", checkValue);
    sharedPreferences.setInt("spID", respStrId);
    sharedPreferences.setString("spEmail", respStrEmail);
    sharedPreferences.setString("spFName", respStrFName);
    sharedPreferences.setString("spLName", respStrLName);
    sharedPreferences.setString("spContact", respStrContactNumber);
    sharedPreferences.setString("spProfilePic", respStrProfilePic);
    sharedPreferences.setString("spToken", respToken);
    // sharedPreferences.setString("username", _email);
    // sharedPreferences.setString("password", _password);
    sharedPreferences.commit();

    // Take anvigation call from here..
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ),
    );
    // getCredential();
  }

  void getCredential() async {
    checkValue = sharedPreferences.getBool("check");
    if (checkValue != null) {
      if (checkValue) {
        String eml = sharedPreferences.getString("spEmail");
        String id = sharedPreferences.getString("spID");
        print('Email on Login Screen getCredential method is : $eml');
        print('ID on Login Screen getCredential method is : $id');
        // username.text = sharedPreferences.getString("username");
        // password.text = sharedPreferences.getString("password");
      } else {
        print('Check value : $checkValue');
        // username.clear();
        // password.clear();
        sharedPreferences.clear();
      }
    } else {
      print('Null value else part');
      checkValue = false;
    }
  }

  showExitDialog() {
    isFromIntroScreen
        ? Navigator.pop(context)
        : showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomDialogTwo(
                "Confirm Exit?",
                "Are you sure you want to exit the app?",
                "Yes",
                "No",
                () {
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                },
                () {
                  Navigator.pop(context);
                },
              );
            });
    /*showDialog(
              context: context,
              builder: (context) => new AlertDialog(
                title: new Text('Confirm Exit?', style: new TextStyle(color: Colors.black, fontSize: 20.0)),
                content: new Text('Are you sure you want to exit the app?'),
                actions: <Widget>[
                  new FlatButton(
                    onPressed: () {
                      // this line exits the app.
                      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                    },
                    child: new Text('Yes', style: new TextStyle(fontSize: 18.0)),
                  ),
                  new FlatButton(
                    onPressed: () => Navigator.pop(context), // this line dismisses the dialog
                    child: new Text('No', style: new TextStyle(fontSize: 18.0)),
                  )
                ],
              ),
            ) ??
            false;*/
  }
}
