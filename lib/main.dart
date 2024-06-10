import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulse/Features/Onboarding/presentation/views/splash_view.dart';
import 'package:pulse/core/utils/service_locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pulse/core/utils/sql_database.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  serviceLocatorSetup();
  SqlDb sqlDb = SqlDb();
  await sqlDb.initiateDb();
  //sqlDb.myDeleteDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const SplashView(),
    );
  }
}
