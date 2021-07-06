import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share/share.dart';
import 'package:sizer/sizer.dart';

import '../../constant.dart';

class TransactionPdfPreview extends StatefulWidget {
  TransactionPdfPreview(this.strUrl, this.strTitle);

  final String strUrl;
  final String strTitle;

  @override
  _TransactionPdfPreviewState createState() => _TransactionPdfPreviewState(strUrl, strTitle);
}

class _TransactionPdfPreviewState extends State<TransactionPdfPreview> {
  _TransactionPdfPreviewState(this.strUrl, this.strTitle);

  final String strUrl;
  final String strTitle;

  bool _isLoading = true;
  PDFDocument document;

  bool loading = false;

  // double progress = 0;

  // double progress = 0;
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
    FirebaseAnalytics().setCurrentScreen(screenName: 'Receipt preview screen');
    print('Url on get intent is : $strUrl');
    loadDocument();

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

  loadDocument() async {
    // document = await PDFDocument.fromAsset('assets/sample.pdf');
    document = await PDFDocument.fromURL(
      "$strUrl",
      cacheManager: CacheManager(
        Config(
          "customCacheKey",
          stalePeriod: const Duration(days: 2),
          maxNrOfCacheObjects: 10,
        ),
      ),
    );

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 70.0,
                padding: EdgeInsets.symmetric(horizontal: 5.0.sp),
                width: double.infinity,
                child: Row(
                  children: <Widget>[
                    Flexible(
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
                    Flexible(
                      child: Center(
                        child: Text(
                          'Receipt',
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
                      child: GestureDetector(
                        onTap: () {
                          print('Click event for share receipt');
                          // Share.share('$strUrl');
                          Share.share(strUrl);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            FontAwesomeIcons.shareAlt,
                            size: 12.0.sp,
                          ),
                        ),
                      ),
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
              loading
                  ? Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Expanded(
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            top: 0.0.sp,
                            bottom: 15.0.h,
                            right: 0.0.sp,
                            left: 0.0.sp,
                            child: Container(
                              child: Center(
                                child: _isLoading
                                    ? Center(child: CircularProgressIndicator())
                                    : PDFViewer(
                                        document: document,
                                        zoomSteps: 1,
                                      ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0.0.sp,
                            right: 0.0.sp,
                            left: 0.0.sp,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 12.0.sp),
                              height: 15.0.h,
                              // color: Colors.teal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Download',
                                    style: kButtonLabelTextStyle,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      print('Clicked on download button');
                                      // downloadReceipt();
                                      /*Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DownloadSample(),
                                  ),
                                );*/
                                      // downloadFile();
                                      final status = await Permission.storage.request();

                                      if (status.isGranted) {

                                        // final externalDir = await getExternalStorageDirectory();

                                        final id = await FlutterDownloader.enqueue(
                                          url:
                                              // "https://firebasestorage.googleapis.com/v0/b/storage-3cff8.appspot.com/o/2020-05-29%2007-18-34.mp4?alt=media&token=841fffde-2b83-430c-87c3-2d2fd658fd41",
                                              "$strUrl",
                                          // savedDir: externalDir.path,
                                          // savedDir: Platform.isAndroid ? externalDir.path : (await getApplicationDocumentsDirectory()).path,
                                          savedDir: Platform.isAndroid ? (await getExternalStorageDirectory()).path : (await getApplicationDocumentsDirectory()).path,
                                          // fileName: "download",
                                          fileName: "receipt_$strTitle.pdf",
                                          showNotification: true,
                                          openFileFromNotification: true,
                                        );
                                        if(Platform.isIOS) {
                                          Share.shareFiles(['${(await getApplicationDocumentsDirectory()).path}/receipt_$strTitle.pdf'],text: 'receipt_$strTitle.pdf');
                                        }
                                      } else {
                                        print("Permission deined");
                                      }
                                    },
                                    child: Container(
                                      height: 40.0.sp,
                                      width: 40.0.sp,
                                      padding: EdgeInsets.symmetric(vertical: 10.0.sp),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40.0.sp),
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
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
