
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iptv/core/utils/app_colors.dart';
import 'package:iptv/core/utils/app_styles.dart';
import 'package:iptv/featuers/movies/presentation/manager/get_movies_category/get_movies_category_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CategoriesPanel extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onCategorySelected;

  const CategoriesPanel({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondaryColorTheme,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: BlocBuilder<GetMoviesCategoryCubit, GetMoviesCategoryState>(
        builder: (context, state) {
          // Always include base categories
          final List<String> baseCategories = <String>[];

          if (state is GetMoviesCategoryLoading) {
            return Skeletonizer(effect: ShimmerEffect(baseColor: Colors.grey[300]!, highlightColor: Colors.grey[100]!, duration: const Duration(seconds: 1)), enabled: true, child: _buildCategoriesList(context, ['Loading...' , 'Please wait...' , 'Loading...']));
          }

        

          if (state is GetMoviesCategorySuccess) {
            final dynamicCategories = state.movieCategoriesResponse.categories
                .map((e) => e.name)
                .where((name) => name.trim().isNotEmpty)
                .toList();

            final allCategories = <String>{...baseCategories, ...dynamicCategories}.toList();
            return _buildCategoriesList(context, allCategories);
          }

          // Initial state
          return _buildCategoriesList(context, baseCategories);
        },
      ),
    );
  }

  Widget _buildCategoriesList(BuildContext context, List<String> categories) {
    return ListView.separated(
      itemCount: categories.length,
      separatorBuilder: (_, __) => const Divider(height: 1, color: Colors.transparent),
      itemBuilder: (context, index) {
        final String label = categories[index];
        final bool selected = label == selectedCategory;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: InkWell(
            onTap: () {
              onCategorySelected(label);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                color: selected ? AppColors.mainColorTheme.withOpacity(.6) : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: Text(
                  label,
                  style: TextStyles.font14Medium(
                    context,
                  ).copyWith(color: AppColors.whiteColor),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}