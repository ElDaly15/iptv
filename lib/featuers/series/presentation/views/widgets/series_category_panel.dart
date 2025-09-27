

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:iptv/core/utils/app_colors.dart';
import 'package:iptv/core/utils/app_styles.dart';

class SeriesCategoriesPanel extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onCategorySelected;

  const SeriesCategoriesPanel({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  final List<String> categories = const [
    'All',
    'Favourite',
    'History',
    
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondaryColorTheme,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: ListView.separated(
        itemCount: categories.length,
        separatorBuilder: (_, __) =>
            const Divider(height: 1, color: Colors.transparent),
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
                  color: selected
                      ? AppColors.mainColorTheme.withOpacity(.6)
                      : Colors.transparent,
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
      ),
    );
  }
}