import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'VideoPlayer.dart';

class VideoAssetPlayer extends StatefulWidget {
  @override
  _VideoAssetPlayerState createState() => _VideoAssetPlayerState();
}

class _VideoAssetPlayerState extends State<VideoAssetPlayer> {
  final asset = 'assets/videos/PromotionalVideo.mp4';
  VideoPlayerController videocontroller;

  @override
  void initState() {
    super.initState();
    videocontroller = VideoPlayerController.asset(asset)
      ..addListener(() => setState(() {}))
      ..initialize().then((_) => videocontroller.pause());
     
  }

  @override
  void dispose() {
    super.dispose();
    videocontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [VideoPlayerWidget(videocontroller: videocontroller)]);
  }
}
