import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:cpe_flutter/constant.dart';
import 'package:cpe_flutter/screens/intro_login_signup/login.dart';
import 'package:cpe_flutter/screens/webinar_details/pdf_preview_certificate.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../rest_api.dart';
import 'model_credit/credit_model.dart';

class CertificateFrag extends StatefulWidget {
  final bool isFromProfile;
  final void Function(int) onButtonPressed;

  // const CertificateFrag({Key key, this.isFromProfile, this.onButtonPressed});
  const CertificateFrag(this.isFromProfile, this.onButtonPressed);

  // CertificateFrag(this.isFromProfile);

  // final bool isFromProfile;

  @override
  _CertificateFragState createState() => _CertificateFragState(isFromProfile);
}

class _CertificateFragState extends State<CertificateFrag> {
  _CertificateFragState(this.isFromProfile);

  final bool isFromProfile;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController _scrollController = new ScrollController();
  bool isLoaderShowing = false;
  String _authToken = "";

  bool isAllSelected = false;
  bool isLiveSelected = false;
  bool isSSSelected = false;

  List<My_credits> listCredit;

  bool isLast = false;
  int start = 0;
  var data;
  int arrCount = 0;
  var data_web;
  var filterType = '';
  var strUrl = '';
  var strTitle = '';

  bool loading = false;
  double progress = 0;

  var selectedCertificateType = '';

