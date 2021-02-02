import 'package:cpe_flutter/screens/intro_login_signup/slider_image_1.dart';
import 'package:cpe_flutter/screens/intro_login_signup/slider_image_2.dart';
import 'package:cpe_flutter/screens/intro_login_signup/slider_image_3.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../constant.dart';

class IntroScreen extends StatefulWidget {
  // Initialize the variables here..

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  PageController _controller = PageController(initialPage: 0);

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
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
                  children: [
                    SliderImage1(),
                    SliderImage2(),
                    SliderImage3(),
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
                color: Colors.black45,
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
          ],
        ),
      ),
    );
  }
}
