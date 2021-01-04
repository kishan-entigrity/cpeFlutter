// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BackIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Flexible(
        flex: 2,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Icon(
            FontAwesomeIcons.angleLeft,
          ),
        ),
      ),
    );
  }
}
