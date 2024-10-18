import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:pet_style_mobile/core/theme/colors.dart';
import 'package:pet_style_mobile/src/view/app/home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  void _goHome(BuildContext context) {
    Timer(const Duration(milliseconds: 2800), () {
      context.goNamed('home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          SizedBox(height: 70.h),
          Center(
            child: LottieBuilder.asset(
              'assets/lottie/pet_pw.json',
              height: 150.h,
              onLoaded: (p0) => _goHome(context),
            ),
          )
        ],
      ),
      nextScreen: const HomeScreen(),
      splashIconSize: 400.sp,
      backgroundColor: AppColors.primaryBackground,
      disableNavigation: true,
      nextRoute: '/home',
    );
  }
}
