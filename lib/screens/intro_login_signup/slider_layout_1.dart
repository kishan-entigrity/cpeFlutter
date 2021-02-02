import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../constant.dart';

class SliderLayout1 extends StatelessWidget {
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
                  padding:
                      EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0.w),
                  child: Image.asset('assets/slider_1.png'),
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Text(
                  'FREE CPE/CE WEBNARS',
                  style: kDataSliderTitle,
                ),
                SizedBox(
                  height: 3.0.w,
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0.w),
                  child: Text(
                    'Live & On-Demand courses for CPAs, Tax Pros, Auditors, Bookkeepers & Finance Pros.',
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
