import 'dart:io';

import 'package:cpe_flutter/constant.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';

class childCardDetails extends StatefulWidget {
  childCardDetails(this.resp);
  final resp;

  @override
  _childCardDetailsState createState() => _childCardDetailsState(resp);
}

class _childCardDetailsState extends State<childCardDetails> {
  _childCardDetailsState(this.resp);
  final resp;

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

  var webDetailsObj;
  var costVal;

  bool isRowVisible = false;
  bool isCourseIdVisible = false;

  bool isFirst = false;
  bool isSecond = false;
  bool isThird = false;
  bool isFourth = false;

  var strWhoTitle_1 = '', strWhoTitle_2 = '', strWhoTitle_3 = '', strWhoTitle_4 = '';

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
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      width: double.infinity,
      child: Column(
        children: <Widget>[
          detailsRowString('Cost', cost.compareTo(0) == 0 ? 'Free' : '\$$cost', true),
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
          detailsRowDownload('Presentation Handouts', true, webDetailsObj),
          detailsRowDownload('Key Terms', true, webDetailsObj),
          detailsRowDownload('Instructional Document', true, webDetailsObj),
          detailsRowWhoShouldAttend(
              'Who should attend?', true, isFirst, isSecond, isThird, isFourth, strWhoTitle_1, strWhoTitle_2, strWhoTitle_3, strWhoTitle_4),
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
      this.strWhoTitle_2, this.strWhoTitle_3, this.strWhoTitle_4);

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
                      whoShouldAttendCell('$strWhoTitle_4'),
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
                        for (int i = 0; i < widget.webDetailsObj['presentation_handout'].length; i++) {
                          downloadFile(i);
                        }
                      } else if (widget.strKey == 'Key Terms') {
                        print('Clicked on download key terms');
                      } else if (widget.strKey == 'Instructional Document') {
                        print('Clicked on download instructional document');
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

  void downloadFile(int i) async {
    setState(() {
      loading = true;
      progress = 0;
      // strUrl = webDetailsObj['presentation_handout'][i].certificateLink.toString();
      strUrl = webDetailsObj['presentation_handout'][i].toString();
      strTitle = 'presentation_handout_' + webDetailsObj['webinar_title'].toString() + '{$i}' + '.pdf';
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
