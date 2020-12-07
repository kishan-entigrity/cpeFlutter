import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WebinarDetails extends StatefulWidget {
  // WebinarDetails(@required this.webinar_id_new);
  // WebinarDetails(this.webinar_id);
  // final String webinar_id_new;
  // final int webinar_id;
  @override
  _WebinarDetailsState createState() => _WebinarDetailsState();
}

class _WebinarDetailsState extends State<WebinarDetails> {
  /*_WebinarDetailsState(@required this.webinar_id);

  final String webinar_id;*/

  @override
  Widget build(BuildContext context) {
    //TODO: implement build
    // throw UnimplementedError();
    return Scaffold(
      backgroundColor: Colors.white,
      /*appBar: AppBar(
        title: Text(
          'Webinar Details',
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
      ),*/
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              height: 70.0,
              width: double.infinity,
              color: Color(0xFFF3F5F9),
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Flexible(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          FontAwesomeIcons.angleLeft,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 8,
                    child: Center(
                      child: Text(
                        'Webinar Details',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontFamily: 'Whitney Semi Bold',
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Text(''),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 0.5,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
