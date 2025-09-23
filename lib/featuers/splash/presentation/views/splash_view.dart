import 'package:flutter/material.dart';
import 'package:iptv/featuers/splash/presentation/views/widgets/splash_view_body.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff4f2b1d),
      body: const SplashViewBody(),
    );
  }
}