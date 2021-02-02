import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUpScreen2 extends StatefulWidget {
  @override
  _SignUpScreen2State createState() => _SignUpScreen2State();
}

class _SignUpScreen2State extends State<SignUpScreen2> {
  final scaffoldState = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: scaffoldState,
      backgroundColor: Colors.teal,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Container(
                margin: EdgeInsets.only(top: 20.0),
                child: Text(
                  'Bottom Navigator Sample',
                  style: TextStyle(fontSize: 20.0),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Positioned(
              bottom: 20.0,
              right: 20.0,
              child: GestureDetector(
                onTap: () {
                  print('Clicked on FAB');
                  /*showBottomSheet(
                      context: context,
                      builder: (context) => Container(
                            color: Colors.grey[900],
                            height: 250,
                          ));*/
                  /*showBottomSheet(
                    context: context,
                    builder: (context) => Container(
                      color: Colors.red,
                      height: 100.0,
                    ),
                  );*/
                  scaffoldState.currentState.showBottomSheet(
                    (context) => Container(
                      color: Colors.grey[900],
                      height: 250,
                    ),
                  );
                },
                child: FloatingActionButton(
                  child: Icon(FontAwesomeIcons.plus),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
