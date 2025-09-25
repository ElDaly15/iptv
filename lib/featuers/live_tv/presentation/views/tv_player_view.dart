import 'package:flutter/material.dart';
import 'package:iptv/featuers/live_tv/presentation/views/widgets/tv_player_view_body.dart';

class TvPlayerView extends StatelessWidget {
  final String channelName;
  final String? streamUrl;

  const TvPlayerView({super.key, required this.channelName, this.streamUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TvPlayerViewBody(channelName: channelName, streamUrl: streamUrl),
    );
  }
}