import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends HookWidget {
  final String videoUrl;

  const VideoPlayerWidget({super.key, required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    final videoPlayerController = useState<VideoPlayerController?>(null);
    final isVideoPlayerInitialized = useState<bool>(false);

    useEffect(() {
      videoPlayerController.value =
          VideoPlayerController.networkUrl(Uri.parse(videoUrl))
            ..initialize().then((_) {
              isVideoPlayerInitialized.value = true;
            });

      return () {
        videoPlayerController.value?.dispose();
      };
    }, [videoUrl]);

    return isVideoPlayerInitialized.value
        ? AspectRatio(
            aspectRatio: videoPlayerController.value!.value.aspectRatio,
            child: VideoPlayer(videoPlayerController.value!),
          )
        : Container();
  }
}
