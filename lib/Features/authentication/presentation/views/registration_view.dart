import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pulse/Core/utils/styles.dart';
import 'package:pulse/Features/authentication/presentation/manager/sign_up_controller.dart';
import 'package:pulse/Features/authentication/presentation/views/widgets/agreement_checkbox.dart';
import 'package:pulse/Core/widgets/custom_appbar.dart';
import 'package:pulse/Core/widgets/custom_materialbutton.dart';
import 'package:pulse/Core/widgets/custom_text_form_field.dart';
import 'package:pulse/Features/authentication/data/repo/auth_repo_impl.dart';
import 'package:pulse/Features/authentication/presentation/views/signin_view.dart';

class RegistrationView extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailRegex =
      RegExp(r'''^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$''');
  final passwordRegex =
      r'''^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=]).{8,20}$''';
  final _profileReop = ProfileRepoImpl();
  RegistrationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Sign Up',
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                CustomFormField(
                  isSuffixIcon: false,
                  isPassWord: false,
                  hintText: 'Enter your name',
                  controller: nameController,
                  prefixIcon: FontAwesomeIcons.user,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomFormField(
                  isSuffixIcon: true,
                  isPassWord: false,
                  hintText: 'Enter your role',
                  controller: roleController,
                  prefixIcon: FontAwesomeIcons.user,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your role';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomFormField(
                  isSuffixIcon: false,
                  isPassWord: false,
                  hintText: 'Enter your email',
                  controller: emailController,
                  prefixIcon: Icons.email_outlined,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!emailRegex.hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomFormField(
                  isSuffixIcon: true,
                  isPassWord: true,
                  hintText: 'Enter your password',
                  controller: passwordController,
                  prefixIcon: Icons.lock_outline,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    } else if (!RegExp(passwordRegex).hasMatch(value)) {
                      return '8+ length, 1+ (digit, lower, upper, special char)';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                AgreementCheckbox(
                  profileRepo: _profileReop,
                ),
                const SizedBox(
                  height: 100,
                ),
                GetBuilder(
                  init: SignUpController(),
                  builder: (controller) => CustomMaterialButton(
                    screenRatio: 0.9,
                    text: 'Sign Up',
                    onPressed: () {
                      if (_formKey.currentState!.validate() &&
                          controller.isChecked) {
                        _profileReop.registerUser(context, emailController.text,
                            passwordController.text);
                      }
                      if (_formKey.currentState!.validate() &&
                          !controller.isChecked) {
                        Get.snackbar('Opps',
                            'You have to agree with our Privacy policy');
                      }
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?",
                        style: Styles.textStyleNormal14),
                    TextButton(
                      onPressed: () {
                        Get.off(() => SignInView());
                      },
                      child: Text(
                        'Sign In',
                        style: Styles.textStyleSemiBold14
                            .copyWith(color: const Color(0xFF407CE2)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
