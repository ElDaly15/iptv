
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:iptv/core/utils/app_colors.dart';
import 'package:iptv/core/utils/app_styles.dart';

class CategoriesPanel extends StatelessWidget {
  final List<String> categories = const [
    'All',
    'Favourite',
    'History',
  ];

  const CategoriesPanel({super.key});

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
          final bool selected = index == 0;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Container(
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
          );
        },
      ),
    );
  }
}