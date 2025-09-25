import 'package:flutter/material.dart';
import 'package:iptv/core/utils/app_colors.dart';
import 'package:iptv/core/utils/app_styles.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class TvPlayerViewBody extends StatefulWidget {
  final String channelName;
  final String? streamUrl;

  const TvPlayerViewBody({super.key, required this.channelName, this.streamUrl});

  @override
  State<TvPlayerViewBody> createState() => _TvPlayerViewBodyState();
}

class _TvPlayerViewBodyState extends State<TvPlayerViewBody> {
  VideoPlayerController? _videoController;
  ChewieController? _chewieController;
  String? _error;

  @override
  void initState() {
    super.initState();
    if (widget.streamUrl != null && widget.streamUrl!.isNotEmpty) {
      _initPlayer(widget.streamUrl!);
    } else {
      _error = 'No stream URL provided';
    }
  }

  Future<void> _initPlayer(String url) async {
    try {
      final controller = VideoPlayerController.networkUrl(Uri.parse(url));
      await controller.initialize();
      final chewie = ChewieController(
        videoPlayerController: controller,
        autoPlay: true,
        looping: true,
        allowMuting: true,
        allowFullScreen: true,
        materialProgressColors: ChewieProgressColors(
          playedColor: AppColors.yellowColor,
          handleColor: AppColors.whiteColor,
          backgroundColor: Colors.white24,
          bufferedColor: Colors.white38,
        ),
      );
      if (!mounted) return;
      setState(() {
        _videoController = controller;
        _chewieController = chewie;
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to load stream';
      });
    }
  }

  @override
  void dispose() {
    _chewieController?.dispose();
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.secondaryColorTheme, AppColors.mainColorTheme],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.channelName,
                style: TextStyles.font22ExtraBold(context).copyWith(color: AppColors.whiteColor),
              ),
              const SizedBox(height: 16),
              AspectRatio(
                aspectRatio: 16 / 9,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Builder(
                    builder: (context) {
                      if (_error != null) {
                        return Container(
                          color: Colors.black,
                          alignment: Alignment.center,
                          child: Text(_error!, style: TextStyles.font14Medium(context).copyWith(color: AppColors.subGreyColor)),
                        );
                      }
                      if (_chewieController == null) {
                        return Container(
                          color: Colors.black,
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator(color: AppColors.yellowColor),
                        );
                      }
                      return Chewie(controller: _chewieController!);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                widget.streamUrl ?? 'Provide an HLS/DASH URL to play',
                style: TextStyles.font14Medium(context).copyWith(color: AppColors.subGreyColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}