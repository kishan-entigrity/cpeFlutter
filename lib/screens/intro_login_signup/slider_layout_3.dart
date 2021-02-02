import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../constant.dart';

class SliderLayout3 extends StatelessWidget {
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
                  child: Image.asset('assets/slider_3.png'),
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Text(
                  'Manage your CPE/CE Credits',
                  style: kDataSliderTitle,
                ),
                SizedBox(
                  height: 3.0.w,
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0.w),
                  child: Text(
                    'Get your CPE/CE credits & certificates instantly.',
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
