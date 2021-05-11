import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../constant.dart';
import '../../rest_api.dart';

class ChipviewSample extends StatefulWidget {
  @override
  _ChipviewSampleState createState() => _ChipviewSampleState();
}

class _ChipviewSampleState extends State<ChipviewSample> {
  final scaffoldState = GlobalKey<ScaffoldState>();
  var respProfCreds;
  var respStatus;
  var respMessage;

  bool isLoaderShowing = false;

  int arrProfCredsCount = 0;
  Map mapProfCredsT = new Map<dynamic, bool>();

  var isChanged = false;

  Map mapSample = new Map<String, String>();
  PersistentBottomSheetController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfCredsAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Scaffold(
        key: scaffoldState,
        body: SafeArea(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.teal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10.0),
                  width: double.infinity,
                  child: Text(
                    'Chip group',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isChanged) {
                              isChanged = false;
                            } else {
                              isChanged = true;
                            }
                          });
                        },
                        child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                          child: Text('Change'),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                          child: Text('Open'),
                        ),
                      ),
                      Chip(label: Text('Test')),
                    ],
                  ),
                ),
                Container(
                  // margin: EdgeInsets.all(10.0),
                  child: Wrap(
                    children: List.generate(
                      // arrProfCredsCount,
                      10,
                      (i) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
                          child: Chip(
                            label: Container(
                              child: Text(
                                '${respProfCreds['payload']['user_type'][i]['title']}',
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void getProfCredsAPI() async {
    isLoaderShowing = true;
    var connectivityResult = await (Connectivity().checkConnectivity());
    // print('Connectivity Result is : $connectivityResult');

    if ((connectivityResult == ConnectivityResult.mobile) || (connectivityResult == ConnectivityResult.wifi)) {
      respProfCreds = await getProfessionalCreds();
      print('Response for Country list api is : $respProfCreds');

      respStatus = respProfCreds['success'];
      respMessage = respProfCreds['message'];
      isLoaderShowing = false;
      if (respStatus) {
        // Do something to load data for country list from here..
        setState(() {
          arrProfCredsCount = respProfCreds['payload']['user_type'].length;
          print('ProfCreds Length is : $arrProfCredsCount');
          // Add data to map from the API response..
          for (int i = 0; i < arrProfCredsCount; i++) {
            int id_key = respProfCreds['payload']['user_type'][i]['id'];
            mapProfCredsT[id_key] = false;
            respProfCreds['payload']['user_type'][i]['select_state'] = false;
          }
        });
      } else {
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
      /*scaffoldState.currentState.showSnackBar(
        SnackBar(
          content: Text("Please check your internet connectivity and try again"),
          duration: Duration(seconds: 3),
        ),
      );*/
    }
  }

  void _incrementBottomSheet(var index) {
    _controller.setState(() {
      respProfCreds['payload']['user_type'][index]['title'] = 'Test ${respProfCreds['payload']['user_type'][index]['id']}';
    });
  }
}
