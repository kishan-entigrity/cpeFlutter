import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class WebinarSpeakerName_OnDemand extends StatelessWidget {
  WebinarSpeakerName_OnDemand(this.presenter_name);

  final String presenter_name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 5.0,
        left: 10.0,
      ),
      child: Text(
        presenter_name,
        maxLines: 2,
        style: TextStyle(
          fontFamily: 'Whitney Bold',
          fontSize: 13.0.sp,
          color: Colors.black,
        ),
      ),
    );
  }
}
