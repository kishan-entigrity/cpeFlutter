import 'dart:isolate';
import 'dart:ui';

import 'package:cpe_flutter/constant.dart';
import 'package:cpe_flutter/screens/profile/who_should_attend.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';

class childCardDetails extends StatefulWidget {
  childCardDetails(this.resp, this.isGuestMode, this.status);

  final resp;
  final bool isGuestMode;
  final String status;

  @override
  _childCardDetailsState createState() => _childCardDetailsState(resp, isGuestMode, status);
}

class _childCardDetailsState extends State<childCardDetails> {
  _childCardDetailsState(this.resp, this.isGuestMode, this.status);

  final resp;
  final bool isGuestMode;
  final String status;

  var cost,
      credit = '',
      ceCredit = '',
      cpeCredit = '',
      cfpCredit = '',
      cpdCredit = '',
      duration = 0,
      irsCourseId = '',
      ctecCourseId = '',
      subjectArea = '',
      courseLevel = '',
      insructionalMethod = '',
      prerequisites = '',
      advancePreparation = '',
      recordDate = '',
      publishedDate = '',
      presentationHandsout = '',
      keyTerms = '',
      instructionalDocuments = '';

  List<String> whoShouldAttend;
  List<String> audiance_titles;

  var webDetailsObj;
  var costVal;

  bool isRowVisible = false;
  bool isCourseIdVisible = false;

  bool isFirst = false;
  bool isSecond = false;
  bool isThird = false;
  bool isFourth = false;

  var strWhoTitle_1 = '', strWhoTitle_2 = '', strWhoTitle_3 = '', strWhoTitle_4 = '';

  int progress = 0;
  ReceivePort _receivePort = ReceivePort();

