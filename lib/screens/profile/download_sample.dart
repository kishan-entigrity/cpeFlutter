import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

class DownloadSample extends StatefulWidget {
  @override
  _DownloadSampleState createState() => _DownloadSampleState();
}

class _DownloadSampleState extends State<DownloadSample> {
  bool loading = false;
  double progress = 0;

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
                              // downloadFile();
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
