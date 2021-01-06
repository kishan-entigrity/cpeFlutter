import 'package:cpe_flutter/components/round_icon_button.dart';
import 'package:cpe_flutter/constant.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController emailController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String _email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      /*appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            FontAwesomeIcons.angleLeft,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'ForgetPassword',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
            fontFamily: 'Whitney Semi Bold',
          ),
        ),
      ),*/
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              height: 50.0,
              width: double.infinity,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    child: Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          FontAwesomeIcons.angleLeft,
                        ),
                      ),
                      flex: 1,
                    ),
                    onTap: () {
                      print('Back button is pressed..');
                      Navigator.pop(context);
                    },
                  ),
                  Flexible(
                    child: Center(
                      child: Text(
                        'Forget Password',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontFamily: 'Whitney Semi Bold',
                        ),
                      ),
                    ),
                    flex: 8,
                  ),
                  Flexible(
                    child: Text(''),
                    flex: 1,
                  )
                ],
              ),
            ),
            Container(
              height: 300.0,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25.0, 80.0, 0.0, 0.0),
                child: Text(
                  'Enter your\nregistered email',
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
                textInputAction: TextInputAction.done,
              ),
            ),
            Container(
              height: 100.0,
              width: double.infinity,
              // color: Colors.teal,
              margin: EdgeInsets.symmetric(vertical: 50.0, horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Submit',
                    style: kButtonLabelTextStyle,
                  ),
                  RoundIconButton(
                    icon: FontAwesomeIcons.arrowRight,
                    onPressed: () async {
                      // getUserData();
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
    );
  }

  void getUserData() {
    _email = emailController.text;

    if (_email.length == 0) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Please enter email'),
          duration: Duration(seconds: 5),
        ),
      );
    } else if (!EmailValidator.validate(_email)) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Please enter valid email address'),
          duration: Duration(seconds: 5),
        ),
      );
    } else {
      print('All validations fired successfully');
      // Take and API call for submitting user data..
      // Then take a pop back stack if we get successful response..
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Data sent successfully'),
          duration: Duration(seconds: 5),
        ),
      );
      Navigator.pop(context);
    }
  }
}