  static downloadingCallback(id, status, progress) {
    ///Looking up for a send port
    SendPort sendPort = IsolateNameServer.lookupPortByName("downloading");

    ///ssending the data
    sendPort.send([id, status, progress]);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('init State childCardDetails Cost : $cost');
    print('init State childCardDetails resp : $resp');

    var webinarThumb = resp['payload']['webinar_detail']['webinar_thumbnail'];
    print('initState cardChildDetails Webinar Thumb : $webinarThumb');
    setState(() {
      webDetailsObj = resp['payload']['webinar_detail'];

      cost = webDetailsObj['cost'];
      credit = webDetailsObj['credit'];
      ceCredit = webDetailsObj['ce_credit'];
      cfpCredit = webDetailsObj['cfp_credit'];
      cpdCredit = webDetailsObj['cpd_credit'];
      irsCourseId = webDetailsObj['course_id'];
      ctecCourseId = webDetailsObj['ctec_course_id'];
      duration = webDetailsObj['duration'];
      subjectArea = webDetailsObj['subject_area'];
      courseLevel = webDetailsObj['course_level'];
      insructionalMethod = webDetailsObj['instructional_method'];
      prerequisites = webDetailsObj['prerequisite'];
      advancePreparation = webDetailsObj['advance_preparation'];
      recordDate = webDetailsObj['recorded_date'];
      publishedDate = webDetailsObj['published_date'];

      calculateHrs(duration);

      // WhoShouldAttend section..
      var streetsFromJson = webDetailsObj['who_should_attend'];
      whoShouldAttend = new List<String>.from(streetsFromJson);

      // audiance_titles section..
      var audienceFromJson = webDetailsObj['audiance_titles'];
      audiance_titles = new List<String>.from(audienceFromJson);

      int length = whoShouldAttend.length;
      print('Size for who should attend : $length');

      if (length == 1) {
        isFirst = true;
        isSecond = false;
        isThird = false;
        isFourth = false;

        strWhoTitle_1 = whoShouldAttend[0];
        strWhoTitle_2 = '';
        strWhoTitle_3 = '';
        strWhoTitle_4 = '';
      } else if (length == 2) {
        isFirst = true;
        isSecond = true;
        isThird = false;
        isFourth = false;

        strWhoTitle_1 = whoShouldAttend[0];
        strWhoTitle_2 = whoShouldAttend[1];
        strWhoTitle_3 = '';
        strWhoTitle_4 = '';
      } else if (length == 1) {
        isFirst = true;
        isSecond = true;
        isThird = true;
        isFourth = false;

        strWhoTitle_1 = whoShouldAttend[0];
        strWhoTitle_2 = whoShouldAttend[1];
        strWhoTitle_3 = whoShouldAttend[2];
        strWhoTitle_4 = '';
      } else {
        isFirst = true;
        isSecond = true;
        isThird = true;
        isFourth = true;

        int showCount = length - 3;

        strWhoTitle_1 = whoShouldAttend[0];
        strWhoTitle_2 = whoShouldAttend[1];
        strWhoTitle_3 = whoShouldAttend[2];
        strWhoTitle_4 = '+$showCount more';
      }
    });

    IsolateNameServer.registerPortWithName(_receivePort.sendPort, "downloading");

    ///Listening for the data is comming other isolataes
    _receivePort.listen((message) {
      setState(() {
        progress = message[2];
      });

      print(progress);
    });

    FlutterDownloader.registerCallback(downloadingCallback);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      width: double.infinity,
      child: Column(
        children: <Widget>[
          detailsRowString('Cost', cost == '' ? 'Free' : '\$$cost', true),
          detailsRowString('CPE Credits', '$credit', credit?.isEmpty ? false : true),
          detailsRowString('CE Credits', '$ceCredit', ceCredit?.isEmpty ? false : true),
          detailsRowString('CPD Credits', '$cpdCredit', cpdCredit?.isEmpty ? false : true),
          detailsRowString('IRS Course Id', '$irsCourseId', irsCourseId?.isEmpty ? false : true),
          detailsRowString('CTEC Course Id', '$ctecCourseId', ctecCourseId?.isEmpty ? false : true),
          detailsRowString('Duration', calculateHrs(duration), true),
          detailsRowString('Subject Area', '$subjectArea', true),
          detailsRowString('Course Level', '$courseLevel', true),
          detailsRowString('Instructional Method', '$insructionalMethod', true),
          detailsRowString('Prerequisites', '$prerequisites', true),
          detailsRowString('Advance Preparation', '$advancePreparation', true),
          detailsRowString('Recorded Date', '$recordDate', recordDate?.isEmpty ? false : true),
          detailsRowString('Published Date', '$publishedDate', publishedDate?.isEmpty ? false : true),
          Visibility(
            visible: (isGuestMode || status.toLowerCase() == 'register webinar' || status.toLowerCase() == 'register') ? false : true,
            child: detailsRowDownload('Presentation Handouts', true, webDetailsObj),
          ),
          detailsRowDownload('Key Terms', true, webDetailsObj),
          detailsRowDownload('Instructional Document', true, webDetailsObj),
          detailsRowTags('Qualifications', audiance_titles.length > 0 ? true : false, webDetailsObj, audiance_titles),
          // detailsRowTags('Who should attend?', true, webDetailsObj, whoShouldAttend),
          detailsRowWhoShouldAttend('Who should attend?', true, isFirst, isSecond, isThird, isFourth, strWhoTitle_1, strWhoTitle_2, strWhoTitle_3,
              strWhoTitle_4, whoShouldAttend),
          // divider(),
        ],
      ),
    );
  }

  String calculateHrs(int duration) {
    if (duration > 60) {
      var d = Duration(minutes: duration);
      List<String> parts = d.toString().split(':');
      return '${parts[0].padLeft(2, '0')} Hour ${parts[1].padLeft(2, '0')} mins';
    } else {
      return '$duration mins';
    }
  }
}

class detailsRowWhoShouldAttend extends StatelessWidget {
  detailsRowWhoShouldAttend(this.strKey, this.isRowVisible, this.isFirst, this.isSecond, this.isThird, this.isFourth, this.strWhoTitle_1,
      this.strWhoTitle_2, this.strWhoTitle_3, this.strWhoTitle_4, this.whoShouldAttend);

