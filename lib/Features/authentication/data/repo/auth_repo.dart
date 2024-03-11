import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthRepo {
  Future<void> signInWithGoogle(BuildContext context);
  Future<void> signInUser(BuildContext context, String email, String password);
  Future<void> registerUser(BuildContext context, String email, String password,
      {required String name});
  Future<void> signInWithFacebook(BuildContext context);
  Future<void> resetPassword({required String email});
  Future<void> urlLauncher(String url);
  Future<void> saveGoogleUserData(GoogleSignInAccount account);
  Future<void> saveFacebookUserData(Map<String, dynamic> userData);
  Future<void> saveUserData(String name, String email);
}
