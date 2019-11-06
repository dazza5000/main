import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VidPlayer extends StatefulWidget {
  const VidPlayer({Key key, this.videoUrl}) : super(key: key);

  final String videoUrl;
  @override
  VideoState createState() => VideoState();
}

class VideoState extends State<VidPlayer> {
  VideoPlayerController playerController;
  VoidCallback listener;

  @override
  void initState() {
    super.initState();
    createVideo();
    listener = () {
      setState(() {});
    };
  }

  void createVideo() {
    if (playerController == null) {
      playerController = VideoPlayerController.asset('images/video.mkv')
        ..addListener(listener)
        ..setVolume(1.0)
        ..initialize()
        ..play();
    } else {
      if (playerController.value.isPlaying) {
        playerController.pause();
      } else {
        playerController.initialize();
        playerController.play();
      }
    }
  }

  @override
  void deactivate() {
    playerController.setVolume(0.0);
    playerController.removeListener(listener);
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 16 / 9,
        child: playerController != null
            ? VideoPlayer(
                playerController,
              )
            : Container());
  }
}
