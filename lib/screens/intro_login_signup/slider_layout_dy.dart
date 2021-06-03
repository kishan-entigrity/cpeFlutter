import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../constant.dart';

class SliderLayoutDY extends StatelessWidget {
  SliderLayoutDY(this.imgPath, this.strTitle, this.description);

  final String imgPath;
  final String strTitle;
  final String description;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      type: MaterialType.transparency,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Container(
                // color: Colors.red,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0.w),
                  // child: Image.asset('assets/slider_1.png'),
                  // child: Image.asset('$imgPath'),
                  child: FadeInImage(
                    placeholder: AssetImage('assets/slider_1.png'),
                    image: NetworkImage(imgPath),
                    // fit: BoxFit.fill,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Text(
                  // 'FREE CPE/CE WEBINARS',
                  strTitle,
                  style: kDataSliderTitle,
                ),
                SizedBox(
                  height: 3.0.w,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0.w),
                  child: Text(
                    // 'Live & On-Demand courses for CPAs, Tax Pros, Auditors, Bookkeepers & Finance Pros.',
                    description,
                    textAlign: TextAlign.center,
                    style: kDataSliderData,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
