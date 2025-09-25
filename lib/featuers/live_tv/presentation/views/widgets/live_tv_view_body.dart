// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:iptv/core/utils/app_colors.dart';
import 'package:iptv/core/utils/app_styles.dart';
import 'package:get/get.dart' as g;
import 'package:iptv/featuers/live_tv/presentation/views/tv_player_view.dart';

class LiveTvViewBody extends StatefulWidget {
  const LiveTvViewBody({super.key});

  @override
  State<LiveTvViewBody> createState() => _LiveTvViewBodyState();
}

class _LiveTvViewBodyState extends State<LiveTvViewBody> {
  final List<String> _categories = const ['Faviourte', 'Recents'];
  final List<String> _channels = const [
    'demo1', 'demo2', 'demo3', 'demo4', 'demo5', 'demo6', 'demo7', 'demo8', 'demo9'
  ];
  int _selectedCategory = 0;
  int _selectedChannel = 0;

  String get timeText => DateFormat('hh:mm a').format(DateTime.now());

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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30 , vertical: 30),
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left categories
                SizedBox(
                  width:220,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          InkWell(onTap: (){
                            Navigator.pop(context);
                          },child: Icon(Icons.arrow_back_ios,color: Colors.white,)),
                          Expanded(
                            child: Text(
                              'Live Channels',
                              style: TextStyles.font22ExtraBold(context)
                                  .copyWith(color: AppColors.whiteColor),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      ..._categories.asMap().entries.map((e) {
                        final bool isSelected = e.key == _selectedCategory;
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: GestureDetector(
                            onTap: () => setState(() => _selectedCategory = e.key),
                            child: Text(
                              e.value,
                              style: (isSelected
                                      ? TextStyles.font18ExtraBold(context)
                                      : TextStyles.font18Medium(context))
                                  .copyWith(
                                color: isSelected
                                    ? AppColors.whiteColor
                                    : AppColors.subGreyColor,
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
      
                const SizedBox(width: 10),
      
                // Middle channels list
                Expanded(
                  child: ListView.separated(
                    itemCount: _channels.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final bool isSelected = index == _selectedChannel;
                      return InkWell(
                        onTap: () {
                          setState(() => _selectedChannel = index);
                          g.Get.to(
                            () => TvPlayerView(
                              channelName: _channels[index],
                              // Sample public HLS to test playback; replace with real stream per channel
                              streamUrl: 'https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8',
                            ),
                            transition: g.Transition.fade,
                            duration: const Duration(milliseconds: 300),
                          );
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: SizedBox(
                          width: 100,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.white.withOpacity(0.06)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 28,
                                  height: 28,
                                  decoration: BoxDecoration(
                                    color: Colors.white10,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  alignment: Alignment.center,
                                  child: const Icon(Icons.image, color: Colors.white24, size: 16),
                                ),
                                const SizedBox(width: 16),
                                Text(
                                  '${index + 1}',
                                  style: TextStyles.font20Medium(context)
                                      .copyWith(color: AppColors.whiteColor),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    _channels[index],
                                    style: TextStyles.font20Medium(context)
                                        .copyWith(color: AppColors.whiteColor),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
   
                    
              ],
            ),
      
           
          ],
        ),
      ),
    );
  }
}