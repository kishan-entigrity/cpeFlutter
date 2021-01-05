import 'dart:ui';

import 'package:connectivity/connectivity.dart';
import 'package:cpe_flutter/components/TopBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../rest_api.dart';

class WebinarDetailsNew extends StatefulWidget {
  WebinarDetailsNew(this.strWebinarTypeIntent, this.webinarId);

  // final String resultText;
  final String strWebinarTypeIntent;
  final int webinarId;

  @override
  _WebinarDetailsNewState createState() =>
      _WebinarDetailsNewState(strWebinarTypeIntent, webinarId);
}

class _WebinarDetailsNewState extends State<WebinarDetailsNew> {
  _WebinarDetailsNewState(this.strWebinarTypeIntent, this.webinarId);

  // final String resultText;
  final String strWebinarTypeIntent;
  final int webinarId;

  String userToken;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  var respStatus;
  var respMessage;

  String webinar_thumb;
  var video_url,
      webinar_title,
      webinar_type,
      webinar_date,
      webinar_status,
      start_date,
      start_time,
      is_card_save,
      credit,
      ce_credit,
      cfp_credit,
      cpd_credit,
      duration;

  var isPlaying = false;

  @override
  void initState() {
    super.initState();
    checkForSP();
  }

  void checkForSP() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool checkValue = sharedPreferences.getBool("check");

    if (checkValue) {
      // Checkvalue == true..
      print('If State for check value : $checkValue');
      // get the value for the userToken from the sharedPrefs..
      userToken = sharedPreferences.getString("spToken");
      print('UserToken on checkForSP is : $userToken');

      // Take API call for webinar Details from here..
      webinarDetailsAPI();
    } else {
      // Chackvalue == false..
      print('Else State for check value : $checkValue');
    }
  }

  void webinarDetailsAPI() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if ((connectivityResult == ConnectivityResult.mobile) ||
        (connectivityResult == ConnectivityResult.wifi)) {
      // Take API call from here..
      String strWebId = webinarId.toString();
      var resp = await getWebinarDetails(userToken, strWebId);

      respStatus = resp['success'];
      respMessage = resp['message'];

      print('Response for webinar details is : $resp');

      if (respStatus) {
        setState(() {
          webinar_thumb =
              resp['payload']['webinar_detail']['webinar_thumbnail'];
          video_url = resp['payload']['webinar_detail']['webinar_video_url'];
          webinar_title = resp['payload']['webinar_detail']['webinar_title'];
          webinar_type = resp['payload']['webinar_detail']['webinar_type'];
          webinar_date = resp['payload']['webinar_detail']['webinar_date'];
          webinar_status = resp['payload']['webinar_detail']['webinar_status'];
          start_date = resp['payload']['webinar_detail']['start_date'];
          start_time = resp['payload']['webinar_detail']['start_time'];
          is_card_save = resp['payload']['webinar_detail']['is_card_save'];
          credit = resp['payload']['webinar_detail']['credit'];
          ce_credit = resp['payload']['webinar_detail']['ce_credit'];
          cfp_credit = resp['payload']['webinar_detail']['cfp_credit'];
          cpd_credit = resp['payload']['webinar_detail']['cpd_credit'];
          duration = resp['payload']['webinar_detail']['duration'];

          /*_controller = VideoPlayerController.network(
            // 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
            video_url,
            // 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
            // 'https://player.vimeo.com//play//1624977747?s=359330135_1609206521_7d8ca704163f13f5a50fddb50b769445&loc=external&context=Vimeo%5CController%5CApi%5CResources%5CVideoController.&download=1&filename=DOES%2BYOUR%2BCLIENT%2BOWN%2BSHARES%2BIN%2BFOREIGN%2BCORPORATION%253F%2BIMPACT%2BOF%2BTJCA174.mp4',
            // 'https://vimeo.com/76979871',

            // Take an API call for getting webinar details..
          );
          print('Video Player playback URL is : $video_url');

          _initializeVideoPlayerFuture = _controller.initialize();
          _controller.setLooping(true); */
        });

        print(
            'Webinar details response : Webinar thumbnail is : $webinar_thumb');
        print('Webinar details response : Webinar video url is : $video_url');
      } else {
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text(respMessage),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } else {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content:
              Text("Please check your internet connectivity and try again"),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      backgroundColor: Colors.teal,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned(
              bottom: 0.0,
              right: 0.0,
              left: 0.0,
              child: Container(
                height: 50.0,
                width: double.infinity,
                color: Colors.grey,
              ),
            ),
            Positioned(
              top: 0.0,
              right: 0.0,
              left: 0.0,
              bottom: 50.0,
              child: Container(
                color: Colors.yellow,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TopBar(
                      Colors.white,
                      'Webinar Details',
                    ),
                    // Here the stack is used for controlling three view for the
                    // selfstudy thumb, selfstudy video player and live webinars..
                    Stack(
                      children: <Widget>[
                        // Container SelfStudy Thumb..
                        Visibility(
                          visible: (strWebinarTypeIntent == 'ON-DEMAND'
                              ? (!isPlaying ? true : false)
                              : false),
                          child: Stack(
                            children: <Widget>[
                              Container(
                                height: 230.0,
                                width: double.infinity,
                                color: Colors.blue,
                                child: (webinar_thumb?.isEmpty
                                    ? Image.asset(
                                        'assets/avatar_bottom_right.png',
                                        fit: BoxFit.fill,
                                      )
                                    : Image.network(
                                        webinar_thumb,
                                        fit: BoxFit.fill,
                                      )),
                              ),
                              Positioned(
                                top: 0.0,
                                bottom: 0.0,
                                left: 0.0,
                                right: 0.0,
                                child: GestureDetector(
                                  onTap: () {
                                    print('Click event on play button..');
                                  },
                                  child: Icon(
                                    FontAwesomeIcons.playCircle,
                                    size: 80.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Container SelfStudy Video
                        Visibility(
                          visible: (strWebinarTypeIntent == 'ON-DEMAND'
                              ? (isPlaying ? true : false)
                              : false),
                          child: Container(
                            height: 230.0,
                            width: double.infinity,
                            color: Colors.red,
                          ),
                        ),
                        // Container Live Webinar
                        Visibility(
                          visible:
                              (strWebinarTypeIntent == 'live' ? true : false),
                          child: Container(
                            height: 230.0,
                            width: double.infinity,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            TestText('Text'),
                            TestText('Text1'),
                            TestText('Text2'),
                            TestText('Text3'),
                            TestText('Text4'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TestText extends StatelessWidget {
  TestText(this.strTitle);

  final String strTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      margin: EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
      height: 100.0,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
      ),
      // child: Center(
      child: Text(
        strTitle,
        style: TextStyle(
          fontSize: 20.0,
        ),
      ),
    );
  }
}
