import 'package:cpe_flutter/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeFrag extends StatefulWidget {
  @override
  _HomeFragState createState() => _HomeFragState();
}

class _HomeFragState extends State<HomeFrag> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home Frag Screen',
          style: kTextTitleFragc,
        ),
      ),
    );
  }
}
