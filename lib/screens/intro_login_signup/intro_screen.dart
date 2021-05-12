import 'package:connectivity/connectivity.dart';
import 'package:cpe_flutter/components/custom_dialog_two.dart';
import 'package:cpe_flutter/screens/intro_login_signup/signup_screen_1.dart';
import 'package:cpe_flutter/screens/intro_login_signup/slider_layout_dy.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../../const_signup.dart';
import '../../constant.dart';
import '../../rest_api.dart';
import '../home_screen.dart';
import 'login.dart';

class IntroScreen extends StatefulWidget {
  // Initialize the variables here..

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  PageController _controller = PageController(initialPage: 0);

  double posPager = 0;
  bool isLoaderShowing = false;
  var resp;
  var pagesLength = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ConstSignUp.cleanSignUpData();
    getIntroScreensAPI();
  }

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
                    child: PageView.builder(
                      physics: new AlwaysScrollableScrollPhysics(),
                      controller: _controller,
                      onPageChanged: _onPageViewChange,
                      itemBuilder: (BuildContext context, int index) {
                        // return _pages[index % _pages.length];
                        return SliderLayoutDY(
                          // "assets/slider_1.png",
                          resp == "" || resp == null ? "assets/slider_1.png" : "${resp['payload']['screens'][index]['url']}",
                          resp == "" || resp == null ? "FREE CPE/CE WEBINARS" : "${resp['payload']['screens'][index]['title']}",
                          resp == "" || resp == null
                              ? "Live & On-Demand courses for CPAs, Tax Pros, Auditors, Bookkeepers & Finance Pros."
                              : "${resp['payload']['screens'][index]['description']}",
                        );
                      },
                    ),
                    /*child: PageView(
                      controller: _controller,
                      onPageChanged: _onPageViewChange,
                      children: [
                        SliderLayoutDY("assets/slider_1.png", "FREE CPE/CE WEBINARS1",
                            "Live & On-Demand courses for CPAs, Tax Pros, Auditors, Bookkeepers & Finance Pros."),
                        SliderLayoutDY("assets/slider_2.png", "Updated Courses & Content2",
                            "Get latest tax updates & content via our Live & On-Demand Webinars.3"),
                        SliderLayoutDY("assets/slider_3.png", "Manage your CPE/CE Credits", "Get your CPE/CE credits & certificates instantly."),
                        // SliderLayout1(),
                        // SliderLayout2(),
                        // SliderLayout3(),
                      ],
                    ),*/
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
                    margin: EdgeInsets.symmetric(vertical: 8.5.w, horizontal: 4.0.w),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Login(true),
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
                                  builder: (context) => SignUpScreen1(),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                      );
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
                    // dotsCount: 3,
                    // dotsCount: resp['payload']['screens'].length,
                    dotsCount: pagesLength,
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
        builder: (BuildContext context) {
          return CustomDialogTwo(
            "Confirm Exit?",
            "Are you sure you want to exit the app?",
            "Yes",
            "No",
            () {
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            },
            () {
              Navigator.pop(context);
            },
          );
        });
    /*return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Confirm Exit?', style: new TextStyle(color: Colors.black, fontSize: 20.0)),
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
                onPressed: () => Navigator.pop(context), // this line dismisses the dialog
                child: new Text('No', style: new TextStyle(fontSize: 18.0)),
              )
            ],
          ),
        ) ??
        false;*/
  }

  void _onPageViewChange(int page) {
    print("Current Page: " + page.toString());
    setState(() {
      // posPager = value + .0;
      posPager = page.toDouble();
    });
  }

  void getIntroScreensAPI() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if ((connectivityResult == ConnectivityResult.mobile) || (connectivityResult == ConnectivityResult.wifi)) {
      setState(() {
        isLoaderShowing = true;
      });
      resp = await getIntroScreens();
      print(resp);
      setState(() {
        pagesLength = resp['payload']['screens'].length;
        isLoaderShowing = false;
      });
    } else {
      Fluttertoast.showToast(
          msg: "Please check your internet connectivity and try again",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: toastBackgroundColor,
          textColor: toastTextColor,
          fontSize: 16.0);
    }
  }
}
