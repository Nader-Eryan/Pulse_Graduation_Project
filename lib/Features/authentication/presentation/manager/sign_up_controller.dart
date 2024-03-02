import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  late bool isChecked = false;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  void changeCheckBox() {
    isChecked = !isChecked;
    update();
  }

  @override
  void onClose() {
    nameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    super.onClose();
  }
}
