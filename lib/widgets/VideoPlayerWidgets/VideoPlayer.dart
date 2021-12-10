import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'VideoOverlay.dart';

class VideoPlayerWidget extends StatelessWidget {
  final VideoPlayerController videocontroller;

  const VideoPlayerWidget({
    Key key,
    @required this.videocontroller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      videocontroller != null && videocontroller.value.isInitialized
          ? Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
              alignment: Alignment.center,
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: buildVideo()))
          : Container(
              height: 200,
              child: Center(child: CircularProgressIndicator()),
            );

  Widget buildVideo() => Stack(
        children: <Widget>[
          buildVideoPlayer(),
          Positioned.fill(child: AdvancedOverlayWidget(videocontroller: videocontroller)),
        ],
      );

  Widget buildVideoPlayer() => AspectRatio(
        aspectRatio: videocontroller.value.aspectRatio,
        child: VideoPlayer(videocontroller),
      );
}
