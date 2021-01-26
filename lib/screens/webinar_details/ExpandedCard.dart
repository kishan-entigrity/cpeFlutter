import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

class ExpandedCard extends StatelessWidget {
  ExpandedCard(
      {@required this.strTitle,
      @required this.cardChild,
      @required this.flagExpand,
      @required this.onPress});

  final String strTitle;
  final Widget cardChild;
  final bool flagExpand;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Color(0xFFF3F5F9),
      ),
      // child: Center(
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: onPress,
            child: Container(
              padding: const EdgeInsets.all(10.0),
              width: double.infinity,
              height: 12.5.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Color(0xFFF3F5F9),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    strTitle,
                    style: TextStyle(
                      fontFamily: 'Whitney Semi Bold',
                      fontSize: 13.5.sp,
                      color: Colors.black,
                    ),
                  ),
                  Icon(
                    flagExpand
                        ? FontAwesomeIcons.caretUp
                        : FontAwesomeIcons.caretDown,
                    color: Colors.black,
                    size: 15.0,
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: flagExpand ? true : false,
            child: cardChild,
          ),
        ],
      ),
    );
  }
}
