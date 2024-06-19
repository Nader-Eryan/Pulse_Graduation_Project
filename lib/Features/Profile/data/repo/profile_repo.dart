import 'package:flutter/material.dart';

abstract class ProfileRepo {
  Future<void> updateUserData({
    required String email,
    required String cgUid,
    required String name,
    required String num,
    required String role,
    required TimeOfDay breakfast,
    required TimeOfDay lunch,
    required TimeOfDay dinner,
  });
}
