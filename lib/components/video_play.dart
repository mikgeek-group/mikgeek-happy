import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';

// ignore: depend_on_referenced_packages
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;
  final int playIndex = 0;
  final bool fullScreenByDefault;
  final Duration startAt = Duration.zero;
  final playList = [];

  VideoPlayerWidget({
    super.key,
    required this.videoUrl,
    this.fullScreenByDefault = false,
  });

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  int? bufferDelay;

  late String playUrl = "";

  @override
  void initState() {
    super.initState();
    playUrl = widget.videoUrl;
    initializePlayer();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  List<String> srcs = [
    "https://assets.mixkit.co/videos/preview/mixkit-spinning-around-the-earth-29351-large.mp4",
    "https://assets.mixkit.co/videos/preview/mixkit-daytime-city-traffic-aerial-view-56-large.mp4",
    "https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4"
  ];

  Future<void> initializePlayer() async {
    print("init");
    //判断是本地视频还是网络请求下来的视频
    if (playUrl.contains('http')) {
      _videoPlayerController =
          VideoPlayerController.networkUrl(Uri.parse(playUrl));
    } else {
      _videoPlayerController = VideoPlayerController.file(File(playUrl));
    }
    await Future.wait([
      _videoPlayerController.initialize(),
    ]);
    _createChewieController();
    setState(() {});
  }

  void _createChewieController() {
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      startAt: widget.startAt,
      hideControlsTimer: const Duration(seconds: 10),
      allowPlaybackSpeedChanging: false,
      fullScreenByDefault: widget.fullScreenByDefault,
    );

    // 自动切换下一级
    _videoPlayerController?.addListener(() {
      if (_videoPlayerController!.value.duration ==
              _videoPlayerController!.value.position &&
          _videoPlayerController!.value.isInitialized) {
        _videoPlayerController?.dispose();

        playUrl = widget.playList[widget.playIndex];
        // playIndex++;
        // if (activeIndex == list.length - 1) {
        //   activeIndex = 0;
        // } else {
        //   activeIndex++;
        // }
        //
        // // 初始化进度条
        // if (index != 0) {
        //   init();
        //   listen();
        // }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(28, 34, 47, 1),
      width: MediaQuery.of(context).size.width,
      height: 220,
      child: Center(
        child: _chewieController != null &&
                _chewieController!.videoPlayerController.value.isInitialized
            ? Chewie(
                controller: _chewieController!,
              )
            : const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text(
                    '加载中...',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
