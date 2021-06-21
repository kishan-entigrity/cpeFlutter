import 'package:cpe_flutter/screens/intro_login_signup/splash_screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:sizer/sizer_util.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await FlutterDownloader.initialize(debug: true // optional: set false to disable printing logs to console);
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      //return LayoutBuilder
      builder: (context, constraints) {
        return OrientationBuilder(
          //return OrientationBuilder
          builder: (context, orientation) {
            //initialize SizerUtil()
            SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                statusBarColor: Color(0xF0F3F5F9), statusBarIconBrightness: Brightness.dark //or set color with: Color(0xFF0000FF)
                ));
            SizerUtil().init(constraints, orientation); //initialize SizerUtil
            return MaterialApp(
              // title: 'Flutter Demo',
              navigatorObservers: [
                FirebaseAnalyticsObserver(analytics: analytics),
              ],
              theme: ThemeData(
                primarySwatch: Colors.blueGrey,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              // home: MyHomePage(title: 'Flutter Demo Home Page'),
              home: SplashScreen(),
            );
          },
        );
      },
    );
  }
}
