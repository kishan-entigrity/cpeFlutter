import 'package:connectivity/connectivity.dart';
import 'package:cpe_flutter/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../rest_api.dart';

class BottomSheetSample extends StatefulWidget {
  @override
  _BottomSheetSampleState createState() => _BottomSheetSampleState();
}

class _BottomSheetSampleState extends State<BottomSheetSample> {
  final scaffoldState = GlobalKey<ScaffoldState>();
  var respStatus;
  var respMessage;

  int arrCount = 0;

  var resp;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCountryListAPI();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: scaffoldState,
      backgroundColor: Colors.teal,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Container(
                margin: EdgeInsets.only(top: 20.0),
                child: Text(
                  'Bottom Navigator Sample',
                  style: TextStyle(fontSize: 20.0),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Positioned(
              bottom: 20.0,
              right: 20.0,
              child: GestureDetector(
                onTap: () {
                  print('Clicked on FAB');
                  scaffoldState.currentState.showBottomSheet(
                    (context) => Container(
                      // margin: EdgeInsets.only(left: 10.0.w, right: 10.0.w),
                      color: Colors.teal,
                      height: 70.0.h,
                      child: Container(
                        decoration: BoxDecoration(
                          // color: Colors.grey[900],
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30.0),
                            topLeft: Radius.circular(30.0),
                          ),
                        ),
                        child: Column(
                          children: <Widget>[
                            /*SizedBox(
                              height: 40.0,
                            ),*/
                            // TopBar(Colors.grey[900], 'Country'),
                            Container(
                              height: 17.0.w,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      width: 20.0.w,
                                      child: Center(
                                        child: Text(
                                          'Cancel',
                                          style: kDateTestimonials,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 20.0.w,
                                    child: Center(
                                      child: Text(
                                        'Country',
                                        style: kOthersTitle,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 20.0.w,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 0.5,
                              color: Colors.black45,
                            ),
                            // TopBar(Colors.white, 'Country'),
                            Expanded(
                              child: ListView.builder(
                                itemCount: arrCount,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      print(
                                          'Selected Name of the country is : ${resp['payload']['country'][index]['name']}');
                                      print(
                                          'Selected ID of the country is : ${resp['payload']['country'][index]['id']}');
                                    },
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(
                                          3.0.w, 3.0.w, 3.0.w, 0.0),
                                      height: 12.0.w,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(7.0),
                                        // color: Color(0xFFF3F5F9),
                                        color: Colors.blueGrey,
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            left: 3.5.w, top: 3.5.w),
                                        child: Text(
                                          '${resp['payload']['country'][index]['name']}',
                                          textAlign: TextAlign.start,
                                          style: kDataSingleSelectionBottomNav,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                child: FloatingActionButton(
                  child: Icon(FontAwesomeIcons.plus),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getCountryListAPI() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    print('Connectivity Result is : $connectivityResult');

    if ((connectivityResult == ConnectivityResult.mobile) ||
        (connectivityResult == ConnectivityResult.wifi)) {
      resp = await getCountryList();
      print('Response for change password api is : $resp');

      respStatus = resp['success'];
      respMessage = resp['message'];

      if (respStatus) {
        // Do something to load data for country list from here..
        setState(() {
          arrCount = resp['payload']['country'].length;
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
          content:
              Text("Please check your internet connectivity and try again"),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
}
