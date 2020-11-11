import 'package:cpe_flutter/components/round_icon_button.dart';
import 'package:cpe_flutter/constant.dart';
import 'package:cpe_flutter/screens/forget_password.dart';
import 'package:cpe_flutter/screens/home_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  String _email;
  String _password;

  bool checkValue = false;

  SharedPreferences sharedPreferences;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        child: Scaffold(
          key: _scaffoldKey,
          resizeToAvoidBottomInset: false,
          /*appBar: AppBar(
        title: Text('Login Screen'),
      ),*/
          body: SafeArea(
            child: Column(
              children: <Widget>[
                Container(
                  height: 300.0,
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
                  height: 30.0,
                  width: double.infinity,
                  margin: EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
                  child: TextField(
                    controller: emailController,
                    obscureText: false,
                    decoration: lTextFlieldStyleEmail,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                Container(
                  height: 30.0,
                  width: double.infinity,
                  margin: EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 0.0),
                  child: TextField(
                    controller: passController,
                    obscureText: true,
                    decoration: lTextFlieldStylePass,
                    textInputAction: TextInputAction.done,
                  ),
                ),
                Container(
                  height: 100.0,
                  width: double.infinity,
                  // color: Colors.teal,
                  margin:
                      EdgeInsets.symmetric(vertical: 50.0, horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Sign In',
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
                Container(
                  height: 50.0,
                  width: double.infinity,
                  // color: Colors.teal,
                  margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Sign Up',
                        style: kTextLableLoginUnderline,
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
              ],
            ),
          ),
        ),
        onWillPop: _onWillPop);
  }

  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Confirm Exit?',
                style: new TextStyle(color: Colors.black, fontSize: 20.0)),
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
                onPressed: () =>
                    Navigator.pop(context), // this line dismisses the dialog
                child: new Text('No', style: new TextStyle(fontSize: 18.0)),
              )
            ],
          ),
        ) ??
        false;
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
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Please enter email"),
        duration: Duration(seconds: 5),
      ));
    } else if (_password.length == 0) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Please enter password"),
          duration: Duration(seconds: 5),
        ),
      );
    } else if (!EmailValidator.validate(_email)) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Please enter valid email address"),
          duration: Duration(seconds: 5),
        ),
      );
    } else {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Validation successful"),
          duration: Duration(seconds: 3),
        ),
      );
      // Add data to shared prefs..
      saveData();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    }
  }

  saveData() async {
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences = await SharedPreferences.getInstance();
    // prefs.setString('logged_email', _email);
    // prefs.setString('logged_pass', _password);
    checkValue = true;
    sharedPreferences.setBool("check", checkValue);
    sharedPreferences.setString("username", _email);
    sharedPreferences.setString("password", _password);
    sharedPreferences.commit();
    getCredential();
  }

  void getCredential() async {
    checkValue = sharedPreferences.getBool("check");
    if (checkValue != null) {
      if (checkValue) {
        String eml = sharedPreferences.getString("username");
        String pass = sharedPreferences.getString("password");
        print('Email on Login Screen getCredential method is : $eml');
        print('Password on Login Screen getCredential method is : $pass');
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
}
