import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WebinarTitle_OnDemand extends StatelessWidget {
  WebinarTitle_OnDemand(this.webinar_title);

  final String webinar_title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 10.0,
        left: 10.0,
      ),
      child: Text(
        webinar_title,
        maxLines: 2,
        style: TextStyle(
          fontFamily: 'Whitney Bold',
          fontSize: 22.0,
          color: Colors.black,
        ),
      ),
    );
  }
}
