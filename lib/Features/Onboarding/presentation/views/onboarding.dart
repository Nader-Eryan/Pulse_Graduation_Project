import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pulse/Core/managers/language.dart';
import 'package:pulse/Core/utils/styles.dart';
import 'package:pulse/Features/authentication/presentation/views/authentication_view.dart';
import 'package:pulse/generated/l10n.dart';

class Onboarding extends StatelessWidget {
  final String text;
  final String image;
  const Onboarding({super.key, required this.text, required this.image});

  @override
  Widget build(BuildContext context) {
    final languageController = Get.find<LanguageController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                languageController.switchLanguage();
              },
              child: Text(
                languageController.language.value.toUpperCase(),
                style: const TextStyle(color: Color(0XFFA1A8B0)),
              ),
            ),
            TextButton(
              onPressed: () {
                Get.offAll(() => const AuthenticationView());
              },
              child: Text(
                S.of(context).skip,
                style: const TextStyle(color: Color(0XFFA1A8B0)),
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
          style: Styles.textStyleSemiBold20,
        ),
        const Spacer(
          flex: 3,
        )
      ],
    );
  }
}
