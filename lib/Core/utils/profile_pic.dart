import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'functions/get_image_locally.dart';

class ProfilePic extends StatefulWidget {
  const ProfilePic({
    super.key,
  });

  @override
  State<ProfilePic> createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  String? profilePicPath;
  @override
  void initState() {
    getImage();
    super.initState();
  }

  void getImage() async {
    profilePicPath = await getProfileImage();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        radius: Get.width / 7,
        backgroundImage:
            profilePicPath != null ? FileImage(File(profilePicPath!)) : null);
  }
}
