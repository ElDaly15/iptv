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
  bool _wasFullscreen = false;

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
        cupertinoProgressColors: ChewieProgressColors(playedColor: Colors.yellow , handleColor: Colors.white , backgroundColor: Colors.white ,bufferedColor: Colors.white),
        videoPlayerController: controller,
        autoPlay: true,
        looping: true,
        autoInitialize: true,
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
      // Enter fullscreen immediately after initialization
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_chewieController == null) return;
        _chewieController!.enterFullScreen();
        _wasFullscreen = true;
        _chewieController!.addListener(_handleFullscreenChange);
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to load stream';
      });
    }
  }

  void _handleFullscreenChange() {
    final controller = _chewieController;
    if (controller == null) return;
    final bool isFull = controller.isFullScreen;
    if (_wasFullscreen && !isFull) {
      // User exited fullscreen → return back
      if (mounted) {
        Navigator.of(context).maybePop();
      }
    }
    _wasFullscreen = isFull;
  }

  @override
  void dispose() {
    // Ensure we exit fullscreen before disposing
    _chewieController?.exitFullScreen();
    _chewieController?.removeListener(_handleFullscreenChange);
    _chewieController?.dispose();
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Builder(
        builder: (context) {
          if (_error != null) {
            return Center(
              child: Text(
                _error!,
                style: TextStyles.font14Medium(context).copyWith(color: AppColors.subGreyColor),
              ),
            );
          }
          if (_chewieController == null) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.yellowColor),
            );
          }
          return Chewie(controller: _chewieController!);
        },
      ),
    );
  }
}