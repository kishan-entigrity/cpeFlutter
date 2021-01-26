import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:sizer/sizer.dart';

class childCardCompany extends StatelessWidget {
  childCardCompany(this.presenterObj);

  final presenterObj;

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
                radius: 10.5.w,
                backgroundImage: NetworkImage(presenterObj['company_logo']),
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
                      presenterObj['company_name'],
                      maxLines: 5,
                      softWrap: true,
                      style: TextStyle(
                        fontFamily: 'Whitney Bold',
                        fontSize: 13.5.sp,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      presenterObj['company_website'],
                      style: TextStyle(
                        fontFamily: 'Whitney Medium',
                        fontSize: 13.0.sp,
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
            data: presenterObj['company_desc'],
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
