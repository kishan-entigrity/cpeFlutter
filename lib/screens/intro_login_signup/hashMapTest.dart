import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../constant.dart';
import '../../rest_api.dart';

class HashMapTest extends StatefulWidget {
  @override
  _HashMapTestState createState() => _HashMapTestState();
}

class _HashMapTestState extends State<HashMapTest> {
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
                    'BottomSheet Sample',
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
                        onTap: () async {
                          // scaffoldState.currentState.showBottomSheet(
                          // scaffoldState.currentState.showBottomSheet(
                          showModalBottomSheet(
                              context: context,
                              builder: (builder) {
                                return StatefulBuilder(
                                  builder: (BuildContext context, void Function(void Function()) setState) {
                                    return Container(
                                      color: Colors.white,
                                      height: 70.0.h,
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                              height: 10.0.w,
                                              color: Colors.white,
                                              child: Center(
                                                child: Text(
                                                  'Professional Creds',
                                                ),
                                              )),
                                          Expanded(
                                            child: Container(
                                              child: ListView.builder(
                                                  itemCount: arrProfCredsCount,
                                                  itemBuilder: (context, index) {
                                                    return ConstrainedBox(
                                                      constraints: BoxConstraints(
                                                        minHeight: 15.0.w,
                                                      ),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          var profID = respProfCreds['payload']['user_type'][index]['id'];
                                                          print('Position on bottomsheet : $profID');
                                                          setState(() {
                                                            // Update text data..
                                                            respProfCreds['payload']['user_type'][index]['title'] =
                                                                'Test ${respProfCreds['payload']['user_type'][index]['id']}';
                                                          });
                                                          if (mapProfCredsT[profID]) {
                                                            setState(() {
                                                              mapProfCredsT[profID] = false;
                                                            });
                                                          } else {
                                                            setState(() {
                                                              mapProfCredsT[profID] = true;
                                                            });
                                                          }
                                                        },
                                                        child: Container(
                                                          margin: EdgeInsets.all(2.0.w),
                                                          // color: Colors.tealAccent,
                                                          // color: mapProfCredsT[respProfCreds['payload']['user_type'][index]['id']]? themeYellow: Colors.blueGrey,
                                                          color: isChanged ? themeYellow : Colors.blueGrey,
                                                          child: Center(
                                                            child: Text(
                                                              '${respProfCreds['payload']['user_type'][index]['title']}',
                                                              textAlign: TextAlign.start,
                                                              style: kDataSingleSelectionBottomNav,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  /*child: new Container(

                                  ),*/
                                );
                              });
                          /*_controller = await scaffoldState.currentState.showBottomSheet(
                            (context) => Container(
                              color: Colors.white,
                              height: 70.0.h,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    height: 10.0.w,
                                    color: Colors.white,
                                    child: Center(
                                      child: Text(
                                        'Professional Creds',
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: ListView.builder(
                                          itemCount: arrProfCredsCount,
                                          itemBuilder: (context, index) {
                                            return ConstrainedBox(
                                              constraints: BoxConstraints(
                                                minHeight: 15.0.w,
                                              ),
                                              child: GestureDetector(
                                                onTap: () {
                                                  var profID = respProfCreds['payload']['user_type'][index]['id'];
                                                  setState(() {
                                                    // respProfCreds['payload']['user_type'][index]['title'] =
                                                    //     'Test ${respProfCreds['payload']['user_type'][index]['id']}';
                                                    _incrementBottomSheet(index);
                                                  });
                                                  */ /*if (mapProfCredsT[profID]) {
                                                    setState(() {
                                                      mapProfCredsT[profID] = false;
                                                    });
                                                  } else {
                                                    setState(() {
                                                      mapProfCredsT[profID] = true;
                                                    });
                                                  }*/ /*
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.all(2.0.w),
                                                  // color: Colors.tealAccent,
                                                  // color: mapProfCredsT[respProfCreds['payload']['user_type'][index]['id']]? themeYellow: Colors.blueGrey,
                                                  color: isChanged ? themeYellow : Colors.blueGrey,
                                                  child: Center(
                                                    child: Text(
                                                      '${respProfCreds['payload']['user_type'][index]['title']}',
                                                      textAlign: TextAlign.start,
                                                      style: kDataSingleSelectionBottomNav,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );*/
                        },
                        child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                          child: Text('Open'),
                        ),
                      )
                    ],
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
        scaffoldState.currentState.showSnackBar(
          SnackBar(
            content: Text('$respMessage'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } else {
      scaffoldState.currentState.showSnackBar(
        SnackBar(
          content: Text("Please check your internet connectivity and try again"),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  void _incrementBottomSheet(var index) {
    _controller.setState(() {
      respProfCreds['payload']['user_type'][index]['title'] = 'Test ${respProfCreds['payload']['user_type'][index]['id']}';
    });
  }
}
