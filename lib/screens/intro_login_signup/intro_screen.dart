import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../constant.dart';
import 'login.dart';
import 'slider_layout_1.dart';
import 'slider_layout_2.dart';
import 'slider_layout_3.dart';

class IntroScreen extends StatefulWidget {
  // Initialize the variables here..

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  PageController _controller = PageController(initialPage: 0);

  double posPager = 0;

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Material(
          type: MaterialType.transparency,
          child: SafeArea(
            child: Stack(
              children: [
                // Layout for the PageViewer..
                Positioned(
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: Color(0xF0F3F5F9),
                    padding: EdgeInsets.fromLTRB(0.0.w, 10.0.w, 0.0.w, 44.0.w),
                    child: PageView(
                      controller: _controller,
                      onPageChanged: _onPageViewChange,
                      children: [
                        SliderLayout1(),
                        SliderLayout2(),
                        SliderLayout3(),
                      ],
                    ),
                  ),
                ),
                // Layout for the bottom buttons Login/SignUp..
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  height: 30.0.w,
                  child: Container(
                    // color: Colors.black45,
                    margin: EdgeInsets.symmetric(
                        vertical: 8.5.w, horizontal: 4.0.w),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Login(),
                                ),
                              );
                            },
                            child: Container(
                              height: double.infinity,
                              margin: EdgeInsets.only(right: 2.0.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.0),
                                color: themeYellow,
                              ),
                              child: Center(
                                child: Text(
                                  'Login',
                                  style: kDataLoginSignUpSlider,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Login(),
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 2.0.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.0),
                                color: themeBlue,
                              ),
                              child: Center(
                                child: Text(
                                  'Sign Up',
                                  style: kDataLoginSignUpSlider,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Layout for the Top,Right corner skip button..
                Positioned(
                  top: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      print('Clicked on skip button..');
                    },
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                      child: Text(
                        'skip',
                        style: kTextLableLoginUnderline,
                      ),
                    ),
                  ),
                ),
                // Positioned(child: DotsIndicator(),
                Positioned(
                  bottom: 35.0.w,
                  right: 0,
                  left: 0,
                  child: DotsIndicator(
                    dotsCount: 3,
                    // position: _controller.page,
                    position: posPager,
                    // position: 1,
                    decorator: DotsDecorator(
                      color: Colors.black87, // Inactive color
                      activeColor: Colors.redAccent,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        onWillPop: _onWillPop);
  }

  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Confirm Exit?',
                style: new TextStyle(color: Colors.black, fontSize: 20.0)),
            content: new Text('Are you sure you want to exit the app?'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () {
                  // this line exits the app.
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                },
                child: new Text('Yes', style: new TextStyle(fontSize: 18.0)),
              ),
              new FlatButton(
                onPressed: () =>
                    Navigator.pop(context), // this line dismisses the dialog
                child: new Text('No', style: new TextStyle(fontSize: 18.0)),
              )
            ],
          ),
        ) ??
        false;
  }

  void _onPageViewChange(int page) {
    print("Current Page: " + page.toString());
    setState(() {
      // posPager = value + .0;
      posPager = page.toDouble();
    });
  }
}