  final String strKey;
  final bool isRowVisible;
  final bool isFirst;
  final bool isSecond;
  final bool isThird;
  final bool isFourth;
  final String strWhoTitle_1;
  final String strWhoTitle_2;
  final String strWhoTitle_3;
  final String strWhoTitle_4;
  final List<String> whoShouldAttend;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isRowVisible,
      child: Column(
        children: <Widget>[
          ConstrainedBox(
            constraints: BoxConstraints(minHeight: 40.0, minWidth: double.infinity),
            child: Row(
              children: <Widget>[
                Flexible(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                    width: 165.0,
                    child: Text(
                      strKey,
                      style: kKeyLableWebinarDetailExpand,
                    ),
                  ),
                ),
                Flexible(
                  child: Column(
                    children: <Widget>[
                      whoShouldAttendCell('$strWhoTitle_1'),
                      whoShouldAttendCell('$strWhoTitle_2'),
                      whoShouldAttendCell('$strWhoTitle_3'),
                      GestureDetector(
                        onTap: () {
                          print('Clicked on the +more');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WhoShouldAttend(whoShouldAttend),
                            ),
                          );
                        },
                        child: whoShouldAttendCell('$strWhoTitle_4'),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class whoShouldAttendCell extends StatelessWidget {
  whoShouldAttendCell(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5.0),
      height: 28.0,
      width: 160.0,
      decoration: BoxDecoration(
        color: themeYellow,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Center(
        child: Text(
          '$title',
          // overflow: TextOverflow.ellipsis,
          style: kDownloadWebinarDetailExpand,
        ),
      ),
    );
  }
}

class detailsRowTags extends StatefulWidget {
  detailsRowTags(this.strKey, this.isRowVisible, this.webDetailsObj, this.audiance_titles);

  final String strKey;
  final bool isRowVisible;
  final webDetailsObj;
  final List<String> audiance_titles;

  @override
  _detailsRowTagsState createState() => _detailsRowTagsState(strKey, isRowVisible, webDetailsObj, audiance_titles);
}

class _detailsRowTagsState extends State<detailsRowTags> {
  _detailsRowTagsState(this.strKey, this.isRowVisible, this.webDetailsObj, this.audiance_titles);

  final String strKey;
  final bool isRowVisible;
  final webDetailsObj;
  final List<String> audiance_titles;

  bool loading = false;
  double progress = 0;
  var strUrl = '';
  var strTitle = '';

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.isRowVisible,
      child: Column(
        children: <Widget>[
          ConstrainedBox(
            constraints: BoxConstraints(minHeight: 40.0, minWidth: double.infinity),
            child: Row(
              children: <Widget>[
                Flexible(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                    width: 165.0,
                    child: Text(
                      widget.strKey,
                      style: kKeyLableWebinarDetailExpand,
                    ),
                  ),
                ),
                Flexible(
                  /*child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 28.0,
                      width: 110.0,
                      decoration: BoxDecoration(
                        color: themeYellow,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Center(
                        child: Text(
                          'Download',
                          // overflow: TextOverflow.ellipsis,
                          style: kDownloadWebinarDetailExpand,
                        ),
                      ),
                    ),
                  ),*/
                  child: Wrap(
                    children: List.generate(
                      audiance_titles.length,
                      (i) {
                        return Container(
                          // margin: EdgeInsets.symmetric(horizontal: 4.0, vertical: 0.0),
                          margin: EdgeInsets.only(right: 4.0),
                          child: Chip(
                            backgroundColor: themeYellow,
                            padding: EdgeInsets.all(0.0),
                            label: Container(
                              child: Text(
                                '${audiance_titles[i].toString()}',
                                style: TextStyle(
                                  fontSize: 8.0.sp,
                                  color: Colors.white,
                                  fontFamily: 'Whitney Medium',
                                ),
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
          divider(),
        ],
      ),
    );
  }
}

class detailsRowDownload extends StatefulWidget {
  detailsRowDownload(this.strKey, this.isRowVisible, this.webDetailsObj);

  final String strKey;
  final bool isRowVisible;
  final webDetailsObj;

  @override
  _detailsRowDownloadState createState() => _detailsRowDownloadState(strKey, isRowVisible, webDetailsObj);
}

class _detailsRowDownloadState extends State<detailsRowDownload> {
  _detailsRowDownloadState(this.strKey, this.isRowVisible, this.webDetailsObj);

  final String strKey;
  final bool isRowVisible;
  final webDetailsObj;

  bool loading = false;
  double progress = 0;
  var strUrl = '';
  var strTitle = '';

  final Dio dio = Dio();

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.isRowVisible,
      child: Column(
        children: <Widget>[
          ConstrainedBox(
            constraints: BoxConstraints(minHeight: 40.0, minWidth: double.infinity),
            child: Row(
              children: <Widget>[
                Flexible(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                    width: 165.0,
                    child: Text(
                      widget.strKey,
                      style: kKeyLableWebinarDetailExpand,
                    ),
                  ),
                ),
                Flexible(
                  child: GestureDetector(
                    onTap: () {
                      if (widget.strKey == 'Presentation Handouts') {
                        print('Clicked on download presentation handsout');
                        if (webDetailsObj['presentation_handout'].length == 0) {
                          print('No data for handsout material');
                        } else {
                          if (webDetailsObj['presentation_handout'].length > 1) {
                            // We have multiple documents to download..
                            showHandsoutList();
                          } else {
                            // We have only single document to download..
                            downloadHandsoutFile(0);
                          }
                        }
                      } else if (widget.strKey == 'Key Terms') {
                        print('Clicked on download key terms');
                        downloadKeyTerms();
                      } else if (widget.strKey == 'Instructional Document') {
                        print('Clicked on download instructional document');
                        downloadInstructionalDocuments();
                      }
                    },
                    child: Container(
                      height: 28.0,
                      width: 110.0,
                      decoration: BoxDecoration(
                        color: themeYellow,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Center(
                        child: Text(
                          'Download',
                          // overflow: TextOverflow.ellipsis,
                          style: kDownloadWebinarDetailExpand,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          divider(),
        ],
      ),
    );
  }

  void showHandsoutList() {
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
                                'Presentation Handsout',
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
                        itemCount: webDetailsObj['presentation_handout'].length,
                        itemBuilder: (context, pos) {
                          return ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: 15.0.w,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  // clickEventOrgSize(pos);
                                  clickEventHandsoutMaterial(pos);
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.fromLTRB(3.0.w, 3.0.w, 3.0.w, 0.0),
                                decoration: BoxDecoration(
                                  // color:
                                  // selectedCertificateType == webDetailsObj['my_certificate_links'][pos]['certificate_type'] ? themeYellow : testColor,
                                  color: themeYellow,
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
                                          // webDetailsObj['presentation_handout'][pos],
                                          'Handout Material ${pos + 1}',
                                          // webDetailsObj['my_certificate_links'][pos]['certificate_type'],
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

  void clickEventHandsoutMaterial(int pos) {
    downloadHandsoutFile(pos);
    Navigator.pop(context);
  }

  void downloadHandsoutFile(int pos) async {
    final status = await Permission.storage.request();

    if (status.isGranted) {
      final externalDir = await getExternalStorageDirectory();
      String handsOutUrl = webDetailsObj['presentation_handout'][pos];
      print('Just before downloading url for presentation handsout is : $handsOutUrl');
      final id = await FlutterDownloader.enqueue(
        url:
            // "https://firebasestorage.googleapis.com/v0/b/storage-3cff8.appspot.com/o/2020-05-29%2007-18-34.mp4?alt=media&token=841fffde-2b83-430c-87c3-2d2fd658fd41",
            "$handsOutUrl",
        savedDir: externalDir.path,
        // fileName: "download",
        fileName: "Handsout_Material_${pos + 1}_${webDetailsObj['webinar_title']}.pdf",
        showNotification: true,
        openFileFromNotification: true,
      );
    } else {
      print("Permission deined");
    }
  }

  void downloadInstructionalDocuments() async {
    final status = await Permission.storage.request();

    if (status.isGranted) {
      final externalDir = await getExternalStorageDirectory();

      final id = await FlutterDownloader.enqueue(
        url: "${webDetailsObj['instructional_docuement']}",
        savedDir: externalDir.path,
        // fileName: "download",
        fileName: "Instructional_Documents_${webDetailsObj['webinar_title']}.pdf",
        showNotification: true,
        openFileFromNotification: true,
      );
    } else {
      print("Permission deined");
    }
  }

  void downloadKeyTerms() async {
    final status = await Permission.storage.request();

    if (status.isGranted) {
      final externalDir = await getExternalStorageDirectory();

      final id = await FlutterDownloader.enqueue(
        url: "${webDetailsObj['key_terms']}",
        savedDir: externalDir.path,
        // fileName: "download",
        fileName: "Key_Terms_${webDetailsObj['webinar_title']}.pdf",
        showNotification: true,
        openFileFromNotification: true,
      );
    } else {
      print("Permission deined");
    }
  }
}

class detailsRowString extends StatelessWidget {
  detailsRowString(this.strKey, this.strVal, this.isRowVisible);

  final String strKey;
  final String strVal;
  final bool isRowVisible;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isRowVisible,
      child: Column(
        children: <Widget>[
          ConstrainedBox(
            constraints: BoxConstraints(minHeight: 11.0.w, minWidth: double.infinity),
            child: Row(
              children: <Widget>[
                Flexible(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                    width: 165.0,
                    child: Text(
                      strKey,
                      style: kKeyLableWebinarDetailExpand,
                      /*style: TextStyle(
                        fontFamily: 'Whitney Medium',
                        fontSize: 14.0.sp,
                        color: black50,
                      ),*/
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                      strVal,
                      // overflow: TextOverflow.ellipsis,
                      style: kValueLableWebinarDetailExpand,
                    ),
                  ),
                ),
              ],
            ),
          ),
          divider(),
        ],
      ),
    );
  }
}

class divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.5,
      width: double.infinity,
      color: Colors.black,
    );
  }
}
