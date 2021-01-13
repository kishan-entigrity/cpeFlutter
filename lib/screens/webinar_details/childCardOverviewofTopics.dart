import 'package:flutter/cupertino.dart';
import 'package:flutter_html/flutter_html.dart';

class childCardOverviewofTopics extends StatelessWidget {
  childCardOverviewofTopics(this.strOverviewOfTopics);

  final String strOverviewOfTopics;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      width: double.infinity,
      child: Html(
        data: strOverviewOfTopics,
        defaultTextStyle: TextStyle(
          fontFamily: 'Whitney Medium',
          fontSize: 18.0,
          color: Color(0x701F2227),
        ),
      ),
    );
  }
}
