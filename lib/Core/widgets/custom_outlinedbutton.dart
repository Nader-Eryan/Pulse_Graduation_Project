import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulse/Core/utils/styles.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  final double screenRatio;

  const CustomOutlinedButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.screenRatio,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
          maximumSize: MaterialStateProperty.all(
              Size(Get.width * 0.7, Get.height * 0.076)),
          minimumSize: MaterialStateProperty.all(
              Size(Get.width * 0.7, Get.height * 0.076)),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          )),
          side: MaterialStateProperty.all(const BorderSide(
            color: Color(0xFF407CE2),
          ))),
      onPressed: onPressed,
      child: Text(
        text,
        style:
            Styles.textStyleSemiBold16.copyWith(color: const Color(0xFF407CE2)),
      ),
    );
  }
}