  Future<List<My_credits>> getMyTransactionList(String authToken, String start, String limit, String filterType) async {
    // String urls = 'https://my-cpe.com/api/v3/my-credits';
    var urls = Uri.parse(URLs.BASE_URL + 'my-credits');

    final response = await http.post(
      urls,
      headers: {
        'Accept': 'Application/json',
        'Authorization': '$authToken',
      },
      body: {
        'filter_type': filterType,
        'start': start,
        'limit': limit,
      },
    );

    this.setState(() {
      // data = JSON.decode(response.body);
      if (response.statusCode == 401) {
        logoutUser();
      }

      data = jsonDecode(response.body);
      isLoaderShowing = false;
      if (data['payload']['is_last']) {
        isLast = true;
      } else {
        isLast = false;
      }
    });

    // print(data[1]["title"]);
    print('API response is : $data');
    arrCount = data['payload']['my_credits'].length;
    data_web = data['payload']['my_credits'];
    print('Size for array is : $arrCount');

    if (listCredit != null && listCredit.isNotEmpty) {
      listCredit.addAll(List.from(data_web).map<My_credits>((item) => My_credits.fromJson(item)).toList());
    } else {
      listCredit = List.from(data_web).map<My_credits>((item) => My_credits.fromJson(item)).toList();
    }

    return listCredit;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('Enter into myTransaction screen');
    FirebaseAnalytics().setCurrentScreen(screenName: 'My Certificate Screen');
    checkForInternet();

    print('State fot the isFromProfile : $isFromProfile');

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        print('Scroll Controller is called here status for isLast is : $isLast');
        if (!isLast) {
          start = start + 10;
          print('Val for Start is : $start || Status for isLast is : $isLast');
          this.getMyTransactionList('$_authToken', '$start', '10', filterType);
        } else {
          print('val for isLast : $isLast');
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      body: new WillPopScope(
          child: SafeArea(
            child: Column(
              children: <Widget>[
                Container(
                  height: 70.0,
                  width: double.infinity,
                  child: Row(
                    children: <Widget>[
                      Visibility(
                        visible: isFromProfile ? true : false,
                        child: Flexible(
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
                      ),
                      Flexible(
                        child: Center(
                          child: Text(
                            'My Certificates',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.5.sp,
                              fontFamily: 'Whitney Semi Bold',
                            ),
                          ),
                        ),
                        flex: 8,
                      ),
                      Flexible(
                        child: Text(''),
                        flex: 1,
                      ),
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
                    color: Colors.white,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 25.0.sp,
                                // margin: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 5.0.w),
                                margin: EdgeInsets.all(4.0.w),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: testColor,
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          clickEventAll();
                                        },
                                        child: Container(
                                          height: double.infinity,
                                          margin: isAllSelected ? EdgeInsets.all(1.0) : EdgeInsets.all(0.0),
                                          decoration: BoxDecoration(
                                            color: isAllSelected ? themeBlueLight : testColor,
                                            borderRadius: BorderRadius.circular(6.0),
                                          ),
                                          child: Center(
                                            child: Text(
                                              'All',
                                              style: TextStyle(
                                                fontSize: 10.0.sp,
                                                color: isAllSelected ? Colors.white : Colors.black87,
                                                fontFamily: 'Whitney Medium',
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: isAllSelected
                                          ? false
                                          : isLiveSelected
                                              ? false
                                              : true,
                                      child: Container(
                                        height: double.infinity,
                                        width: 0.5,
                                        color: Colors.black45,
                                        margin: EdgeInsets.symmetric(vertical: 3.5.sp),
                                      ),
                                    ),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          clickEventLive();
                                        },
                                        child: Container(
                                          height: double.infinity,
                                          margin: isLiveSelected ? EdgeInsets.all(1.0) : EdgeInsets.all(0.0),
                                          decoration: BoxDecoration(
                                            color: isLiveSelected ? themeBlueLight : testColor,
                                            borderRadius: BorderRadius.circular(6.0),
                                          ),
                                          child: Center(
                                            child: Text(
                                              'Live',
                                              style: TextStyle(
                                                fontSize: 10.0.sp,
                                                color: isLiveSelected ? Colors.white : Colors.black87,
                                                fontFamily: 'Whitney Medium',
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: isSSSelected
                                          ? false
                                          : isLiveSelected
                                              ? false
                                              : true,
                                      child: Container(
                                        height: double.infinity,
                                        width: 0.5,
                                        color: Colors.black45,
                                        margin: EdgeInsets.symmetric(vertical: 3.5.sp),
                                      ),
                                    ),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          clickEventSS();
                                        },
                                        child: Container(
                                          margin: isSSSelected ? EdgeInsets.all(1.0) : EdgeInsets.all(0.0),
                                          height: double.infinity,
                                          decoration: BoxDecoration(
                                            color: isSSSelected ? themeBlueLight : testColor,
                                            borderRadius: BorderRadius.circular(6.0),
                                          ),
                                          child: Center(
                                            child: Text(
                                              'Self-Study',
                                              style: TextStyle(
                                                fontSize: 10.0.sp,
                                                color: isSSSelected ? Colors.white : Colors.black87,
                                                fontFamily: 'Whitney Medium',
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 4.0.w),
                                    child: isLoaderShowing
                                        ? Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : (listCredit != null && listCredit.isNotEmpty)
                                            ? RefreshIndicator(
                                                onRefresh: () {
                                                  print('On refresh is called..');
                                                  start = 0;
                                                  listCredit.clear();
                                                  return this.getMyTransactionList('$_authToken', '$start', '10', filterType);
                                                },
                                                child: ListView.builder(
                                                  physics: AlwaysScrollableScrollPhysics(),
                                                  controller: _scrollController,
                                                  shrinkWrap: true,
                                                  itemCount: listCredit.length + 1,
                                                  itemBuilder: (context, index) {
                                                    return ConstrainedBox(
                                                      constraints: BoxConstraints(
                                                        minHeight: 50.0,
                                                      ),
                                                      child: (index == listCredit.length)
                                                          ? isLast
                                                              ? Container(
                                                                  height: 20.0,
                                                                )
                                                              : Padding(
                                                                  padding: EdgeInsets.symmetric(vertical: 20.0),
                                                                  child: Center(
                                                                    child: CircularProgressIndicator(),
                                                                  ),
                                                                )
                                                          : GestureDetector(
                                                              onTap: () {
                                                                print('Clicked on position : ${listCredit[index].webinarId}');
                                                                funRedirectListDetailsCert(index);
                                                              },
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(10.0),
                                                                  color: testColor,
                                                                  // color: Colors.blueGrey,
                                                                ),
                                                                margin: EdgeInsets.only(bottom: 8.0.sp),
                                                                padding: EdgeInsets.symmetric(
                                                                  vertical: 15.0,
                                                                  horizontal: 10.0,
                                                                ),
                                                                child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: <Widget>[
                                                                    Text(
                                                                      '${listCredit[index].webinarTitle}',
                                                                      style: TextStyle(
                                                                        fontSize: 14.5.sp,
                                                                        fontFamily: 'Whitney Medium',
                                                                      ),
                                                                    ),
                                                                    Row(
                                                                      children: <Widget>[
                                                                        Container(
                                                                          child: Text(
                                                                            '${listCredit[index].speakerName}',
                                                                            style: TextStyle(
                                                                              color: Colors.black87,
                                                                              fontSize: 11.5.sp,
                                                                              fontFamily: 'Whitney Medium',
                                                                            ),
                                                                          ),
                                                                          width: 42.0.w,
                                                                        ),
                                                                        Container(
                                                                          child: Text(
                                                                            '${listCredit[index].hostDate}',
                                                                            style: TextStyle(
                                                                              color: Color(0x501F2227),
                                                                              fontSize: 11.5.sp,
                                                                              fontFamily: 'Whitney Medium',
                                                                            ),
                                                                          ),
                                                                          width: 34.0.w,
                                                                        ),
                                                                        GestureDetector(
                                                                          onTap: () {
                                                                            print('Clicked on position : ${listCredit[index].webinarId}');
                                                                            funRedirectListDetailsCert(index);
                                                                          },
                                                                          child: Container(
                                                                            height: 30.0.sp,
                                                                            width: 30.0.sp,
                                                                            decoration: BoxDecoration(
                                                                              color: themeYellow,
                                                                              borderRadius: BorderRadius.circular(30.0.sp),
                                                                            ),
                                                                            padding: EdgeInsets.all(10.0),
                                                                            /*child: Icon(
                                                                      FontAwesomeIcons.download,
                                                                      color: Colors.white,
                                                                      size: 11.0.sp,
                                                                    ),*/
                                                                            child: Image.asset(
                                                                              'assets/download.png',
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                    );
                                                  },
                                                ),
                                              )
                                            : Center(
                                                child: Text(
                                                  'Oops no data found for this user..',
                                                  style: kValueLableWebinarDetailExpand,
                                                ),
                                              )),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          child: Visibility(
                            visible: loading ? true : false,
                            child: Container(
                              child: Center(
                                child: CircularProgressIndicator(
                                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.black),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          onWillPop: _onWillPop),
    );
  }

  Future<bool> _onWillPop() {
    return isFromProfile ? popFunction() : redirectToHomeTab();
    /*showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomDialogTwo(
                "Confirm Exit?",
                "Are you sure you want to exit the app?",
                "Yes",
                "No",
                () {
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                },
                () {
                  Navigator.pop(context);
                },
              );
            });*/
    /*showDialog(
              context: context,
              builder: (context) => new AlertDialog(
                title: new Text('Confirm Exit?', style: new TextStyle(color: Colors.black, fontSize: 20.0)),
                content: new Text('Are you sure you want to exit the app?'),
                actions: <Widget>[
                  new FlatButton(
                    onPressed: () {
                      // this line exits the app.
                      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                    },
                    child: new Text('Yes', style: new TextStyle(fontSize: 18.0)),
                  ),
                  new FlatButton(
                    onPressed: () => Navigator.pop(context),
                    // this line dismisses the dialog
                    child: new Text('No', style: new TextStyle(fontSize: 18.0)),
                  )
                ],
              ),
            ) ??
            false;*/
  }

  void clickEventAll() {
    setState(() {
      filterType = '';
      if (!isAllSelected) {
        isLoaderShowing = true;
        isAllSelected = true;
        isLiveSelected = false;
        isSSSelected = false;
        // isLoaderShowing = false;
        listCredit.clear();
        start = 0;
        this.getMyTransactionList('$_authToken', '$start', '10', filterType);
      }
    });
  }

  void clickEventLive() {
    setState(() {
      filterType = '1';
      if (!isLiveSelected) {
        isLoaderShowing = true;
        isAllSelected = false;
        isLiveSelected = true;
        isSSSelected = false;
        // isLoaderShowing = false;
        listCredit.clear();
        start = 0;
        this.getMyTransactionList('$_authToken', '$start', '10', filterType);
      }
    });
  }

  void clickEventSS() {
    setState(() {
      filterType = '2';
      if (!isSSSelected) {
        isLoaderShowing = true;
        isAllSelected = false;
        isLiveSelected = false;
        isSSSelected = true;
        // isLoaderShowing = false;
        listCredit.clear();
        start = 0;
        this.getMyTransactionList('$_authToken', '$start', '10', filterType);
      }
    });
  }

  void checkForInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if ((connectivityResult == ConnectivityResult.mobile) || (connectivityResult == ConnectivityResult.wifi)) {
      checkForSP();
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

  void checkForSP() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool checkValue = preferences.getBool("check");

    if (checkValue != null) {
      setState(() {
        isLoaderShowing = true;
      });

      if (checkValue) {
        String token = preferences.getString("spToken");
        _authToken = 'Bearer $token';
        print('Auth Token from SP is : $_authToken');

        isAllSelected = true;
        this.getMyTransactionList('$_authToken', '$start', '10', filterType);
      } else {
        preferences.clear();
        Fluttertoast.showToast(
            msg: sharedPrefsNot,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: toastBackgroundColor,
            textColor: toastTextColor,
            fontSize: 16.0);
        /*_scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text(sharedPrefsNot),
            duration: Duration(seconds: 3),
          ),
        );*/
      }
    }
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }

  void logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    // Navigator.pushAndRemoveUntil(context, newRoute, (route) => false)
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => Login(false),
        ),
        (Route<dynamic> route) => false);
  }

  popFunction() {
    Navigator.pop(context);
  }

  void funRedirectListDetailsCert(int index) {
    if (listCredit[index].myCertificateLinks.length > 1) {
      print('There are multiple certificates..');
      showCertificateList(index);
    } else {
      print('There is only single certificate.. Data is : ${listCredit[index].myCertificateLinks[0].certificateLink}');
      // if (webDetailsObj['my_certificate_links'][pos]['certificate_link'] == '') {
      if (listCredit[index].myCertificateLinks[0].certificateLink == '') {
        print('Entered into empty string option');
        Fluttertoast.showToast(
            msg: strCouldntFindCertificateLink,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: toastBackgroundColor,
            textColor: toastTextColor,
            fontSize: 16.0);
        /*_scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text(strCouldntFindCertificateLink),
            duration: Duration(seconds: 3),
          ),
        );*/
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CertificatePdfPreview(
                // '${listCredit[index].certificateLink[0]}', '${listCredit[index].webinarTitle}', '${listCredit[index].webinarCreditType}'),
                '${listCredit[index].myCertificateLinks[0].certificateLink}',
                '${listCredit[index].webinarTitle}',
                '${listCredit[index].webinarCreditType}'),
          ),
        );
      }
    }
  }

  void showCertificateList(int index) {
    setState(() {
      selectedCertificateType = '';
    });

    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return StatefulBuilder(
            builder: (BuildContext context, void Function(void Function()) setState) {
              return Container(
                height: 60.0.w,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 17.0.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            width: 50.0.w,
                            child: Center(
                              child: Text(
                                'Certificates List',
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
                    Expanded(
                      child: ListView.builder(
                        // itemCount: orgSizeList.length,
                        itemCount: listCredit[index].myCertificateLinks.length,
                        itemBuilder: (context, pos) {
                          return ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: 15.0.w,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  clickEventOrgSize(index, pos);
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.fromLTRB(3.0.w, 3.0.w, 3.0.w, 0.0),
                                decoration: BoxDecoration(
                                  color:
                                      selectedCertificateType == listCredit[index].myCertificateLinks[pos].certificateType ? themeYellow : testColor,
                                  // color: themeYellow,
                                  borderRadius: BorderRadius.circular(7.0),
                                  // color: Colors.teal,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 3.5.w, horizontal: 3.5.w),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          // list[index].shortTitle,
                                          // orgSizeList[index],
                                          listCredit[index].myCertificateLinks[pos].certificateType,
                                          textAlign: TextAlign.start,
                                          style: kDataSingleSelectionBottomNav,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        });
  }

  void clickEventOrgSize(int index, int pos) {
    setState(() {
      selectedCertificateType = listCredit[index].myCertificateLinks[pos].certificateType.toString();
      Navigator.pop(context);

      if (listCredit[index].myCertificateLinks[pos].certificateLink == '') {
        Fluttertoast.showToast(
            msg: strCouldntFindCertificateLink,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: toastBackgroundColor,
            textColor: toastTextColor,
            fontSize: 16.0);
        /*_scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text(strCouldntFindCertificateLink),
            duration: Duration(seconds: 3),
          ),
        );*/
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CertificatePdfPreview(
              '${listCredit[index].myCertificateLinks[pos].certificateLink}',
              '${listCredit[index].webinarTitle}',
              '${listCredit[index].myCertificateLinks[pos].certificateType}',
            ),
          ),
        );
      }
    });
  }

  redirectToHomeTab() {
    widget.onButtonPressed(0);
  }
}
