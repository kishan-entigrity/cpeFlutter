import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../constant.dart';
import '../../rest_api.dart';

class FAQ extends StatefulWidget {
  @override
  _FAQState createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  var respStatus;
  var respMessage;

  var respLink;

  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    // getFAQs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        'FAQ\'s',
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
                  initialUrl: 'https://my-cpe.com/api/cms/get-faq',
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

  /*void getFAQs() {}*/

  void getFAQs() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    print('Connectivity Result is : $connectivityResult');

    if ((connectivityResult == ConnectivityResult.mobile) || (connectivityResult == ConnectivityResult.wifi)) {
      var resp = await getFAQsAPI();
      print('Response for get FAQs is : $resp');

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
          content: Text("Please check your internet connectivity and try again"),
          duration: Duration(seconds: 3),
        ),
      );*/
    }
  }
}
