import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulse/Core/utils/styles.dart';

class CustomMaterialButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double screenRatio;
  const CustomMaterialButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.screenRatio,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * screenRatio,
      child: MaterialButton(
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        height: Get.height * 0.076,
        color: const Color(0xFF407CE2),
        child: Text(
          text,
          style: Styles.textStyleSemiBold16.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
