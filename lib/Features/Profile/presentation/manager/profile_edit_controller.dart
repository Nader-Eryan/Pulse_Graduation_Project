import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulse/Core/utils/service_locator.dart';
import 'package:pulse/Features/Profile/data/repo/profile_repo_impl.dart';

import '../../../../core/utils/functions/firebase_storage.dart';
import '../../../../core/utils/functions/get_image_locally.dart';
import '../../../../core/utils/image_capture.dart';

class ProfileEditController extends GetxController {
  RxBool isLoading = true.obs;
  Rx<DocumentSnapshot?> userData = Rx<DocumentSnapshot?>(null);
  String? _imgPath;
  late String fName, sName;

  get imgPath => _imgPath;

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      isLoading.value = true;
      userData.value = await getIt
          .get<FirebaseFirestore>()
          .collection('users')
          .doc(ProfileRepoImpl.uid)
          .get();
    } catch (e) {
    } finally {
      isLoading.value = false;
    }
  }

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
