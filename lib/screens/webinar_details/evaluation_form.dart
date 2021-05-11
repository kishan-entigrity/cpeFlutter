import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../constant.dart';

class EvaluationForm extends StatefulWidget {
  EvaluationForm(this.strEvaLink);

  final String strEvaLink;
  @override
  _EvaluationFormState createState() => _EvaluationFormState(strEvaLink);
}

class _EvaluationFormState extends State<EvaluationForm> {
  _EvaluationFormState(this.strEvaLink);

  final String strEvaLink;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final Completer<WebViewController> _controller = Completer<WebViewController>();

  var respStatus;
  var respMessage;

  var respLink;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    checkForInternet();
    print('Evaluation form link is : $strEvaLink');
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
                        'Evaluation Form',
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
                color: Colors.tealAccent,
                height: 300.0,
                width: double.infinity,
                child: WebView(
                  // initialUrl: '$respLink',
                  // initialUrl: getAPICallPrivacyPolicy(),
                  // initialUrl: 'https://my-cpe.com/api/cms/get-privacy-policy',
                  // initialUrl: 'https://my-cpe.com/api/cms/get-faq',
                  initialUrl: '$strEvaLink',
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

  void checkForInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    print('Connectivity Result is : $connectivityResult');

    if ((connectivityResult == ConnectivityResult.mobile) || (connectivityResult == ConnectivityResult.wifi)) {
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
