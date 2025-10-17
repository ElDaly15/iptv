
import 'package:flutter/material.dart';
import 'package:iptv/core/utils/app_colors.dart';
import 'package:iptv/core/utils/app_styles.dart';

class TopBar extends StatelessWidget {
  final ValueChanged<String>? onSearchChanged;

  const TopBar({super.key, this.onSearchChanged});

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
                    onChanged: onSearchChanged,
                  ),
                ),
              ],
            ),
          ),
        ),
       
      ],
    );
  }
}