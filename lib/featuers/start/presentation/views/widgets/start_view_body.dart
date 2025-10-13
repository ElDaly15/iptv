// ignore_for_file: use_build_context_synchronously, prefer_final_fields

import 'package:flutter/material.dart';

import 'package:get/get.dart' as g;
import 'package:iptv/core/utils/app_colors.dart';
import 'package:iptv/core/utils/app_images.dart';
import 'package:iptv/core/utils/app_styles.dart';
import 'package:iptv/core/widgets/btms/custom_btm_field.dart';
import 'package:iptv/core/widgets/fields/custom_text_field.dart';

import 'package:iptv/featuers/home/presentation/views/home_view.dart';

class StartViewBody extends StatefulWidget {
  const StartViewBody({super.key});

  @override
  State<StartViewBody> createState() => _StartViewBodyState();
}

class _StartViewBodyState extends State<StartViewBody> {
  @override
  void initState() {
    super.initState();
  }
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.onUserInteraction;

  @override
  Widget build(BuildContext context) {
    final Color leftBg = const Color(0xFF000000);
    final Color rightBg = AppColors.mainColorTheme;
    return Row(
      children: [
        Expanded(
          flex: 6,
          child: Container(
            color: leftBg,
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 820),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            Assets.imagesLogo,
                            width: 96,
                            height: 96,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Bee TV',
                            style: TextStyles.font22ExtraBold(
                              context,
                            ).copyWith(color: Colors.white, fontSize: 32),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'A New Experience',
                        style: TextStyles.font22Bold(
                          context,
                        ).copyWith(color: Colors.white),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Enjoy an extensive selection of movies, series and live TV on any device,\nwith a viewing experience designed for comfort and control.',
                        style: TextStyles.font18Medium(
                          context,
                        ).copyWith(color: Colors.white70, height: 1.4),
                      ),
                      const SizedBox(height: 28),
                      Text(
                        'Trial Notice: Your free trial will end soon.',
                        style: TextStyles.font14Medium(
                          context,
                        ).copyWith(color: Colors.white70),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Thank you for choosing our app — enjoy your time!',
                        style: TextStyles.font18ExtraBold(
                          context,
                        ).copyWith(color: Colors.white),
                      ),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 7,
          child: Container(
            color: rightBg,
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 560),
                  child: Form(
                    key: _formKey,
                    autovalidateMode: autovalidateMode,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Text(
                          'Continue Using the App',
                          style: TextStyles.font22ExtraBold(
                            context,
                          ).copyWith(color: Colors.white),
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          onChanged: (value) {},
                          hintText: 'User Name',
                          isPassword: false,
                          obscureText: false,
                          isInLogin: false,
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          onChanged: (value) {},
                          hintText: 'Password',
                          isPassword: true,
                          obscureText: true,
                          isInLogin: false,
                        ),
                        const SizedBox(height: 16),
                        BigElevatedBtm(
                          onPressed: () {
                           if(_formKey.currentState!.validate()){

                            g.Get.off(
                              () => const HomeView(),
                              transition: g.Transition.fade,
                              duration: const Duration(milliseconds: 400),
                            );
                           }
                           else{
                            setState(() {
                              autovalidateMode = AutovalidateMode.always;
                            });
                           }
                          },
                          title: 'Continue',
                        ),
                    
                        SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
