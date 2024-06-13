import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageController extends GetxController {
  static LanguageController get to => Get.find();
  final language = 'en'.obs;
  final languages = [
    'en',
    'ar',
  ].obs;

  @override
  void onInit() {
    super.onInit();
    _loadPreferredLanguage();
  }

  void _loadPreferredLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    language.value = prefs.getString('language') ?? 'en';
  }

  void switchLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String newLang = (language.value == 'en') ? 'ar' : 'en';
    await prefs.setString('language', newLang);
    language.value = newLang;
    Get.updateLocale(Locale(newLang, ''));
  }
}
