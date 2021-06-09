import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
// import 'package:flutter_html/style.dart';
import 'package:sizer/sizer.dart';

import '../../constant.dart';

class childCardDescription extends StatelessWidget {
  childCardDescription(this.strDescription, this.strLearningObjective);

  final String strDescription;
  final String strLearningObjective;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          /*RichText(
            text: TextSpan(
              text: '$strDescription',
              style: TextStyle(
                fontFamily: 'Whitney Medium',
                fontSize: 13.5.sp,
                color: Color(0x701F2227),
              ),
            ),
          ),*/
          Html(
            data: strDescription,
            /*style: {
              "body": Style(
                fontFamily: 'Whitney Medium',
                fontSize: FontSize(13.5.sp),
                color: Color(0x701F2227),
              ),
            },*/
            defaultTextStyle: kDetailsStyle,
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            'LEARNING OBJECTIVES',
            style: TextStyle(
              fontFamily: 'Whitney Semi Bold',
              fontSize: 13.5.sp,
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          /*RichText(
            text: TextSpan(
              text: '$strLearningObjective',
              style: TextStyle(
                fontFamily: 'Whitney Medium',
                fontSize: 13.5.sp,
                color: Color(0x701F2227),
              ),
            ),
          ),*/
          Html(
            data: strLearningObjective,
            /*style: {
              "body": Style(
                fontFamily: 'Whitney Medium',
                fontSize: FontSize(13.5.sp),
                color: Color(0x701F2227),
              ),
            },*/
            defaultTextStyle: kDetailsStyle,
          ),
        ],
      ),
    );
  }
}
