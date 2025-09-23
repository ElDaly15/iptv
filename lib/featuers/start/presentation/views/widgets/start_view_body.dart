import 'package:flutter/material.dart';
import 'package:iptv/core/utils/app_colors.dart';
import 'package:iptv/core/utils/app_images.dart';
import 'package:iptv/core/utils/app_styles.dart';

class StartViewBody extends StatelessWidget {
  const StartViewBody({super.key});

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
                          const SizedBox(width: 16),
                          Text(
                            'Bee TV',
                             style: TextStyles
                                 .font22ExtraBold(context)
                                 .copyWith(color: Colors.white, fontSize: 44),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'A New Experience',
                         style: TextStyles
                             .font22Bold(context)
                             .copyWith(color: Colors.white),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Enjoy an extensive selection of movies, series and live TV on any device,\nwith a viewing experience designed for comfort and control.',
                         style: TextStyles
                             .font18Medium(context)
                             .copyWith(color: Colors.white70, height: 1.4),
                      ),
                      const SizedBox(height: 28),
                      Text(
                        'Trial Notice: Your free trial will end soon.',
                         style: TextStyles
                             .font14Medium(context)
                             .copyWith(color: Colors.white70),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Thank you for choosing our app — enjoy your time!',
                         style: TextStyles
                             .font18ExtraBold(context)
                             .copyWith(color: Colors.white),
                      ),
                     
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Container(
            color: rightBg,
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 560),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      SizedBox(height: 20,),
                      Text(
                        'Continue Using the App',
                        style: TextStyles
                            .font22ExtraBold(context)
                            .copyWith(color: Colors.white),
                      ),
                      const SizedBox(height: 16),
                      _step(
                        context,
                        icon: Icons.public,
                        text: 'Visit: https://iboplayer.com',
                      ),
                      const SizedBox(height: 8),
                      _step(
                        context,
                        icon: Icons.login,
                        text:
                            'Sign in with your Device ID and Device Key to add a playlist.',
                      ),
                      const SizedBox(height: 12),
                      _deviceInfo(context,
                          label: 'Device ID', value: '0d:17:78:26:d4:6e'),
                      const SizedBox(height: 8),
                      _deviceInfo(context, label: 'Device Key', value: '901370'),
                      const SizedBox(height: 20),
                      _step(
                        context,
                        icon: Icons.playlist_add_check,
                        text:
                            'Add your favorite playlist, then restart the app to enjoy updates.',
                      ),
                      const SizedBox(height: 12),
                      Center(
                        child: SizedBox(
                          width: 280,
                          height: 54,
                          child: FilledButton(
                            style: FilledButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              foregroundColor: Colors.white,
                              side: const BorderSide(color: Colors.white, width: 2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            onPressed: () {},
                             child: Text(
                               'Agree',
                               style: TextStyles
                                   .font18SemiBold(context)
                                   .copyWith(color: Colors.white),
                             ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30,)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  

  Widget _step(BuildContext context, {required IconData icon, required String text}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.white, size: 22),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: TextStyles
                .font18Medium(context)
                .copyWith(color: Colors.white, height: 1.35),
          ),
        )
      ],
    );
  }

  Widget _deviceInfo(BuildContext context, {required String label, required String value}) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$label:',
                  style: TextStyles
                      .font14SemiBold(context)
                      .copyWith(color: Colors.white70),
                ),
                const SizedBox(height: 4),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: SelectableText(
                    value,
                    style: TextStyles
                        .font20ExtraBold(context)
                        .copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.copy, color: Colors.white),
        )
      ],
    );
  }
}

