import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SliderImage4 extends StatelessWidget {
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
                  padding: EdgeInsets.all(1.0.w),
                  child: Image.asset('assets/slider_1.png'),
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Text(
                  'FREE CPE/CE WEBNARS',
                  style: TextStyle(
                    fontFamily: 'Whitney Bold',
                    fontSize: 17.0.sp,
                    color: Color(0xFF013872),
                  ),
                ),
                SizedBox(
                  height: 3.0.w,
                ),
                Text(
                  'Live & On-Demand courses for CPAs, Tax Pros, Auditors, Bookkeepers & Finance Pros.',
                  style: TextStyle(
                    fontFamily: 'Whitney Medium',
                    fontSize: 12.0.sp,
                    color: Color(0xFF0F2138),
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
