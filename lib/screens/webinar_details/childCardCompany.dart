import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class childCardCompany extends StatelessWidget {
  childCardCompany(this.strCompanyPic, this.strCompanyName, this.strCompanySite,
      this.strCompanyDetails);

  final String strCompanyPic;
  final String strCompanyName;
  final String strCompanySite;
  final String strCompanyDetails;

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
                backgroundImage: NetworkImage(strCompanyPic),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 10.0,
                  right: 10.0,
                  top: 5.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '$strCompanyName',
                      maxLines: 5,
                      softWrap: true,
                      style: TextStyle(
                        fontFamily: 'Whitney Bold',
                        fontSize: 18.0,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '$strCompanySite',
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
            data: '$strCompanyDetails',
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
