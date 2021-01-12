import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class childCardDescription extends StatelessWidget {
  childCardDescription(this.strDescription, this.strLearningObjective);

  final String strDescription;
  final String strLearningObjective;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Html(
            data: strDescription,
            defaultTextStyle: TextStyle(
              fontFamily: 'Whitney Medium',
              fontSize: 18.0,
              color: Color(0x701F2227),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            'LEARNING OBJECTIVES',
            style: TextStyle(
              fontFamily: 'Whitney Semi Bold',
              fontSize: 18.0,
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Html(
            data: strLearningObjective,
            defaultTextStyle: TextStyle(
              fontFamily: 'Whitney Medium',
              fontSize: 18.0,
              color: Color(0x701F2227),
            ),
          ),
        ],
      ),
    );
  }
}
