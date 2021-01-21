import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class childCardPresenter extends StatelessWidget {
  childCardPresenter(this.presenterObj);

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
                radius: 40.0,
                backgroundImage: NetworkImage(presenterObj['presenter_image']),
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
                      presenterObj['name'] +
                          ' ' +
                          presenterObj['qualification'],
                      // 'Hello world Hello world Hello world Hello world Hello world Hello world Hello world Hello world Hello world Hello world',
                      // 'Hello world Hello',
                      style: TextStyle(
                        fontFamily: 'Whitney Bold',
                        fontSize: 18.0,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      presenterObj['company_name'] +
                          ' ' +
                          presenterObj['desgnination'],
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
            data: presenterObj['speaker_desc'],
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
