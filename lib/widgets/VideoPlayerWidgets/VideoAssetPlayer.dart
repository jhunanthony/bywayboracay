import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'VideoPlayer.dart';


class VideoAssetPlayer extends StatefulWidget {
  @override
  _VideoAssetPlayerState createState() => _VideoAssetPlayerState();
}

class _VideoAssetPlayerState extends State<VideoAssetPlayer> {
  final asset = 'assets/videos/PromotionalVideo.mp4';
  VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.asset(asset)
      ..addListener(() => setState(() {}))
      ..setLooping(false)
  
    
      
      ..initialize().then((_) => controller.play());
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Stack(children: [
      VideoPlayerWidget(controller: controller)
      ]);
  
  }
}
