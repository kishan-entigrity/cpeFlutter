import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';

class childCardWhyShouldAttend extends StatelessWidget {
  childCardWhyShouldAttend(this.strWhyShouldAttend);

  final String strWhyShouldAttend;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      width: double.infinity,
      child: Text(
        strWhyShouldAttend,
        style: TextStyle(
          fontFamily: 'Whitney Medium',
          fontSize: 13.5.sp,
          color: Color(0x701F2227),
        ),
      ),
    );
  }
}
