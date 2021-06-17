import 'package:connectivity/connectivity.dart';
import 'package:cpe_flutter/components/round_icon_button.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constant.dart';
import '../../rest_api.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController subjectController = TextEditingController();

  String _email;
  String _subject;

  var respStatus;
  var respMessage;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(0xFFF3F5F9),
      /*appBar: AppBar(
        title: Text('Contact Us'),
      ),*/
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 70.0,
                    width: double.infinity,
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: GestureDetector(
                            onTap: () {
                              print('Back button is pressed..');
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                FontAwesomeIcons.angleLeft,
                              ),
                            ),
                          ),
                          flex: 1,
                        ),
                        Flexible(
                          child: Center(
                            child: Text(
                              'Contact Us',
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
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.only(
                            left: 20.0,
                            top: 30.0,
                          ),
                          child: Text(
                            'Need Help?',
                            style: kLabelTitleTextStyle,
                          ),
                        ),
                        Container(
                          height: 50.0,
                          width: double.infinity,
                          margin: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 0.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              // launch("tel://9292976311");
                              launch("tel://6466885128");
                            },
                            child: Row(
                              children: <Widget>[
                                Container(
                                  height: 32.0,
                                  width: 32.0,
                                  margin: EdgeInsets.only(left: 14.0),
                                  decoration: BoxDecoration(
                                    color: themeYellow,
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Icon(
                                    FontAwesomeIcons.phone,
                                    color: Colors.white,
                                    size: 16.0,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 15.0),
                                  child: Text(
                                    '646-688-5128',
                                    style: TextStyle(
                                      fontSize: 17.0,
                                      fontFamily: 'Whitney Medium',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 50.0,
                          width: double.infinity,
                          margin: EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 0.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              launch("mailto:support@my-cpe.com");
                            },
                            child: Row(
                              children: <Widget>[
                                Container(
                                  height: 32.0,
                                  width: 32.0,
                                  margin: EdgeInsets.only(left: 14.0),
                                  decoration: BoxDecoration(
                                    color: themeYellow,
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Icon(
                                    FontAwesomeIcons.solidEnvelope,
                                    color: Colors.white,
                                    size: 16.0,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 15.0),
                                  child: Text(
                                    'support@my-cpe.com',
                                    style: TextStyle(
                                      fontSize: 17.0,
                                      fontFamily: 'Whitney Medium',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Container(
                              margin: EdgeInsets.only(
                                top: 50.0,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50.0),
                                  topRight: Radius.circular(50.0),
                                ),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    height: 40.0,
                                    width: double.infinity,
                                    margin: EdgeInsets.fromLTRB(40.0, 30.0, 40.0, 0.0),
                                    child: TextField(
                                      controller: emailController,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        hintText: 'Email',
                                        contentPadding: EdgeInsets.only(
                                          left: 10.0,
                                          bottom: 10.0,
                                        ),
                                        border: UnderlineInputBorder(),
                                        hintStyle: TextStyle(
                                          fontSize: 20.0,
                                          fontFamily: 'Whitney Medium',
                                          color: Colors.black45,
                                        ),
                                        prefixStyle: TextStyle(
                                          fontSize: 20.0,
                                          fontFamily: 'Whitney Medium',
                                          color: Colors.white,
                                        ),
                                      ),
                                      textInputAction: TextInputAction.next,
                                    ),
                                  ),
                                  Container(
                                    height: 40.0,
                                    width: double.infinity,
                                    margin: EdgeInsets.fromLTRB(40.0, 40.0, 40.0, 0.0),
                                    child: TextFormField(
                                      controller: subjectController,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        hintText: 'Message',
                                        contentPadding: EdgeInsets.only(
                                          left: 10.0,
                                          bottom: 10.0,
                                        ),
                                        border: UnderlineInputBorder(),
                                        hintStyle: TextStyle(
                                          fontSize: 20.0,
                                          fontFamily: 'Whitney Medium',
                                          color: Colors.black45,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 100.0,
                                    width: double.infinity,
                                    // color: Colors.white,
                                    margin: EdgeInsets.fromLTRB(40.0, 50.0, 40.0, 0.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          'Send',
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
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
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
    );
  }

  void getUserData() {
    _email = emailController.text;
    _subject = subjectController.text;

    print('Email : $_email');
    print('Subject : $_subject');

    checkForValidation();
  }

  checkForValidation() {
    if (_email.length == 0) {
      // print('Length for email is valid');
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
    } else if (_subject.length == 0) {
      Fluttertoast.showToast(
          msg: "Please enter subject",
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
      takeContactUsApi();
    }
  }

  void takeContactUsApi() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    print('Connectivity Result is : $connectivityResult');
    print('Connectivity Result is empty');

    if ((connectivityResult == ConnectivityResult.mobile) || (connectivityResult == ConnectivityResult.wifi)) {
      setState(() {
        isLoading = true;
      });
      var resp = await contactUs(_email, _subject);
      print('Response is : $resp');

      respStatus = resp['success'];
      respMessage = resp['message'];

      setState(() {
        isLoading = false;
      });

      // Now we need to add these above data on shared prefs and then
      // we can proceed for next screen.
      if (respStatus) {
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
      } else {
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
}
