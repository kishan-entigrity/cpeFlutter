import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ProgressExample extends StatefulWidget {
  final int webinarId;

  ProgressExample(this.webinarId, {Key key}) : super(key: key);

  @override
  _ProgressExampleState createState() => _ProgressExampleState();
}

class _ProgressExampleState extends State<ProgressExample> {
  bool isLoaderShowing = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print(webinar_id);
    String strWebinarId = widget.webinarId.toString();
    print('WebinarId on Intent is : $strWebinarId');
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned(
              bottom: 0.0,
              right: 0.0,
              left: 0.0,
              top: 0.0,
              child: Visibility(
                visible: isLoaderShowing ? true : false,
                child: SpinKitSample(),
              ),
            ),
            Positioned(
              child: Center(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        widget.webinarId.toString(),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        checkToShowHideLoader();
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: 100.0, bottom: 100.0),
                        child: Text(
                          isLoaderShowing ? 'hide' : 'show',
                          style: TextStyle(
                            fontSize: 30.0,
                          ),
                        ),
                      ),
                    ),
                    /*Visibility(
                        visible: isLoaderShowing ? true : false,
                        // child: SpinKitThreeBounce(
                        child: SpinKitSample(),
                      ),*/
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void checkToShowHideLoader() {
    setState(() {
      print('Clicked on text button');
      if (isLoaderShowing) {
        isLoaderShowing = false;
      } else {
        isLoaderShowing = true;
      }
    });
  }
}

class SpinKitSample extends StatelessWidget {
  const SpinKitSample({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpinKitCircle(
      size: 100.0,
      color: Colors.teal,
    );
  }
}
