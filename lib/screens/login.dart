import 'package:cpe_flutter/components/round_icon_button.dart';
import 'package:cpe_flutter/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    'Sign In',
                    style: kButtonLabelTextStyle,
                  ),
                  RoundIconButton(
                    icon: FontAwesomeIcons.arrowRight,
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
                  Text(
                    'Forget Password',
                    style: kTextLableLoginUnderlineGray,
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
    );
  }
}
