// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:iptv/core/utils/app_images.dart';
import 'package:iptv/core/utils/app_styles.dart';
import 'package:iptv/core/utils/app_colors.dart';
import 'package:intl/intl.dart';
import 'package:iptv/featuers/home/presentation/views/widgets/custom_circle_btm.dart';



class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  late String _timeText;
  late String _dateText;
  late final Ticker _ticker;

  @override
  void initState() {
    super.initState();
    _updateDateTime();
    _ticker = Ticker((_) {
      final DateTime now = DateTime.now();
      if (now.second == 0) {
        _updateDateTime();
      }
    })..start();
  }

  void _updateDateTime() {
    final DateTime now = DateTime.now();
    _timeText = DateFormat('hh:mm a').format(now);
    _dateText = DateFormat('EEEE, MMM d, yyyy').format(now);
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

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
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Row(children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.secondaryColorTheme.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.location_on, color: AppColors.yellowColor, size: 20),
                          const SizedBox(width: 6),
                          Text('Giza, Egypt', style: TextStyles.font14Medium(context).copyWith(color: AppColors.whiteColor)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                  ]),
                  const Spacer(),
                  Image.asset(Assets.imagesLogo ,scale: 6,),
                  const Spacer(), 
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(_timeText, style: TextStyles.font22ExtraBold(context).copyWith(color: AppColors.whiteColor)),
                      const SizedBox(height: 2),
                      Text(_dateText, style: TextStyles.font14Medium(context).copyWith(color: AppColors.subGreyColor)),
                    ],
                  ),
                ],
              ),
              Spacer(),
              Center(
                child: Wrap(
                  spacing: 36,
                  runSpacing: 28,
                  alignment: WrapAlignment.center,
                  children:  [
                    CircleButton(icon: Icons.tv, label: 'Live TV', onTap: (){}),
                    CircleButton(icon: Icons.local_movies, label: 'Movies', onTap: (){}),
                    CircleButton(icon: Icons.movie_creation_outlined, label: 'Series', onTap: (){}),
                  ],
                ),
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryColorTheme.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      'Trial ends: Sunday, Sep 22, 2025',
                      style: TextStyles.font14Medium(context).copyWith(color: AppColors.whiteColor),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Wrap(
                    spacing: 12,
                    children:  [
                      CircleAvatar( backgroundColor: AppColors.yellowColor.withOpacity(1), child: Icon(Icons.person, color: AppColors.whiteColor)),
                      CircleAvatar(backgroundColor: AppColors.yellowColor.withOpacity(1), child: Icon(Icons.settings , color: AppColors.whiteColor)),
                      CircleAvatar(backgroundColor: AppColors.yellowColor.withOpacity(1), child: Icon(Icons.refresh , color: AppColors.whiteColor)),
                      CircleAvatar(backgroundColor: AppColors.yellowColor.withOpacity(1), child: Icon(Icons.logout , color: AppColors.whiteColor)),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

