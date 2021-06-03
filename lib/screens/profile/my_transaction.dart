import 'dart:convert';
import 'dart:isolate';
import 'dart:ui';

import 'package:cpe_flutter/screens/intro_login_signup/login.dart';
import 'package:cpe_flutter/screens/profile/pagination_my_transaction/my_transaction_list.dart';
import 'package:cpe_flutter/screens/profile/pdf_preview_transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../constant.dart';
import '../../rest_api.dart';

class MyTranscation extends StatefulWidget {
  @override
  _MyTranscationState createState() => _MyTranscationState();
}

class _MyTranscationState extends State<MyTranscation> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController _scrollController = new ScrollController();
  bool isLoaderShowing = false;
  String _authToken = "";

  int start = 0;
  var data;

  bool isLast = false;

  List<Transaction> list;
  int arrCount = 0;
  var data_web;

  int progress = 0;
  ReceivePort _receivePort = ReceivePort();

  static downloadingCallback(id, status, progress) {
    ///Looking up for a send port
    SendPort sendPort = IsolateNameServer.lookupPortByName("downloading");

    ///ssending the data
    sendPort.send([id, status, progress]);
  }

  Future<List<Transaction>> getMyTransactionList(String authToken, String start, String limit) async {
    // String urls = 'https://my-cpe.com/api/v3/payment-transaction';
    var urls = Uri.parse(URLs.BASE_URL + 'payment-transaction');

    final response = await http.post(
      urls,
      headers: {
        'Accept': 'Application/json',
        'Authorization': '$authToken',
      },
      body: {
        'start': start,
        'limit': limit,
      },
    );

    this.setState(() {
      if (response.statusCode == 401) {
        logoutUser();
      }
      // data = JSON.decode(response.body);
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
    arrCount = data['payload']['transaction'].length;
    data_web = data['payload']['transaction'];
    print('Size for array is : $arrCount');

    if (list != null && list.isNotEmpty) {
      list.addAll(List.from(data_web).map<Transaction>((item) => Transaction.fromJson(item)).toList());
    } else {
      list = List.from(data_web).map<Transaction>((item) => Transaction.fromJson(item)).toList();
    }

    // return "Success!";
    return list;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('Enter into myTransaction screen');
    // Get API call for my transaction..
    checkForSP();

    IsolateNameServer.registerPortWithName(_receivePort.sendPort, "downloading");

    ///Listening for the data is comming other isolataes
    _receivePort.listen((message) {
      setState(() {
        progress = message[2];
      });

      print(progress);
    });

    FlutterDownloader.registerCallback(downloadingCallback);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        print('Scroll Controller is called here status for isLast is : $isLast');
        if (!isLast) {
          start = start + 10;
          print('Val for Start is : $start || Status for isLast is : $isLast');
          this.getMyTransactionList('$_authToken', '$start', '10');
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
                        // 'My Transcation',
                        'My Receipts',
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
                // color: Colors.teal,
                // child: Text('Hello World'),
                child: (list != null && list.isNotEmpty)
                    // child: !isLoaderShowing
                    ? RefreshIndicator(
                        onRefresh: () {
                          print('On refresh is called..');
                          start = 0;
                          list.clear();
                          return this.getMyTransactionList('$_authToken', '$start', '10');
                        },
                        child: ListView.builder(
                          physics: AlwaysScrollableScrollPhysics(),
                          controller: _scrollController,
                          shrinkWrap: true,
                          // itemCount: arrCount,
                          itemCount: list.length + 1,
                          // itemCount: strTitles.length,
                          itemBuilder: (context, index) {
                            return ConstrainedBox(
                              constraints: BoxConstraints(
                                minHeight: 50.0,
                              ),
                              child: (index == list.length)
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
                                        print('Clicked on the webinar title : ${list[index].title} || and ID : ${list[index].webinarId}');
                                        // So Basically we can handle the click event for the selected tile from here..
                                        var strUrl = list[index].receipt;
                                        if (strUrl.isNotEmpty) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => TransactionPdfPreview('${list[index].receipt}', '${list[index].title}'),
                                            ),
                                          );
                                        } else {
                                          Fluttertoast.showToast(
                                              msg: strCouldntFindReceiptLink,
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: toastBackgroundColor,
                                              textColor: toastTextColor,
                                              fontSize: 16.0);
                                          /*_scaffoldKey.currentState.showSnackBar(
                                            SnackBar(
                                              content: Text(strCouldntFindReceiptLink),
                                              duration: Duration(seconds: 3),
                                            ),
                                          );*/
                                        }
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10.0),
                                          // color: Colors.blueGrey,
                                          color: Color(0xFFF3F5F9),
                                        ),
                                        margin: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                                        // padding: EdgeInsets.all(10.0),
                                        padding: EdgeInsets.symmetric(
                                          vertical: 15.0,
                                          horizontal: 10.0,
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              '${list[index].title}',
                                              style: TextStyle(
                                                fontSize: 15.0.sp,
                                                fontFamily: 'Whitney Medium',
                                              ),
                                            ),
                                            Text(
                                              'Tr ID #: ${list[index].transactionId}',
                                              style: TextStyle(
                                                fontSize: 12.0.sp,
                                                fontFamily: 'Whitney Medium',
                                                color: Color(0x501F2227),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 10.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  Row(
                                                    children: <Widget>[
                                                      Container(
                                                        margin: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 0.0, right: 10.0),
                                                        padding: EdgeInsets.symmetric(vertical: 4.0.sp, horizontal: 18.0.sp),
                                                        decoration: BoxDecoration(
                                                          color: themeBlueLight,
                                                          borderRadius: BorderRadius.circular(4.0),
                                                        ),
                                                        child: Text(
                                                          '\$ ${list[index].amount}',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontFamily: 'Whitney Semibold',
                                                            fontSize: 12.0.sp,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Text(
                                                          '${list[index].paymentDate}',
                                                          style: TextStyle(
                                                            color: Color(0x501F2227),
                                                            fontFamily: 'Whitney Medium',
                                                            fontSize: 12.0.sp,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  GestureDetector(
                                                    onTap: () async {
                                                      print('Clicked on individual download button URL is : ${list[index].receipt}');
                                                      print(
                                                          'Clicked on the webinar title : ${list[index].title} || and ID : ${list[index].webinarId}');
                                                      // So Basically we can handle the click event for the selected tile from here..
                                                      var strUrl = list[index].receipt;
                                                      if (strUrl.isNotEmpty) {
                                                        final status = await Permission.storage.request();

                                                        if (status.isGranted) {
                                                          final externalDir = await getExternalStorageDirectory();

                                                          final id = await FlutterDownloader.enqueue(
                                                            url:
                                                                // "https://firebasestorage.googleapis.com/v0/b/storage-3cff8.appspot.com/o/2020-05-29%2007-18-34.mp4?alt=media&token=841fffde-2b83-430c-87c3-2d2fd658fd41",
                                                                "${list[index].receipt}",
                                                            savedDir: externalDir.path,
                                                            // fileName: "download",
                                                            fileName: "receipt_${list[index].title}.pdf",
                                                            showNotification: true,
                                                            openFileFromNotification: true,
                                                          );
                                                        } else {
                                                          print("Permission deined");
                                                        }
                                                      } else {
                                                        Fluttertoast.showToast(
                                                            msg: strCouldntFindReceiptLink,
                                                            toastLength: Toast.LENGTH_SHORT,
                                                            gravity: ToastGravity.BOTTOM,
                                                            timeInSecForIosWeb: 1,
                                                            backgroundColor: toastBackgroundColor,
                                                            textColor: toastTextColor,
                                                            fontSize: 16.0);
                                                      }
                                                    },
                                                    child: Container(
                                                      height: 32.0.sp,
                                                      width: 32.0.sp,
                                                      padding: EdgeInsets.symmetric(vertical: 12.0),
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(32.0.sp),
                                                        color: themeYellow,
                                                      ),
                                                      child: Image.asset(
                                                        'assets/download.png',
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                            );
                          },
                        ),
                      )
                    : (list != null && list.isEmpty)
                        ? Center(
                            child: Text(
                              'Oops data no data found for this user..',
                              // data['message'],
                              style: kValueLableWebinarDetailExpand,
                            ),
                          )
                        : Container(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
              ),
            ),
          ],
        ),
      ),
    );
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

        // this.getDataWebinarList('$_authToken', '$start', '10');
        this.getMyTransactionList('$_authToken', '$start', '10');
        // print('init State isLive : $isLive');
        // print('init State isSelfStudy : $isSelfStudy');
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
}
