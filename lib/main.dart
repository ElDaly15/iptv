import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:iptv/featuers/live_tv/data/repos/iptv_live_repo/iptv_live_repo_impl.dart';
import 'package:iptv/featuers/splash/presentation/views/splash_view.dart';
import 'package:iptv/featuers/start/presentation/manager/auth_cubit/auth_cubit.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // Ensure app starts in portrait for the splash screen
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => BlocProvider(
        create: (context) => AuthCubit(),
        child: const MyApp(),
      ),
    ),

    


  );

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      builder: DevicePreview.appBuilder,
      locale: DevicePreview.locale(context),
      home: const SplashView(),
    );
  }
}
