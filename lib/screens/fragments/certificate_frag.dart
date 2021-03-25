import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:cpe_flutter/constant.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../rest_api.dart';
import 'model_credit/credit_model.dart';

class CertificateFrag extends StatefulWidget {
  @override
  _CertificateFragState createState() => _CertificateFragState();
}

class _CertificateFragState extends State<CertificateFrag> {
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

  final Dio dio = Dio();
  bool loading = false;
  double progress = 0;

  Future<List<My_credits>> getMyTransactionList(String authToken, String start, String limit, String filterType) async {
    // String urls = 'https://my-cpe.com/api/v3/my-credits';
    String urls = URLs.BASE_URL + 'my-credits';

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
    checkForInternet();

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
                              child: (listCredit != null && listCredit.isNotEmpty)
                                  ? ListView.builder(
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
                                              : Container(
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
                                                              for (int i = 0; i < listCredit[index].certificateLink.length; i++) {
                                                                downloadFile(index, i);
                                                              }
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
                                        );
                                      },
                                    )
                                  : (listCredit != null && listCredit.isNotEmpty)
                                      ? Center(
                                          child: Text(
                                            'Oops no data found for this user..',
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
    );
  }

  void clickEventAll() {
    setState(() {
      filterType = '';
      if (!isAllSelected) {
        isLoaderShowing = true;
        isAllSelected = true;
        isLiveSelected = false;
        isSSSelected = false;
        isLoaderShowing = false;
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
        isLoaderShowing = false;
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
        isLoaderShowing = false;
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
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Please check your internet connectivity and try again"),
          duration: Duration(seconds: 5),
        ),
      );
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
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text(sharedPrefsNot),
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }

  Future<bool> saveVideo(String url, String fileName) async {
    Directory directory;
    try {
      if (Platform.isAndroid) {
        if (await _requestPermission(Permission.storage)) {
          directory = await getExternalStorageDirectory();
          String newPath = "";
          print(directory);
          List<String> paths = directory.path.split("/");
          for (int x = 1; x < paths.length; x++) {
            String folder = paths[x];
            if (folder != "Android") {
              newPath += "/" + folder;
            } else {
              break;
            }
          }
          newPath = newPath + "/MyCPE";
          directory = Directory(newPath);
        } else {
          return false;
        }
      } else {
        if (await _requestPermission(Permission.photos)) {
          directory = await getTemporaryDirectory();
        } else {
          return false;
        }
      }
      File saveFile = File(directory.path + "/$fileName");
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      if (await directory.exists()) {
        await dio.download(url, saveFile.path, onReceiveProgress: (value1, value2) {
          // await dio.download(){
          setState(() {
            progress = value1 / value2;
          });
        });
        if (Platform.isIOS) {
          await ImageGallerySaver.saveFile(saveFile.path, isReturnPathOfIOS: true);
        }
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
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

  void downloadFile(int index, int i) async {
    setState(() {
      loading = true;
      progress = 0;
      strUrl = listCredit[index].myCertificateLinks[i].certificateLink.toString();
      strTitle = listCredit[index].webinarTitle + '_' + listCredit[index].myCertificateLinks[i].certificateType.toString() + '.pdf';
      print('STR URL IS : $strUrl');
    });
    bool downloaded = await saveVideo(strUrl, strTitle);
    if (downloaded) {
      print("File Downloaded");
    } else {
      print("Problem Downloading File");
    }
    setState(() {
      loading = false;
    });
  }
}
