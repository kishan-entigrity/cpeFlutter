import 'package:cpe_flutter/constant.dart';
import 'package:cpe_flutter/screens/video_player/videoPlayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class childWebinarStatus extends StatelessWidget {
  childWebinarStatus(this.status, this.isSingleStatusRow, this.webDetailsObj);

  final String status;
  final bool isSingleStatusRow;
  final webDetailsObj;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 15.5.w,
      width: double.infinity,
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Visibility(
            visible: isSingleStatusRow ? true : false,
            child: GestureDetector(
              onTap: () {
                print('Clicked on large button status');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VideoPlayerFlickker(webDetailsObj),
                  ),
                );
              },
              child: Container(
                height: 10.2.w,
                margin: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: themeYellow,
                ),
                child: Center(
                  child: Text(
                    convertCamelCase(status),
                    style: kWebinarStatusBig,
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: isSingleStatusRow ? false : true,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      print('Clicked on small button status');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              VideoPlayerFlickker(webDetailsObj),
                        ),
                      );
                    },
                    child: Container(
                      height: 10.2.w,
                      margin: EdgeInsets.only(
                          top: 10.0, bottom: 10.0, left: 10.0, right: 5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: themeYellow,
                      ),
                      child: Center(
                        child: Text(
                          convertCamelCase(status),
                          style: kWebinarStatusSmall,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 10.2.w,
                    margin: EdgeInsets.only(
                        top: 10.0, bottom: 10.0, right: 10.0, left: 5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: themeBlueLight,
                    ),
                    child: Center(
                      child: Text(
                        'Review Question',
                        style: kWebinarStatusSmall,
                      ),
                    ),
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