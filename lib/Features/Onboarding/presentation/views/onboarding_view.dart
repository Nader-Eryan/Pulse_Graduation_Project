import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulse/Features/Onboarding/presentation/views/onboarding.dart';
import 'package:pulse/Features/authentication/presentation/views/authentication_view.dart';
import 'package:pulse/generated/l10n.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingView extends StatelessWidget {
  final controller = PageController();
  OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 40,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: controller,
                children: [
                  Onboarding(
                      image: 'assets/images/Animation - 1708289378340.json',
                      text: S.of(context).onboardingText1),
                  Onboarding(
                      image: 'assets/images/onboarding_meds.jpg',
                      text: S.of(context).onboardingText2),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SmoothPageIndicator(
                  controller: controller,
                  count: 2,
                  effect: const ExpandingDotsEffect(
                    activeDotColor: Color(0xFF407CE2),
                    dotColor: Color(0xFFD9D9D9),
                    dotHeight: 6.0,
                    dotWidth: 10.0,
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    controller.page == 1
                        ? Get.offAll(const AuthenticationView())
                        : controller.nextPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFF407CE2)),
                    fixedSize:
                        MaterialStateProperty.all<Size>(const Size(56, 56)),
                    shape: MaterialStateProperty.all<CircleBorder>(
                        const CircleBorder()),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
