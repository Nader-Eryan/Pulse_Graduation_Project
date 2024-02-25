import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulse/Core/utils/styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      leading: IconButton(
        padding: const EdgeInsets.all(22),
        icon: const Icon(Icons.arrow_back_ios, size: 25, color: Colors.black),
        onPressed: () {
          Get.back();
        },
      ),
      title: Text(title, style: Styles.textStyleBold18),
      centerTitle: true,
      backgroundColor: Colors.white,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
