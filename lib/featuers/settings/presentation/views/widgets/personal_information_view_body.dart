import 'package:flutter/material.dart';
import 'package:iptv/core/utils/app_colors.dart';
import 'package:iptv/core/utils/app_styles.dart';
import 'package:iptv/featuers/settings/presentation/views/widgets/custom_settings_list_tile.dart';

class PersonalInformationViewBody extends StatelessWidget {
  const PersonalInformationViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
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
                    child: const Icon(Icons.arrow_back_ios, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text('Personal Information', style: TextStyles.font22ExtraBold(context).copyWith(color: AppColors.whiteColor),),
                  ),
                ],
              ),
              const SizedBox(height: 24),
               CustomSettingsListTile(title: 'User : ElDaly15', ontap: (){
                
              },icon: Icons.person_2,),
              SizedBox(height: 16,),
              CustomSettingsListTile(title: 'Mac Address : 5d:12:00:a2:32', ontap: (){
                
              },icon: Icons.info,),
             
            ],
          ),
        ),
      ),
    );
  }
}