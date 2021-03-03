import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';

class DownloadSample extends StatefulWidget {
  @override
  _DownloadSampleState createState() => _DownloadSampleState();
}

class _DownloadSampleState extends State<DownloadSample> {
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
        "https://my-cpe.com/front_side/live_paid_receipt/MyCpe-live-webinars-debt-forgiveness-and-section-108-1611776820-561252728.pdf",
        // "video.mp4");
        "certificate1");
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
                          'Download Sample',
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
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          FontAwesomeIcons.shareAlt,
                          size: 0.0.sp,
                        ),
                      ),
                      flex: 1,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: 0.5,
                  color: Colors.white,
                  child: Center(
                    child: loading
                        ? /*Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: LinearProgressIndicator(
                              minHeight: 10,
                              value: progress,
                            ),
                          )*/
                        Center(
                            child: CircularProgressIndicator(),
                          )
                        : GestureDetector(
                            onTap: () {
                              downloadFile();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10.0.sp, horizontal: 20.0.sp),
                              color: Colors.teal,
                              child: Text(
                                'Download',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                    /*FlatButton.icon(
                              icon: Icon(
                                Icons.download_rounded,
                                color: Colors.white,
                              ),
                              color: Colors.blue,
                              onPressed: downloadFile,
                              padding: const EdgeInsets.all(10),
                              label: Text(
                                "Download Video",
                                style: TextStyle(color: Colors.white, fontSize: 25),
                              ),
                            )*/

                    /*child: GestureDetector(
                      onTap: () {
                        print('Clicked on Download button');
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10.0.sp, horizontal: 20.0.sp),
                        color: Colors.teal,
                        child: Text(
                          'Download',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),*/
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
