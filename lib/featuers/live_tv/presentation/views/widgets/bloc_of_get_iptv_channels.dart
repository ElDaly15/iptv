// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as g;
import 'package:iptv/core/utils/app_colors.dart';
import 'package:iptv/core/utils/app_images.dart';
import 'package:iptv/core/utils/app_styles.dart';
import 'package:iptv/featuers/live_tv/data/models/iptv_channel_model.dart';
import 'package:iptv/featuers/live_tv/presentation/manager/get_iptv_channels/get_iptv_channels_cubit.dart';
import 'package:iptv/featuers/live_tv/presentation/views/tv_player_view.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BlocOfGetIptvChannels extends StatefulWidget {
  const BlocOfGetIptvChannels({super.key});

  @override
  State<BlocOfGetIptvChannels> createState() => _BlocOfGetIptvChannelsState();
}

class _BlocOfGetIptvChannelsState extends State<BlocOfGetIptvChannels> {
  int _selectedChannel = 0;
  @override
  Widget build(BuildContext context) {
    return  Expanded(
                    child: BlocBuilder<GetIptvChannelsCubit, GetIptvChannelsState>(
                      builder: (context, state) {
                        if (state is GetIptvChannelsLoading || state is GetIptvChannelsError) {
                          return Skeletonizer(
                            effect: ShimmerEffect(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              duration: const Duration(seconds: 1),
                            ),
                            enabled: true,
                            child: ListView.separated(
                              itemCount: 10,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(height: 16),
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
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
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                        ),
                                        alignment: Alignment.center,
                                        child: const Icon(
                                          Icons.image,
                                          color: Colors.white24,
                                          size: 16,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Text(
                                        '${index + 1}',
                                        style: TextStyles.font20Medium(
                                          context,
                                        ).copyWith(color: AppColors.whiteColor),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          'Channel ${index + 1}',
                                          style:
                                              TextStyles.font20Medium(
                                                context,
                                              ).copyWith(
                                                color: AppColors.whiteColor,
                                              ),
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
                       
                        if (state is GetIptvChannelsSuccess) {
                          final List<IptvChannel> channels =
                              state.iptvChannelsResponse.channels;
                          if (channels.isEmpty) {
                            return Center(
                              child: Text(
                                'No channels',
                                style: TextStyles.font18Medium(
                                  context,
                                ).copyWith(color: AppColors.subGreyColor),
                              ),
                            );
                          }
                          if (_selectedChannel >= channels.length) {
                            _selectedChannel = 0;
                          }
                          return ListView.separated(
                            itemCount: channels.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 16),
                            itemBuilder: (context, index) {
                              final bool isSelected = index == _selectedChannel;
                              final channel = channels[index];
                              return InkWell(
                                onTap: () {
                                  setState(() => _selectedChannel = index);
                                  g.Get.to(
                                    () => TvPlayerView(
                                      channelName: channel.name.isEmpty
                                          ? 'Channel ${index + 1}'
                                          : channel.name,
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
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? Colors.white.withOpacity(0.06)
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CachedNetworkImage(
                                        placeholder: (context, url) =>
                                            Skeletonizer(
                                              effect: ShimmerEffect(
                                                baseColor: Colors.grey[300]!,
                                                highlightColor:
                                                    Colors.grey[100]!,
                                                duration: const Duration(
                                                  seconds: 1,
                                                ),
                                              ),
                                              enabled: true,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                child: Image.asset(
                                                  Assets.imagesLogo,
                                                ),
                                              ),
                                            ),
                                        errorWidget: (context, url, error) =>
                                            ClipRRect(
                                              child: Skeletonizer(
                                                effect: ShimmerEffect(
                                                  baseColor: Colors.grey[300]!,
                                                  highlightColor:
                                                      Colors.grey[100]!,
                                                  duration: const Duration(
                                                    seconds: 1,
                                                  ),
                                                ),
                                                enabled: true,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  child: Image.asset(
                                                    Assets.imagesLogo,
                                                  ),
                                                ),
                                              ),
                                            ),
                                        width: 28,
                                        height: 28,
                                        fit: BoxFit.fill,
                                        imageUrl:
                                            channel.originalData.streamIcon,
                                      ),
                                      const SizedBox(width: 16),
                                      Text(
                                        '${index + 1}',
                                        style: TextStyles.font20Medium(
                                          context,
                                        ).copyWith(color: AppColors.whiteColor),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          channel.name.isEmpty
                                              ? 'Channel ${index + 1}'
                                              : channel.name,
                                          style:
                                              TextStyles.font20Medium(
                                                context,
                                              ).copyWith(
                                                color: AppColors.whiteColor,
                                              ),
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
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 16),
                            itemBuilder: (context, index) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
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
                                      child: const Icon(
                                        Icons.image,
                                        color: Colors.white24,
                                        size: 16,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Text(
                                      '${index + 1}',
                                      style: TextStyles.font20Medium(
                                        context,
                                      ).copyWith(color: AppColors.whiteColor),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        'Channel ${index + 1}',
                                        style: TextStyles.font20Medium(
                                          context,
                                        ).copyWith(color: AppColors.whiteColor),
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
                  );
  }
}