import 'package:flutter/material.dart';
import 'package:get/get.dart' as g;
import 'package:iptv/core/utils/app_colors.dart';
import 'package:iptv/core/utils/app_styles.dart';
import 'package:iptv/featuers/settings/presentation/views/change_password_view.dart';
import 'package:iptv/featuers/settings/presentation/views/personal_information_view.dart';
import 'package:iptv/featuers/settings/presentation/views/widgets/custom_settings_list_tile.dart';

class SettingsViewBody extends StatelessWidget {
  const SettingsViewBody({super.key});

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Settings',
                      style: TextStyles.font22ExtraBold(
                        context,
                      ).copyWith(color: AppColors.whiteColor),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              CustomSettingsListTile(
                title: 'Personal Information',
                ontap: () {
                  g.Get.to(
                    () => const PersonalInformationView(),
                    transition: g.Transition.fade,
                    duration: const Duration(milliseconds: 400),
                  );
                },
                icon: Icons.person,
              ),
              SizedBox(height: 16),
              CustomSettingsListTile(
                title: 'Change Password',
                ontap: () {
                  g.Get.to(
                    () => const ChangePasswordView(),
                    transition: g.Transition.fade,
                    duration: const Duration(milliseconds: 400),
                  );
                },
                icon: Icons.password,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
