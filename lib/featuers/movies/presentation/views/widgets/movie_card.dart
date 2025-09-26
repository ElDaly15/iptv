// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:iptv/core/utils/app_colors.dart';
import 'package:iptv/core/utils/app_styles.dart';

class MovieCard extends StatelessWidget {
  final String title;

  const MovieCard({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondaryColorTheme,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: Container(
                color: AppColors.mainColorTheme.withOpacity(.6),
                alignment: Alignment.center,
                child: Icon(
                  Icons.movie,
                  size: 48,
                  color: AppColors.subGreyColor,
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(16),
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.secondaryColorTheme,
                  AppColors.secondaryColorTheme.withOpacity(.4),
                ],
              ),
            ),
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyles.font14Medium(
                context,
              ).copyWith(color: AppColors.whiteColor),
            ),
          ),
        ],
      ),
    );
  }
}
