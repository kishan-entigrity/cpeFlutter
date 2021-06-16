import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TopBar extends StatelessWidget {
  TopBar(this.colour, this.strTitle);

  final Color colour;
  final String strTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.0,
      width: double.infinity,
      // color: Colors.white,
      color: colour,
      child: Row(
        children: <Widget>[
          // BackIcon(),
          Flexible(
            flex: 2,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Icon(
                  FontAwesomeIcons.angleLeft,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 12,
            child: Center(
              child: Text(
                // 'Webinar Details',
                strTitle,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontFamily: 'Whitney Semi Bold',
                ),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Text(''),
          ),
        ],
      ),
    );
  }
}
