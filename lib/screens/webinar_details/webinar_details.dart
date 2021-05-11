import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

import '../../constant.dart';
import '../../rest_api.dart';

class WebinarDetails extends StatefulWidget {
  // final int webinarId;
  // final String sampleIntent;

  // WebinarDetails(this.webinarId, {Key, key}) : super(key: key);
  // WebinarDetails(this.sampleIntent, {Key, key}) : super(key: key);
  WebinarDetails(this.resultText, this.webinarId);

  final String resultText;
  final int webinarId;

  @override
  _WebinarDetailsState createState() => _WebinarDetailsState(resultText, webinarId);
}

class _WebinarDetailsState extends State<WebinarDetails> {
  bool isProgressShowing = false;
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  _WebinarDetailsState(this.resultText1, this.webinarId);

  final String resultText1;
  final int webinarId;

  String userToken;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  var respStatus;
  var respMessage;

  var webinar_thumb;
  var video_url;
  var webinar_title;
  var webinar_type;
  var webinar_date;
  var webinar_status;
  var start_date;
  var start_time;
  var is_card_save;
  var credit;
  var ce_credit;
  var cfp_credit;
  var cpd_credit;
  var duration;

  @override
  void initState() {
    _controller = VideoPlayerController.network(
      // 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      video_url,
      // 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
      // 'https://player.vimeo.com//play//1624977747?s=359330135_1609206521_7d8ca704163f13f5a50fddb50b769445&loc=external&context=Vimeo%5CController%5CApi%5CResources%5CVideoController.&download=1&filename=DOES%2BYOUR%2BCLIENT%2BOWN%2BSHARES%2BIN%2BFOREIGN%2BCORPORATION%253F%2BIMPACT%2BOF%2BTJCA174.mp4',
      // 'https://vimeo.com/76979871',

      // Take an API call for getting webinar details..
    );
    print('Video Player playback URL is : $video_url');

    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);

    checkForSP();

    super.initState();
    // Take an API call for getting Webinar Details from the webinar_id..
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //TODO: implement build
    // throw UnimplementedError();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned(
              child: Column(
                children: <Widget>[
                  CustomAppBar(),
                  Container(
                    width: double.infinity,
                    height: 0.5,
                    color: Colors.black,
                  ),
                  // Here we have to add video player which play data from URL,
                  FutureBuilder(
                    future: _initializeVideoPlayerFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        // If the VideoPlayerController has finished initialization, use
                        // the data it provides to limit the aspect ratio of the video.
                        return AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          // Use the VideoPlayer widget to display the video.
                          child: VideoPlayer(_controller),
                        );
                      } else {
                        // If the VideoPlayerController is still initializing, show a
                        // loading spinner.
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      // Wrap the play or pause in a call to `setState`. This ensures the
                      // correct icon is shown.
                      setState(() {
                        // If the video is playing, pause it.
                        if (_controller.value.isPlaying) {
                          _controller.pause();
                        } else {
                          // If the video is paused, play it.
                          _controller.play();
                          // _controller.seekTo(const Duration(milliseconds: 20000));
                        }
                      });
                    },
                    // Display the correct icon depending on the state of the player.
                    child: Icon(
                      _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                    ),
                  ),
                  Text('TestData'),
                  Text('$resultText1 $webinarId'),
                ],
              ),
            ),
            Positioned(
              top: 0.0,
              left: 0.0,
              right: 0.0,
              bottom: 0.0,
              child: Visibility(
                visible: isProgressShowing ? true : false,
                child: LoaderWebinarDetail(),
              ),
            ),
            /*Positioned(
              top: 330.0,
              left: 170.0,
              right: 170.0,
              bottom: 330.0,
              child: CircularProgressIndicator(
                // backgroundColor: Colors.white,
              ),
            ),*/
          ],
        ),
      ),
    );
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
    if ((connectivityResult == ConnectivityResult.mobile) || (connectivityResult == ConnectivityResult.wifi)) {
      // Take API call from here..
      String strWebId = webinarId.toString();
      var resp = await getWebinarDetails(userToken, strWebId);

      respStatus = resp['success'];
      respMessage = resp['message'];

      print('Response for webinar details is : $resp');

      if (respStatus) {
        setState(() {
          webinar_thumb = resp['payload']['webinar_detail']['webinar_thumbnail'];
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

          _controller = VideoPlayerController.network(
            // 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
            video_url,
            // 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
            // 'https://player.vimeo.com//play//1624977747?s=359330135_1609206521_7d8ca704163f13f5a50fddb50b769445&loc=external&context=Vimeo%5CController%5CApi%5CResources%5CVideoController.&download=1&filename=DOES%2BYOUR%2BCLIENT%2BOWN%2BSHARES%2BIN%2BFOREIGN%2BCORPORATION%253F%2BIMPACT%2BOF%2BTJCA174.mp4',
            // 'https://vimeo.com/76979871',

            // Take an API call for getting webinar details..
          );
          print('Video Player playback URL is : $video_url');

          _initializeVideoPlayerFuture = _controller.initialize();
          _controller.setLooping(true);
        });

        print('Webinar details response : Webinar thumbnail is : $webinar_thumb');
        print('Webinar details response : Webinar video url is : $video_url');
      } else {
        Fluttertoast.showToast(
            msg: respMessage,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: toastBackgroundColor,
            textColor: toastTextColor,
            fontSize: 16.0);
        /*_scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text(respMessage),
            duration: Duration(seconds: 3),
          ),
        );*/
      }
    } else {
      Fluttertoast.showToast(
          msg: "Please check your internet connectivity and try again",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: toastBackgroundColor,
          textColor: toastTextColor,
          fontSize: 16.0);
      /*_scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content:
              Text("Please check your internet connectivity and try again"),
          duration: Duration(seconds: 3),
        ),
      );*/
    }
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
            flex: 12,
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
            flex: 2,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 10.0,
              ),
              child: Icon(
                FontAwesomeIcons.shareAlt,
                size: 15.0,
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 10.0,
              ),
              child: Icon(
                FontAwesomeIcons.solidBell,
                size: 15.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LoaderWebinarDetail extends StatelessWidget {
  const LoaderWebinarDetail({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpinKitCircle(
      size: 60.0,
      color: Colors.black,
    );
  }
}
