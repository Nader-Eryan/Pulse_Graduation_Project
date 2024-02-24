import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pulse/Core/utils/styles.dart';
import 'package:pulse/Features/BottomNavBar/presentation/views/bottom_nav_bar_views.dart';
import 'package:pulse/Features/authentication/presentation/views/authentication_view.dart';

class Onboarding extends StatelessWidget {
  final String text;
  final String image;
  const Onboarding({super.key, required this.text, required this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                Get.offAll(const AuthenticationView());
              },
              child: const Text(
                'Skip',
                style: TextStyle(color: Color(0XFFA1A8B0)),
              ),
            ),
          ],
        ),
        const Spacer(
          flex: 2,
        ),
        SizedBox(
          width: Get.width,
          height: Get.height * 0.6,
          child:
              image.contains('json') ? Lottie.asset(image) : Image.asset(image),
        ),
        const Spacer(
          flex: 4,
        ),
        Text(
          text,
          textAlign: TextAlign.start,
          maxLines: 3,
          style: Styles.textStyleBold22,
        ),
        const Spacer(
          flex: 3,
        )
      ],
    );
  }
}
