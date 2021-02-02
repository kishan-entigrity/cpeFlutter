import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../constant.dart';

class SliderImage2 extends StatelessWidget {
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
                  child: Image.asset('assets/slider_2.png'),
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Text(
                  'Updated Courses & Content',
                  style: kDataSliderTitle,
                ),
                SizedBox(
                  height: 3.0.w,
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0.w),
                  child: Text(
                    'Get latest tax updates & content via our Live & On-Demand Webinars.',
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
