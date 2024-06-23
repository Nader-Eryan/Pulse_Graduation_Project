import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:pulse/Core/managers/connectivity_services.dart';
import 'package:pulse/Core/managers/language.dart';
import 'package:pulse/Core/managers/notification_services.dart';
import 'package:pulse/Core/utils/sql_database.dart';
import 'package:pulse/Features/Onboarding/presentation/views/splash_view.dart';
import 'package:pulse/core/utils/service_locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  serviceLocatorSetup();
  SqlDb sqlDb = SqlDb();
  await sqlDb.initiateDb();
  // USqlDb sqlDb = USqlDb();
  // await sqlDb.initiateDb();

  // Initialize the ConnectivityController
  final connectivityController = Get.put(ConnectivityController());
  await connectivityController.initConnectivity();

  LocalNotificationServices().initialize();
  // String role = await getUserRole();
  // if (role == 'Care receiver') {
  //   LocalNotificationServices().showScheduledNotification();
  // }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final connectivityController = Get.find<ConnectivityController>();
    final languageController = Get.find<
        LanguageController>(); // Get the instance of LanguageController

    //for testing
    return Obx(() {
      return GetMaterialApp(
        locale: Locale(languageController.language.value, ''),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: !connectivityController.isConnected.value
            ? const Scaffold(
                body: AlertDialog(
                  title: Text('No Internet Connection'),
                  content: Text(
                      'Please check your internet connection and try again.'),
                ),
              )
            : const SplashView(),
      );
    });
  }
}
