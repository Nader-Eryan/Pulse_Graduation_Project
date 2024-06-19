import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pulse/Features/authentication/data/repo/auth_repo.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../Core/utils/service_locator.dart';
import '../../../BottomNavBar/presentation/views/bottom_nav_bar_views.dart';

class AuthRepoImpl implements AuthRepo {
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
      saveGoogleUserData(googleUser!);
      Get.offAll(() => const BottomNavBarViews());
    });
  }

  @override
  Future<void> signInUser(
      BuildContext context, String email, String password) async {
    try {
      await getIt
          .get<FirebaseAuth>()
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        Get.offAll(() => const BottomNavBarViews());
      });
      // pushSnackBar(context, S.of(context).SignedInSuccessfullyEnjoy);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        if (context.mounted) {
          Get.snackbar('Alert!', 'No user found for that email');
        }
      } else if (e.code == 'wrong-password') {
        if (context.mounted) {
          Get.snackbar(
            'Alert!',
            'Wrong password provided for that user',
          );
        }
      } else {
        Get.snackbar('Alert!', 'Wrong credentials!');
      }
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

  @override
  Future<void> saveGoogleUserData(GoogleSignInAccount account) async {
    String uid = getIt.get<FirebaseAuth>().currentUser!.uid;
    if (!await checkExist(uid)) {
      getIt.get<FirebaseFirestore>().collection('users').doc(uid).set({
        'cgUid': null,
        'email': account.email,
        'name': account.displayName,
        'profilePic': account.photoUrl,
        'role': null,
        'num': null,
        'bfH': 12,
        'bfM': 0,
        'luH': 12,
        'luM': 0,
        'diH': 12,
        'diM': 0
      });
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
          .then((val) async {
        Map<String, dynamic> userData = await getIt<FacebookAuth>()
            .getUserData(fields: 'email,name,picture');
        saveFacebookUserData(userData);
        Get.offAll(() => const BottomNavBarViews());
      });
    }
  }

  @override
  Future<void> saveFacebookUserData(Map<String, dynamic> userData) async {
    String uid = getIt.get<FirebaseAuth>().currentUser!.uid;
    if (!await checkExist(uid)) {
      getIt.get<FirebaseFirestore>().collection('users').doc(uid).set({
        'cgUid': null,
        'email': userData['email'],
        'name': userData['name'],
        'profilePic': null,
        'role': null,
        'num': null,
        'bfH': 12,
        'bfM': 0,
        'luH': 12,
        'luM': 0,
        'diH': 12,
        'diM': 0
      });
    }
  }

  @override
  Future<void> registerUser(BuildContext context, String email, String password,
      {required String name}) async {
    try {
      await getIt
          .get<FirebaseAuth>()
          .createUserWithEmailAndPassword(
            email: email,
            password: password,
          )
          .then((value) {
        saveUserData(name, email);
        return Get.offAll(() => const BottomNavBarViews());
      });
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
  Future<void> saveUserData(String name, String email) async {
    String uid = getIt.get<FirebaseAuth>().currentUser!.uid;
    getIt.get<FirebaseFirestore>().collection('users').doc(uid).set({
      'cgUid': null,
      'email': email,
      'name': name,
      'profilePic': null,
      'role': null,
      'num': null,
      'bfH': 12,
      'bfM': 0,
      'luH': 12,
      'luM': 0,
      'diH': 12,
      'diM': 0
    });
  }

  Future<bool> checkExist(String docID) async {
    bool exist = false;
    try {
      await getIt
          .get<FirebaseFirestore>()
          .collection("users")
          .doc(docID)
          .get()
          .then((doc) {
        exist = doc.exists;
      });
      return exist;
    } catch (e) {
      // If any error
      return false;
    }
  }
}
