import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulse/Core/utils/constants.dart';
import 'package:pulse/Core/utils/styles.dart';
import 'package:pulse/Core/widgets/custom_text_form_field.dart';

import '../../../../Core/widgets/custom_material_button.dart';

class ResetPasswordView extends StatefulWidget {
  static const String id = 'reset_password';
  const ResetPasswordView({Key? key}) : super(key: key);

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final _key = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  static final auth = FirebaseAuth.instance;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future resetPassword({required String email}) async {
    await auth.sendPasswordResetEmail(email: email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: Get.width,
          height: Get.height,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(kPaddingView),
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close),
                  ),
                  const SizedBox(height: 70),
                  const Text("Forgot Password", style: Styles.textStyleBold22),
                  const SizedBox(height: 10),
                  const Text(
                    'Please enter your email address to recover your password.',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 40),
                  CustomFormField(
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      } else if (!RegExp(
                              r'''^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$''')
                          .hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    isSuffixIcon: false,
                    hintText: 'Email address',
                    isPassWord: false,
                  ),
                  const SizedBox(height: 16),
                  const Expanded(child: SizedBox()),
                  Material(
                    elevation: 2,
                    borderRadius: BorderRadius.circular(20),
                    child: CustomMaterialButton(
                      text: 'Recover password',
                      screenRatio: .9,
                      onPressed: () async {
                        if (_key.currentState!.validate()) {
                          try {
                            await resetPassword(
                                    email: _emailController.text.trim())
                                .then((value) {
                              Get.snackbar('success!', 'Check your email');
                            });
                          } catch (e) {
                            Get.snackbar('Opps!',
                                'There was an error reseting your password');
                          }
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
