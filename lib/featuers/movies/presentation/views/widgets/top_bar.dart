
import 'package:flutter/material.dart';
import 'package:iptv/core/utils/app_colors.dart';
import 'package:iptv/core/utils/app_styles.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Search Field
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.secondaryColorTheme,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            height: 48,
            child: Row(
              children: [
                Icon(Icons.search, color: AppColors.subGreyColor),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    style: TextStyles.font14Medium(context).copyWith(
                      color: AppColors.whiteColor,
                    ),
                    cursorColor: AppColors.whiteColor,
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      hintStyle: TextStyles.font14Regular(context).copyWith(
                        color: AppColors.subGreyColor,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        // Sort button (placeholder)
        Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.secondaryColorTheme,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
          'Sort By',
            style: TextStyles.font14Medium(context).copyWith(
              color: AppColors.whiteColor,
            ),
          ),
        ),
      ],
    );
  }
}