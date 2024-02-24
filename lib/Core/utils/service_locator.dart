import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void serviceLocatorSetup() {
  getIt.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
  // getIt.registerSingleton<Future<SharedPreferences>>(
  //     SharedPreferences.getInstance());
  getIt.registerSingleton<FacebookAuth>(FacebookAuth.instance);
  getIt.registerSingleton<FirebaseMessaging>(FirebaseMessaging.instance);
}
