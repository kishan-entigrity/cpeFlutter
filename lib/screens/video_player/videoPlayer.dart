import 'dart:async';

import 'package:cpe_flutter/components/TopBar.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerFlickker extends StatefulWidget {
  VideoPlayerFlickker(this.webDetailsObj);
  final webDetailsObj;

  @override
  _VideoPlayerState createState() => _VideoPlayerState(webDetailsObj);
}

class _VideoPlayerState extends State<VideoPlayerFlickker> {
  _VideoPlayerState(this.webDetailsObj);
  final webDetailsObj;

  FlickManager flickManager;
  Timer _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var videoUrl = webDetailsObj['webinar_video_url'];
    print('Video URL : $videoUrl');
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(videoUrl),
    );

    // startBasicTimer();
  }

  @override
  void dispose() {
    flickManager.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Container(
        color: Colors.tealAccent,
        child: Column(
          children: <Widget>[
            TopBar(Colors.white, 'Video Player'),
            Container(
              width: double.infinity,
              height: 180.0,
              // height: SDP.sdp(300),
              child: FlickVideoPlayer(
                flickManager: flickManager,
                /*flickVideoWithControls: FlickPlayToggle(
                  // togglePlay: flickControlManager.pause(),
                  pauseChild: flickManager.flickControlManager.pause(),
                ),*/
              ),
            ),
            GestureDetector(
              onTap: () {
                print('onTap for TogglePlay button is called..');
                flickManager.flickControlManager.togglePlay();
              },
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'TogglePlayController',
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                bool state = flickManager.flickVideoManager.isPlaying;
                // bool bufferState = flickManager.flickVideoManager.addListener(() {flickManager.flickVideoManager.});
                if (flickManager.flickVideoManager.isPlaying) {
                  print('Video player is playing $state');
                } else {
                  print('Video player is on pause state $state');
                }
              },
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Check State',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void startBasicTimer() {
    _timer = new Timer.periodic(Duration(seconds: 5), (timer) {
      var timer = DateTime.now();
      print('Start Basic Timer is called.. $timer');
    });
  }
}
