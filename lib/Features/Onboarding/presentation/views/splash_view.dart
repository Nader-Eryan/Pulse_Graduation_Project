import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulse/Features/BottomNavBar/presentation/views/bottom_nav_bar_views.dart';
import 'package:pulse/Features/Onboarding/presentation/views/onboarding_view.dart';
import 'package:pulse/core/utils/service_locator.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  double _logoWidth = 100;
  @override
  void initState() {
    Future.delayed(const Duration(microseconds: 50), () {
      _logoWidth = _logoWidth == 100 ? 400 : 100;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          DecoratedBox(
            position: DecorationPosition.background,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                repeat: ImageRepeat.noRepeat,
                image: const AssetImage(
                  'assets/images/splashGround.jpg',
                ),
                colorFilter: ColorFilter.mode(
                    Colors.blue.withOpacity(0.1), BlendMode.colorBurn),
              ),
            ),
            child: Center(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 1200),
                curve: Curves.fastOutSlowIn,
                width: _logoWidth,
                child: Image.asset(
                  'assets/images/logoFree.png',
                  height: Get.height,
                  color: Colors.blue,
                ),
                onEnd: () {
                  if (getIt.get<FirebaseAuth>().currentUser != null) {
                    Get.off(() => const BottomNavBarViews());
                  } else {
                    Get.off(() => OnboardingView());
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
