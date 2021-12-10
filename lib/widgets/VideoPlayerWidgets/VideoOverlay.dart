import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class AdvancedOverlayWidget extends StatelessWidget {
  final VideoPlayerController videocontroller;

  static const allSpeeds = <double>[0.25, 0.5, 1, 1.5, 2, 3, 5, 10];

  const AdvancedOverlayWidget({
    Key key,
    @required this.videocontroller,
  }) : super(key: key);

  String getPosition() {
    final duration = Duration(
        milliseconds: videocontroller.value.position.inMilliseconds.round());

    return [duration.inMinutes, duration.inSeconds]
        .map((seg) => seg.remainder(60).toString().padLeft(2, '0'))
        .join(':');
  }
  

  @override
  Widget build(BuildContext context) {
    final isMuted = videocontroller.value.volume == 0;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => videocontroller.value.isPlaying
          ? videocontroller.pause()
          : videocontroller.play(),
      child: Stack(
        children: <Widget>[
          AnimatedSwitcher(
            duration: Duration(milliseconds: 50),
            reverseDuration: Duration(milliseconds: 200),
            child: videocontroller.value.isPlaying
                ? SizedBox()
                : Container(
                    color: Colors.black26,
                    child: Center(
                      child: Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 70,
                      ),
                    ),
                  ),
          ),
          buildSpeed(),
          Positioned(
            left: 8,
            bottom: 28,
            child: Text(
              getPosition(),
              style: TextStyle(color: Colors.white, fontSize: 10),
            ),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(width: 10),
                  Expanded(child: buildIndicator()),
                  SizedBox(width: 10),
                  Text(
                    'Video from DOT',
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  ),
                  SizedBox(width: 10),
                ],
              )),
          if (videocontroller != null && videocontroller.value.isInitialized)
            Positioned(
              right: 0,
              top: 30,
              child: Container(
                height: 30,
                width: 40,
                decoration: BoxDecoration(
                    color: Colors.white38,
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(10))),
                alignment: Alignment.center,
                child: IconButton(
                  icon: Icon(
                    isMuted ? Icons.volume_mute : Icons.volume_up,
                    color: Colors.white,
                    size: 12,
                  ),
                  onPressed: () => videocontroller.setVolume(isMuted ? 1 : 0),
                ),
              ),
            )
        ],
      ),
    );
  }

  Widget buildIndicator() => Container(
        margin: EdgeInsets.all(8).copyWith(right: 0),
        height: 16,
        child: VideoProgressIndicator(
          videocontroller,
          allowScrubbing: true,
        ),
      );

  Widget buildSpeed() => Align(
        alignment: Alignment.topRight,
        child: PopupMenuButton<double>(
          initialValue: videocontroller.value.playbackSpeed,
          tooltip: 'Playback speed',
          onSelected: videocontroller.setPlaybackSpeed,
          itemBuilder: (context) => allSpeeds
              .map<PopupMenuEntry<double>>((speed) => PopupMenuItem(
                    value: speed,
                    child: Text('${speed}x'),
                  ))
              .toList(),
          child: Container(
            height: 30,
            width: 40,
            color: Colors.white38,
            alignment: Alignment.center,
            child: Text(
              '${videocontroller.value.playbackSpeed}x',
              style: TextStyle(color: Colors.white, fontSize: 10),
            ),
          ),
        ),
      );
}
