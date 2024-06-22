import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pulse/core/utils/styles.dart';

class RefillDrugsPillBoxCircle extends StatelessWidget {
  final String text;
  final String image;
  const RefillDrugsPillBoxCircle(
      {super.key, required this.text, required this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 69,
          width: Get.width - 100,
          margin: const EdgeInsets.only(top: 0, left: 10, right: 10),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.elliptical(50, 50)),
            //shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [
                Color(0xff5E81E4),
                Color(0xffDBB6F2),
                Colors.white,
              ],
              end: Alignment.bottomCenter,
            ),
          ),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: SvgPicture.asset(
              image,
              colorFilter: text.contains('Refill')
                  ? null
                  : const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              width: 15.0,
              height: 15.0,
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
        const SizedBox(height: 5.0),
        Text(text, style: Styles.textStyleNormal14),
      ],
    );
  }
}
