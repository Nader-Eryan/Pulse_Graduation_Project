import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:pulse/Features/Profile/data/repo/profile_repo.dart';
import 'package:pulse/core/utils/service_locator.dart';

class ProfileRepoImpl implements ProfileRepo {
  @override
  Future<void> updateUserData(
      {required String email,
      required String name,
      required String num,
      required String role}) {
    CollectionReference users =
        getIt.get<FirebaseFirestore>().collection('users');
    String uid = getIt.get<FirebaseAuth>().currentUser!.uid;
    return users.doc(uid).update(
        {'email': email, 'name': name, 'num': num, 'role': role}).then((value) {
      Get.snackbar('Awesome!', 'User data updated successfully.');
    }).catchError((error) {
      Get.snackbar('Alert!', 'Failed to update user data.');
    });
  }
}
