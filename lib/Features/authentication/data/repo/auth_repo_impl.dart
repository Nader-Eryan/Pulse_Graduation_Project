import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pulse/Features/authentication/data/repo/auth_repo.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../Core/utils/service_locator.dart';
import '../../../BottomNavBar/presentation/views/bottom_nav_bar_views.dart';

class ProfileRepoImpl implements ProfileRepo {
  @override
  Future<void> signInWithGoogle(BuildContext context) async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await getIt
        .get<FirebaseAuth>()
        .signInWithCredential(credential)
        .then((val) {
      Get.offAll(() => const BottomNavBarViews());
    });
  }

  @override
  Future<void> signInUser(
      BuildContext context, String email, String password) async {
    try {
      await getIt
          .get<FirebaseAuth>()
          .signInWithEmailAndPassword(email: email, password: password);
      // pushSnackBar(context, S.of(context).SignedInSuccessfullyEnjoy);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        if (context.mounted) {
          Get.snackbar('Alert', 'No user found for that email');
        }
      } else if (e.code == 'wrong-password') {
        if (context.mounted) {
          Get.snackbar(
            'Alert!',
            'Wrong password provided for that user',
          );
        }
      }
    }
  }

  @override
  Future<void> registerUser(
      BuildContext context, String email, String password) async {
    try {
      await getIt
          .get<FirebaseAuth>()
          .createUserWithEmailAndPassword(
            email: email,
            password: password,
          )
          .then((value) => Get.offAll(() => const BottomNavBarViews()));
      // pushSnackBar(context, S.of(context).RegisteredSuccessfullyEnjoy);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        if (context.mounted) {
          Get.snackbar(
            'Alert!',
            'The password is too weak',
          );
        }
      } else if (e.code == 'email-already-in-use') {
        if (context.mounted) {
          Get.snackbar(
            'Alert!',
            'The account already exists',
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        Get.snackbar('Opps!', '$e');
      }
    }
  }

  @override
  Future<void> signInWithFacebook(BuildContext context) async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await getIt.get<FacebookAuth>().login();

    // Create a credential from the access token
    if (loginResult.accessToken != null) {
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);
      // Once signed in, return the UserCredential
      getIt
          .get<FirebaseAuth>()
          .signInWithCredential(facebookAuthCredential)
          .then((val) {
        Get.offAll(() => const BottomNavBarViews());
      });
    }
  }

  @override
  Future<void> resetPassword({required String email}) async {
    await getIt.get<FirebaseAuth>().sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> urlLauncher(String url) async {
    Uri parsedUrl = Uri.parse(url);
    if (!await launchUrl(parsedUrl)) {
      throw Exception('Could not launch $url');
    }
  }
}
