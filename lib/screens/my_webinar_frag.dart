import 'package:cpe_flutter/constant.dart';
import 'package:flutter/material.dart';

class MyWebinarFrag extends StatefulWidget {
  @override
  _MyWebinarFragState createState() => _MyWebinarFragState();
}

class _MyWebinarFragState extends State<MyWebinarFrag> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MyWebinar Frag Screen',
          style: kTextTitleFragc,
        ),
      ),
    );
  }
}
