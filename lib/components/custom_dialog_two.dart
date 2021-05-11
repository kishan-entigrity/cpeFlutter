import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../constant.dart';

class CustomDialogTwo extends StatelessWidget {
  final String title, description, btn1, btn2;
  final Function onPress1, onPress2;

  CustomDialogTwo(this.title, this.description, this.btn1, this.btn2, this.onPress1, this.onPress2);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0.sp),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 50.0.sp,
          maxHeight: 200.0.sp,
        ),
        child: Container(
          width: double.infinity,
          // height: 160.0.sp,
          margin: EdgeInsets.fromLTRB(10.0.sp, 4.0.sp, 10.0.sp, 4.0.sp),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                offset: Offset(0, 0),
                blurRadius: 0,
              ),
            ],
          ),
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 4.0.w,
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Whitney Bold',
                    fontSize: 14.0.sp,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 4.0.w,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 6.0.w),
                  child: Text(
                    description,
                    style: TextStyle(
                      fontFamily: 'Whitney Medium',
                      fontSize: 12.0.sp,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  height: 25.0.sp,
                  // margin: EdgeInsets.symmetric(horizontal: 4.0.w),
                  margin: EdgeInsets.only(left: 4.0.w, right: 4.0.w, bottom: 4.0.w, top: 6.0.w),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                          onTap: onPress1,
                          child: Container(
                            height: double.infinity,
                            margin: EdgeInsets.only(right: 2.0.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7.0),
                              color: themeYellow,
                            ),
                            child: Center(
                              child: Text(
                                btn1,
                                style: kDataLoginSignUpSlider,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: onPress2,
                          child: Container(
                            margin: EdgeInsets.only(left: 2.0.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7.0),
                              color: themeBlue,
                            ),
                            child: Center(
                              child: Text(
                                btn2,
                                style: kDataLoginSignUpSlider,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            /*child: Stack(
              children: <Widget>[
                Positioned(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 4.0.w,
                      ),
                      Text(
                        title,
                        style: TextStyle(
                          fontFamily: 'Whitney Bold',
                          fontSize: 14.0.sp,
                          color: themeBlueLight,
                        ),
                      ),
                      SizedBox(
                        height: 4.0.w,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 4.0.w),
                        child: Text(
                          description,
                          style: TextStyle(
                            fontFamily: 'Whitney Medium',
                            fontSize: 12.0.sp,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 4.0.w,
                  right: 0,
                  left: 0,
                  child: Container(
                    height: 25.0.sp,
                    margin: EdgeInsets.symmetric(horizontal: 4.0.w),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: GestureDetector(
                            onTap: onPress1,
                            child: Container(
                              height: double.infinity,
                              margin: EdgeInsets.only(right: 2.0.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.0),
                                color: themeYellow,
                              ),
                              child: Center(
                                child: Text(
                                  btn1,
                                  style: kDataLoginSignUpSlider,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: onPress2,
                            child: Container(
                              margin: EdgeInsets.only(left: 2.0.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.0),
                                color: themeBlue,
                              ),
                              child: Center(
                                child: Text(
                                  btn2,
                                  style: kDataLoginSignUpSlider,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),*/
          ),
        ),
      ),
    );
  }
}
