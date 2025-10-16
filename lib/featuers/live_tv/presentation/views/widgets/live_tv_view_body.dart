// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:iptv/core/utils/app_colors.dart';
import 'package:iptv/core/utils/app_styles.dart';
import 'package:get/get.dart' as g;
import 'package:iptv/featuers/live_tv/presentation/views/tv_player_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iptv/featuers/live_tv/presentation/manager/get_iptv_categories/get_iptv_categories_cubit.dart';
import 'package:iptv/featuers/live_tv/presentation/manager/get_iptv_channels/get_iptv_channels_cubit.dart';
import 'package:iptv/featuers/live_tv/data/models/iptv_channel_model.dart';
import 'package:skeletonizer/skeletonizer.dart';

class LiveTvViewBody extends StatefulWidget {
  const LiveTvViewBody({super.key});

  @override
  State<LiveTvViewBody> createState() => _LiveTvViewBodyState();
}

class _LiveTvViewBodyState extends State<LiveTvViewBody> {
  List<String> fakeCategories = ['Faviourte', 'Recents' , 'Recents','Recents','Recents','Recents','Recents'];
  int _selectedCategory = 0;
  int _selectedChannel = 0;
  String? _lastLoadedCategoryId; // track to avoid duplicate fetch in build

  String get timeText => DateFormat('hh:mm a').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    // Fetch categories once when entering the view
    context.read<GetIptvCategoriesCubit>().getIptvCategories();
    // Ensure channels state shows loading (or initial) on page entry
    context.read<GetIptvChannelsCubit>().setLoading();
    
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15 , vertical: 10 ),
        child: Stack(
          children: [
            SafeArea(
              child: Row(
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
                        Expanded(
                          child: BlocBuilder<GetIptvCategoriesCubit, GetIptvCategoriesState>(
                            builder: (context, state) {
                              if (state is GetIptvCategoriesLoading) {
                                  return Skeletonizer(
                                       effect: ShimmerEffect(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    duration: const Duration(seconds: 1),
                  ),
                                    enabled: true,
                                    child: ListView.builder(
                                    itemCount: fakeCategories.length,
                                    itemBuilder: (context, index) {
                                      final bool isSelected = index == _selectedCategory;
                                      final name = fakeCategories[index];
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                                        child: GestureDetector(
                                          onTap: () => setState(() => _selectedCategory = index),
                                          child: Text(
                                            name,
                                            style: (isSelected
                                                    ? TextStyles.font20ExtraBold(context)
                                                    : TextStyles.font18Medium(context))
                                                .copyWith(
                                              color: isSelected
                                                  ? AppColors.whiteColor
                                                  : AppColors.subGreyColor,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                                                    ),
                                  );
                              }
                              if (state is GetIptvCategoriesError) {
                                return Center(
                                  child: Text(
                                    state.error,
                                    style: TextStyles.font18Medium(context).copyWith(color: AppColors.subGreyColor),
                                  ),
                                );
                              }
                              if (state is GetIptvCategoriesSuccess) {
                                final categories = state.iptvCategoriesResponse.categories;
                                if (categories.isEmpty) {
                                  return Center(
                                    child: Text(
                                      'No categories',
                                      style: TextStyles.font18Medium(context).copyWith(color: AppColors.subGreyColor),
                                    ),
                                  );
                                }
                                // Guard selected index within range after load
                                if (_selectedCategory >= categories.length) {
                                  _selectedCategory = 0;
                                }
                                // Trigger initial/changed category channels load exactly once per category id
                                final currentCategoryId = categories[_selectedCategory].id;
                                if (_lastLoadedCategoryId != currentCategoryId) {
                                  _lastLoadedCategoryId = currentCategoryId;
                                  WidgetsBinding.instance.addPostFrameCallback((_) {
                                    context.read<GetIptvChannelsCubit>().getIptvChannels(currentCategoryId);
                                  });
                                }
                                return ListView.builder(
                                  itemCount: categories.length,
                                  itemBuilder: (context, index) {
                                    final bool isSelected = index == _selectedCategory;
                                    final name = categories[index].name;
                                    
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _selectedCategory = index;
                                            _selectedChannel = 0;
                                          });
                                          final selectedId = categories[index].id;
                                          context.read<GetIptvChannelsCubit>().getIptvChannels(selectedId);
                                          _lastLoadedCategoryId = selectedId;
                                        },
                                        child: Text(
                                          name.isEmpty ? 'Unnamed' : name,
                                          style: (isSelected
                                                  ? TextStyles.font20ExtraBold(context)
                                                  : TextStyles.font18Medium(context))
                                              .copyWith(
                                            color: isSelected
                                                ? AppColors.whiteColor
                                                : AppColors.subGreyColor,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }
                              // Initial state
                              return const SizedBox.shrink();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                    
                  const SizedBox(width: 10),
                    
                  // Middle channels list
                  Expanded(
                    child: BlocBuilder<GetIptvChannelsCubit, GetIptvChannelsState>(
                      builder: (context, state) {
                        if (state is GetIptvChannelsLoading) {
                          return Skeletonizer(
                            effect: ShimmerEffect(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              duration: const Duration(seconds: 1),
                            ),
                            enabled: true,
                            child: ListView.separated(
                              itemCount: 10,
                              separatorBuilder: (_, __) => const SizedBox(height: 16),
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.06),
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
                                          'Channel ${index + 1}',
                                          style: TextStyles.font20Medium(context)
                                              .copyWith(color: AppColors.whiteColor),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        }
                        if (state is GetIptvChannelsError) {
                          return Center(
                            child: Text(
                              state.error,
                              style: TextStyles.font18Medium(context).copyWith(color: AppColors.subGreyColor),
                            ),
                          );
                        }
                        if (state is GetIptvChannelsSuccess) {
                          final List<IptvChannel> channels = state.iptvChannelsResponse.channels;
                          if (channels.isEmpty) {
                            return Center(
                              child: Text(
                                'No channels',
                                style: TextStyles.font18Medium(context).copyWith(color: AppColors.subGreyColor),
                              ),
                            );
                          }
                          if (_selectedChannel >= channels.length) {
                            _selectedChannel = 0;
                          }
                          return ListView.separated(
                            itemCount: channels.length,
                            separatorBuilder: (_, __) => const SizedBox(height: 16),
                            itemBuilder: (context, index) {
                              final bool isSelected = index == _selectedChannel;
                              final channel = channels[index];
                              return InkWell(
                                onTap: () {
                                  setState(() => _selectedChannel = index);
                                  g.Get.to(
                                    () => TvPlayerView(
                                      channelName: channel.name.isEmpty ? 'Channel ${index + 1}' : channel.name,
                                      streamUrl: channel.streamUrl.isNotEmpty
                                          ? 'https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8'
                                          : channel.originalData.directSource,
                                      isLive: channel.streamType == 'live',
                                    ),
                                    transition: g.Transition.fade,
                                    duration: const Duration(milliseconds: 300),
                                  );
                                },
                                borderRadius: BorderRadius.circular(12),
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
                                          channel.name.isEmpty ? 'Channel ${index + 1}' : channel.name,
                                          style: TextStyles.font20Medium(context)
                                              .copyWith(color: AppColors.whiteColor),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }
                        // initial state
                         return Skeletonizer(
                            effect: ShimmerEffect(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              duration: const Duration(seconds: 1),
                            ),
                            enabled: true,
                            child: ListView.separated(
                              itemCount: 10,
                              separatorBuilder: (_, __) => const SizedBox(height: 16),
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.06),
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
                                          'Channel ${index + 1}',
                                          style: TextStyles.font20Medium(context)
                                              .copyWith(color: AppColors.whiteColor),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                      },
                    ),
                  ),
                 
                      
                ],
              ),
            ),
      
           
          ],
        ),
      ),
    );
  }
}