import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulse/Features/Profile/data/repo/profile_repo.dart';
import 'package:pulse/core/utils/service_locator.dart';

class ProfileRepoImpl implements ProfileRepo {
  @override
  Future<void> updateUserData({
    required String cgUid,
    required String email,
    required String name,
    required String num,
    required String role,
    required TimeOfDay breakfast,
    required TimeOfDay lunch,
    required TimeOfDay dinner,
  }) {
    CollectionReference users =
        getIt.get<FirebaseFirestore>().collection('users');
    String uid = getIt.get<FirebaseAuth>().currentUser!.uid;
    return users.doc(uid).update({
      'email': email,
      'cgUid': cgUid,
      'name': name,
      'num': num,
      'role': role,
      'bfH': breakfast.hour,
      'bfM': breakfast.minute,
      'luH': lunch.hour,
      'luM': lunch.minute,
      'diH': dinner.hour,
      'diM': dinner.minute
    }).then((value) {
      Get.snackbar('Awesome!', 'User data updated successfully.');
    }).catchError((error) {
      Get.snackbar('Alert!', 'Failed to update user data.');
    });
  }
}
