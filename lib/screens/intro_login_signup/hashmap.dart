import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../constant.dart';
import '../../rest_api.dart';

class HashMapSample extends StatefulWidget {
  @override
  _HashMapSampleState createState() => _HashMapSampleState();
}

class _HashMapSampleState extends State<HashMapSample> {
  final scaffoldState = GlobalKey<ScaffoldState>();
  TextEditingController keyController = TextEditingController();
  TextEditingController valueController = TextEditingController();

  var result = '';

  // HashMap hashMap = new HashMap<String, String>();
  Map mapSample = new Map<String, String>();

  bool isAlreadyChecked = false;
  bool isLoaderShowing = false;

  var respProfCreds;
  var respStatus;
  var respMessage;

  int arrProfCredsCount = 0;
  Map mapProfCredsT = new Map<dynamic, bool>();

  var isChanged = false;

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
                    'Hashmap Sample',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.black,
                    ),
                  ),
                ),
                /*SizedBox(
                  height: 30.0,
                ),*/
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
                Container(
                  padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                  child: TextField(
                    controller: keyController,
                    style: kLableSignUpTextStyle,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Key',
                      hintStyle: kLableSignUpHintStyle,
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                  child: TextField(
                    controller: valueController,
                    style: kLableSignUpTextStyle,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Value',
                      hintStyle: kLableSignUpHintStyle,
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          // hashMap.update(keyController.text, (value) => valueController.text.toString());
                          // hashMap.addEntries(newEntries)
                          mapSample[keyController.text] = valueController.text;
                          setState(() {
                            // result = hashMap.toString();
                            result = mapSample.toString();
                          });
                        },
                        child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                          child: Text('Add'),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          mapSample.remove(keyController.text);
                          setState(() {
                            // result = hashMap.toString();
                            result = mapSample.toString();
                          });
                        },
                        child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                          child: Text('Delete'),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          var len = mapSample.length;
                          print('Size for map is : $len');
                          // mapSample.keys.forEach((k) => print(k));
                          mapSample.keys.forEach((k) => {
                                if (k == keyController.text)
                                  {
                                    isAlreadyChecked = true,
                                    // So here if we have the key then delete this data..
                                    mapSample.remove(keyController.text),
                                    setState(() {
                                      // result = hashMap.toString();
                                      result = mapSample.toString();
                                    })
                                  }
                                else
                                  {
                                    // isAlready
                                    isAlreadyChecked = false,
                                    // If we don't have the data then add this data..
                                    mapSample[keyController.text] = valueController.text,
                                    setState(() {
                                      // result = hashMap.toString();
                                      result = mapSample.toString();
                                    })
                                  }
                              });

                          print('State is data there? $isAlreadyChecked');
                        },
                        child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                          child: Text('Check'),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          mapSample[keyController.text] = valueController.text;
                          print('Data for give key : ${mapSample[keyController.text]}');
                          print('Data for give key New: ${mapSample['22']}');
                          setState(() {
                            // result = hashMap.toString();
                            result = mapSample.toString();
                          });
                        },
                        child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                          child: Text('Test'),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // scaffoldState.currentState.showBottomSheet(
                          scaffoldState.currentState.showBottomSheet(
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
                            ),
                          );
                        },
                        child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                          child: Text('Open'),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 60.0,
                ),
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Text('HashMap Data'),
                ),
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Text(result == '' ? 'Result' : result),
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
                              child: GestureDetector(
                                onTap: () {
                                  print('Clicked on the position : ${respProfCreds['payload']['user_type'][index]['title']}');
                                  setState(() {
                                    respProfCreds['payload']['user_type'][index]['title'] = 'Test '
                                        '${respProfCreds['payload']['user_type'][index]['id']}';
                                  });
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
                            ),
                          );
                        }),
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
}
