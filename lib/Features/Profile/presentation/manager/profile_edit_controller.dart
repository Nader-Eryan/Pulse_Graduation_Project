import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/functions/firebase_storage.dart';
import '../../../../core/utils/functions/get_image_locally.dart';
import '../../../../core/utils/image_capture.dart';

class ProfileEditController extends GetxController {
  String? _imgPath;
  get imgPath => _imgPath;

  late String fName, sName;
  void pickPicture(BuildContext context) {
    Get.to(const ImageCapture());
    getImage();
  }

  void getImage() async {
    _imgPath = await getProfileImage();
  }

  void setImage(String selectedImage) {
    _imgPath = selectedImage;
    update();
    uploadFileRemotely(_imgPath!);
  }

  void uploadImage(String filePath) {
    uploadFileRemotely(filePath);
  }
}
