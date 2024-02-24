import 'package:flutter/material.dart';

abstract class ProfileRepo {
  Future<void> signInWithGoogle(BuildContext context);
  Future<void> signInUser(BuildContext context, String email, String password);
  Future<void> registerUser(
      BuildContext context, String email, String password);
  Future<void> signInWithFacebook(BuildContext context);
  Future<void> resetPassword({required String email});
  Future<void> urlLauncher(String url);
}
