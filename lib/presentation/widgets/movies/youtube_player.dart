import 'package:cinemapedia/domain/entities/video.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeVideoPlayer extends StatefulWidget {
  final List<Video> listVideos;

  const YoutubeVideoPlayer({super.key, required this.listVideos});

  @override
  State<YoutubeVideoPlayer> createState() => _YoutubeVideoPlayerState();
}

class _YoutubeVideoPlayerState extends State<YoutubeVideoPlayer> {
  // late final YoutubePlayerController controller;
  late final List<YoutubePlayerController> listControllers;

  final flags = const YoutubePlayerFlags(
    hideThumbnail: false,
    showLiveFullscreenButton: false,
    mute: false,
    autoPlay: false,
    disableDragSeek: true,
    loop: false,
    isLive: false,
    forceHD: false,
    enableCaption: false,
  );

  @override
  void initState() {
    // controller = YoutubePlayerController(
    //   initialVideoId: widget.listVideos,
    //   flags: const YoutubePlayerFlags(
    //     hideThumbnail: false,
    //     showLiveFullscreenButton: false,
    //     mute: false,
    //     autoPlay: false,
    //     disableDragSeek: true,
    //     loop: false,
    //     isLive: false,
    //     forceHD: false,
    //     enableCaption: false,
    //   ),
    // );

    listControllers = widget.listVideos
        .map((e) => YoutubePlayerController(
              initialVideoId: e.videoId,
              flags: flags,
            ))
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Text(
            "Clips y trailers",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 180,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.listVideos.length,
              itemBuilder: (BuildContext context, int index) {
                final videoController = listControllers[index];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SizedBox(
                      width: 320,
                      child: YoutubePlayer(controller: videoController),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
