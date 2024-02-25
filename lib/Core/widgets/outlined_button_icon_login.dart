import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OutlinedButtonIconLogin extends StatelessWidget {
  final String image;
  final String text;
  final VoidCallback onPressed;
  const OutlinedButtonIconLogin(
      {Key? key,
      required this.image,
      required this.text,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.9,
      height: Get.height * 0.08,
      child: OutlinedButton.icon(
        icon: Image.asset(image),
        onPressed: onPressed,
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              side: const BorderSide(color: Color(0xFFE5E7EB), width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
        ),
        label: Text(
          text,
          style: const TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
