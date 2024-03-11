import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
          width: 50.0,
          height: 50.0,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
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
        const SizedBox(height: 5.0),
        Text(text, style: Styles.textStyleNormal14),
      ],
    );
  }
}
