import 'dart:io';

import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
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

  final Dio dio = Dio();
  bool loading = false;
  double progress = 0;

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

  downloadFile() async {
    setState(() {
      loading = true;
      progress = 0;
    });
    bool downloaded = await saveVideo(
        // "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4",
        //   "https://my-cpe.com/front_side/live_paid_receipt/MyCpe-live-webinars-debt-forgiveness-and-section-108-1611776820-561252728.pdf",
        strUrl,
        // "video.mp4");
        // "certificate1");
        strTitle);
    if (downloaded) {
      print("File Downloaded");
    } else {
      print("Problem Downloading File");
    }
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('Url on get intent is : $strUrl');
    loadDocument();
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
                    GestureDetector(
                      onTap: () {
                        print('Click event for share receipt');
                        Share.share('$strUrl');
                      },
                      child: Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            FontAwesomeIcons.shareAlt,
                            size: 12.0.sp,
                          ),
                        ),
                        flex: 1,
                      ),
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
                                    onTap: () {
                                      print('Clicked on download button');
                                      // downloadReceipt();
                                      /*Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DownloadSample(),
                                  ),
                                );*/
                                      downloadFile();
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

  void downloadReceipt() async {
    try {
      Response response = await Dio().get("$strUrl");
      print(response);
    } catch (e) {
      print(e);
    }
  }
}
