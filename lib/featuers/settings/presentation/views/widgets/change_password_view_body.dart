import 'package:flutter/material.dart';
import 'package:iptv/core/utils/app_colors.dart';
import 'package:iptv/core/utils/app_styles.dart';
import 'package:iptv/core/widgets/btms/custom_btm_field.dart';
import 'package:iptv/core/widgets/fields/custom_text_field.dart';

class ChangePasswordViewBody extends StatefulWidget {
  const ChangePasswordViewBody({super.key});

  @override
  State<ChangePasswordViewBody> createState() => _ChangePasswordViewBodyState();
}

class _ChangePasswordViewBodyState extends State<ChangePasswordViewBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
   AutovalidateMode autovalidateMode = AutovalidateMode.onUserInteraction;
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
          child: Form(
            key: _formKey,
            autovalidateMode: autovalidateMode,
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
                const SizedBox(height: 24),
                CustomTextField(
                  hintText: 'Old Password',
                  isPassword: true,
                  obscureText: true,
                  onChanged: (value){},
                  isInLogin: false,
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  hintText: 'New Password',
                  isPassword: true,
                  
                  obscureText: true,
                  onChanged: (value){},
                  isInLogin: false,
                ),
                const SizedBox(height: 24),
                BigElevatedBtm(
                  onPressed: (){
                    if(_formKey.currentState!.validate()){

                    }
                    else{
                      setState(() {
                        autovalidateMode = AutovalidateMode.always;
                      });
                    }
                  },
                  title: 'Change Password',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}