import 'package:flutter/material.dart';
import 'package:iptv/core/utils/app_colors.dart';
import 'package:iptv/core/utils/app_styles.dart';

class ChangePasswordViewBody extends StatelessWidget {
  const ChangePasswordViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.secondaryColorTheme, AppColors.mainColorTheme],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 15),
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back_ios, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text('Change Password', style: TextStyles.font22ExtraBold(context).copyWith(color: AppColors.whiteColor),),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}