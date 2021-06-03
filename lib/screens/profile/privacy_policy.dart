import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../constant.dart';
import '../../rest_api.dart';

class PrivacyPolicy extends StatefulWidget {
  PrivacyPolicy(this.privacy_url);
  final String privacy_url;
  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState(privacy_url);
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  _PrivacyPolicyState(this.privacy_url);
  final String privacy_url;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  var respStatus;
  var respMessage;

  var respLink;

  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getPrivacyPolicyAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*backgroundColor: Colors.teal,
      appBar: AppBar(
        title: Text('Privacy Policy'),
      ),*/
      key: _scaffoldKey,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              height: 70.0,
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
                        'Privacy Policy',
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
                  // initialUrl: 'https://my-cpe.com/api/cms/get-privacy-policy',
                  initialUrl: privacy_url,
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

  /*void getPrivacyPolicyAPI() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    print('Connectivity Result is : $connectivityResult');

    if ((connectivityResult == ConnectivityResult.mobile) ||
        (connectivityResult == ConnectivityResult.wifi)) {
      var resp = await getPrivacyPolicy();
      print('Response for change password api is : $resp');

      respStatus = resp['success'];
      respMessage = resp['message'];
      if (respStatus) {
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text('$respMessage'),
            duration: Duration(seconds: 3),
          ),
        );

        setState(() {
          respLink = resp['payload']['link'];
          print('Privacy policy link is : $respLink');
          // loadWebViewPrivacyPolicy();
        });
      } else {
        print('Entered in else part');
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text('$respMessage'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } else {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content:
              Text("Please check your internet connectivity and try again"),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }*/

  /*void loadWebViewPrivacyPolicy() {
    initialUrl:
    '$respLink';
    // initialUrl: 'https://my-cpe.com/api/cms/get-privacy-policy',
    javascriptMode:
    JavascriptMode.unrestricted;
    onWebViewCreated:
    (WebViewController webViewController) {
      _controller.complete(webViewController);
    };
  }*/

  getAPICallPrivacyPolicy() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    print('Connectivity Result is : $connectivityResult');

    if ((connectivityResult == ConnectivityResult.mobile) || (connectivityResult == ConnectivityResult.wifi)) {
      var resp = await getPrivacyPolicy();
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
    return respLink;
  }
}
