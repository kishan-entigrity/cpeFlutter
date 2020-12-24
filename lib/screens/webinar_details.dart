import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:video_player/video_player.dart';

class WebinarDetails extends StatefulWidget {
  final int webinarId;

  WebinarDetails(this.webinarId, {Key, key}) : super(key: key);

  @override
  _WebinarDetailsState createState() => _WebinarDetailsState();
}

class _WebinarDetailsState extends State<WebinarDetails> {
  bool isProgressShowing = false;
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    // TODO: implement initState
    _controller = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    );

    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);

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
                  Text(
                    'Testting data',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
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
                        }
                      });
                    },
                    // Display the correct icon depending on the state of the player.
                    child: Icon(
                      _controller.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                    ),
                  ),
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
