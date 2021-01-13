import 'package:flutter/cupertino.dart';

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
          fontSize: 18.0,
          color: Color(0x701F2227),
        ),
      ),
    );
  }
}
