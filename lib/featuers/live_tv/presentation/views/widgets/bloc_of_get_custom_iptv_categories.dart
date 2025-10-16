// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iptv/core/utils/app_colors.dart';
import 'package:iptv/core/utils/app_styles.dart';
import 'package:iptv/featuers/live_tv/presentation/manager/get_iptv_categories/get_iptv_categories_cubit.dart';
import 'package:iptv/featuers/live_tv/presentation/manager/get_iptv_channels/get_iptv_channels_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BlocOfGetCustomIptvCategories extends StatefulWidget {
  const BlocOfGetCustomIptvCategories({super.key});

  @override
  State<BlocOfGetCustomIptvCategories> createState() => _BlocOfGetCustomIptvCategoriesState();
}

class _BlocOfGetCustomIptvCategoriesState extends State<BlocOfGetCustomIptvCategories> {
   List<String> fakeCategories = [
    'Faviourte',
    'Recents',
    'Recents',
    'Recents',
    'Recents',
    'Recents',
    'Recents',
  ];
  int _selectedCategory = 0;
    int _selectedChannel = 0;

  String? _lastLoadedCategoryId;
  @override
  Widget build(BuildContext context) {
    return   Expanded(
                          child: BlocBuilder<GetIptvCategoriesCubit, GetIptvCategoriesState>(
                            builder: (context, state) {
                              if (state is GetIptvCategoriesLoading || state is GetIptvCategoriesError) {
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
                                      final bool isSelected =
                                          index == _selectedCategory;
                                      final name = fakeCategories[index];
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 10.0,
                                        ),
                                        child: GestureDetector(
                                          onTap: () => setState(
                                            () => _selectedCategory = index,
                                          ),
                                          child: Text(
                                            name,
                                            style:
                                                (isSelected
                                                        ? TextStyles.font20ExtraBold(
                                                            context,
                                                          )
                                                        : TextStyles.font18Medium(
                                                            context,
                                                          ))
                                                    .copyWith(
                                                      color: isSelected
                                                          ? AppColors.whiteColor
                                                          : AppColors
                                                                .subGreyColor,
                                                    ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }
                           
                              if (state is GetIptvCategoriesSuccess) {
                                final categories =
                                    state.iptvCategoriesResponse.categories;
                                if (categories.isEmpty) {
                                  return Center(
                                    child: Text(
                                      'No categories',
                                      style: TextStyles.font18Medium(
                                        context,
                                      ).copyWith(color: AppColors.subGreyColor),
                                    ),
                                  );
                                }
                                // Guard selected index within range after load
                                if (_selectedCategory >= categories.length) {
                                  _selectedCategory = 0;
                                }
                                // Trigger initial/changed category channels load exactly once per category id
                                final currentCategoryId =
                                    categories[_selectedCategory].id;
                                if (_lastLoadedCategoryId !=
                                    currentCategoryId) {
                                  _lastLoadedCategoryId = currentCategoryId;
                                  WidgetsBinding.instance.addPostFrameCallback((
                                    _,
                                  ) {
                                    context
                                        .read<GetIptvChannelsCubit>()
                                        .getIptvChannels(currentCategoryId);
                                  });
                                }
                                return ListView.builder(
                                  itemCount: categories.length,
                                  itemBuilder: (context, index) {
                                    final bool isSelected =
                                        index == _selectedCategory;
                                    final name = categories[index].name;

                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 10.0,
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _selectedCategory = index;
                                            _selectedChannel = 0;
                                          });
                                          final selectedId =
                                              categories[index].id;
                                          context
                                              .read<GetIptvChannelsCubit>()
                                              .getIptvChannels(selectedId);
                                          _lastLoadedCategoryId = selectedId;
                                        },
                                        child: Text(
                                          name.isEmpty ? 'Unnamed' : name,
                                          style:
                                              (isSelected
                                                      ? TextStyles.font20ExtraBold(
                                                          context,
                                                        )
                                                      : TextStyles.font18Medium(
                                                          context,
                                                        ))
                                                  .copyWith(
                                                    color: isSelected
                                                        ? AppColors.whiteColor
                                                        : AppColors
                                                              .subGreyColor,
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
                        );
  }
}