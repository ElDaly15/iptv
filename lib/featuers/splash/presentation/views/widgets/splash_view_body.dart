
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' as g;
import 'package:iptv/core/services/secure_storage.dart';
import 'package:iptv/core/utils/app_images.dart';
import 'package:iptv/featuers/home/presentation/views/home_view.dart';
import 'package:iptv/featuers/start/presentation/views/start_view.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    // Lock orientation to portrait on splash
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 0.86).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.slowMiddle,
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );

    _animationController.forward();

    Future.delayed(const Duration(milliseconds: 3500), () async {
      String? token =await getToken();
      if(token != null){
        g.Get.off(() => const HomeView(),
          transition: g.Transition.fade,
          duration: const Duration(milliseconds: 400));
      }else{
        g.Get.off(() => const StartView(),
        transition: g.Transition.fade,
        duration: const Duration(milliseconds: 400));
    }});
  }

  @override
  void dispose() {
    // Optional: don't reset here to keep next screens in landscape
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return FadeTransition(
                opacity: _fadeAnimation,
                child: Transform.scale(
                  scale: _scaleAnimation.value,
                  child: child,
                ),
              );
            },
            child: Image.asset(Assets.imagesLogo),
          ),
        ),
      ],
    );
  }
}