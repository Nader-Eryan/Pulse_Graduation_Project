import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pulse/Features/Home/presentation/views/home_view.dart';

class Onboarding extends StatelessWidget {
  final String text;
  final String image;
  const Onboarding({super.key, required this.text, required this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {
            Get.to(const HomeView());
          },
          child: const Text(
            'Skip',
            style: TextStyle(color: Color(0XFFA1A8B0)),
          ),
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
          textAlign: TextAlign.center,
          maxLines: 3,
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(
          flex: 3,
        )
      ],
    );
  }
}
