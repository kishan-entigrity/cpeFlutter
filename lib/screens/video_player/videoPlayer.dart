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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var videoUrl = webDetailsObj['webinar_video_url'];
    print('Video URL : $videoUrl');
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(videoUrl),
    );
  }

  @override
  void dispose() {
    flickManager.dispose();
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
              child: FlickVideoPlayer(flickManager: flickManager),
            ),
          ],
        ),
      ),
    );
  }
}
