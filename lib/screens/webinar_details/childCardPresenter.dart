import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class childCardPresenter extends StatelessWidget {
  childCardPresenter(
      this.strPresenterPic,
      this.strPresenterName,
      this.strPresenterQualification,
      this.strPresenterDesignation,
      this.strPresenterCompany,
      this.strPresenterDetails);

  final String strPresenterPic;
  final String strPresenterName;
  final String strPresenterQualification;
  final String strPresenterDesignation;
  final String strPresenterCompany;
  final String strPresenterDetails;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CircleAvatar(
                radius: 40.0,
                backgroundImage: NetworkImage(strPresenterPic),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 10.0,
                  right: 10.0,
                  top: 5.0,
                ),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '$strPresenterName $strPresenterQualification',
                      // 'Hello world Hello world Hello world Hello world Hello world Hello world Hello world Hello world Hello world Hello world',
                      // 'Hello world Hello',
                      style: TextStyle(
                        fontFamily: 'Whitney Bold',
                        fontSize: 18.0,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '$strPresenterCompany, $strPresenterDesignation',
                      style: TextStyle(
                        fontFamily: 'Whitney Medium',
                        fontSize: 17.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          padding:
              EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
          margin: EdgeInsets.only(left: 10.0, right: 10.0),
          width: double.infinity,
          child: Html(
            data: '$strPresenterDetails',
            defaultTextStyle: TextStyle(
              fontFamily: 'Whitney Medium',
              fontSize: 18.0,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
