import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../constant.dart';
import '../../rest_api.dart';

class TermsCondition extends StatefulWidget {
  TermsCondition(this.terms_url);
  final String terms_url;
  @override
  _TermsConditionState createState() => _TermsConditionState(terms_url);
}

class _TermsConditionState extends State<TermsCondition> {
  _TermsConditionState(this.terms_url);
  final String terms_url;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  var respStatus;
  var respMessage;

  var respLink;

  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getTermsAndCondition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.teal,
      /*appBar: AppBar(
        title: Text('Terms and condition'),
      ),*/
      body: SafeArea(
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
                        'Terms and conditions',
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
              width: double.infinity,
              height: 0.5,
              color: Colors.black,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 10.0),
                color: Colors.white,
                height: 300.0,
                width: double.infinity,
                child: WebView(
                  // initialUrl: '$respLink',
                  // initialUrl: getAPICallPrivacyPolicy(),
                  // initialUrl: 'https://my-cpe.com/api/cms/terms_condition',
                  // initialUrl: 'https://my-cpe.com/api/cms/get-terms-and-conditions',
                  initialUrl: terms_url,
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController webViewController) {
                    _controller.complete(webViewController);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getTermsAndCondition() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    print('Connectivity Result is : $connectivityResult');

    if ((connectivityResult == ConnectivityResult.mobile) || (connectivityResult == ConnectivityResult.wifi)) {
      var resp = await getTermsAndConditions();
      print('Response for change password api is : $resp');

      respStatus = resp['success'];
      respMessage = resp['message'];
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
            duration: Duration(seconds: 3),
          ),
        );*/

        setState(() {
          respLink = resp['payload']['link'];
          print('Privacy policy link is : $respLink');
          // loadWebViewPrivacyPolicy();
        });
      } else {
        print('Entered in else part');
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
            duration: Duration(seconds: 3),
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
          content:
              Text("Please check your internet connectivity and try again"),
          duration: Duration(seconds: 3),
        ),
      );*/
    }
  }
}
