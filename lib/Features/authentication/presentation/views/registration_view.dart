import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pulse/Core/utils/constants.dart';
import 'package:pulse/Core/utils/styles.dart';
import 'package:pulse/Features/authentication/presentation/manager/sign_up_controller.dart';
import 'package:pulse/Features/authentication/presentation/views/widgets/agreement_checkbox.dart';
import 'package:pulse/Core/widgets/custom_appbar.dart';
import 'package:pulse/Core/widgets/custom_material_button.dart';
import 'package:pulse/Core/widgets/custom_text_form_field.dart';
import 'package:pulse/Features/authentication/data/repo/auth_repo_impl.dart';
import 'package:pulse/Features/authentication/presentation/views/signin_view.dart';

class RegistrationView extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _profileReop = AuthRepoImpl();
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
          padding: const EdgeInsets.all(kPaddingView),
          child: Form(
            key: _formKey,
            child: GetBuilder(
              init: SignUpController(),
              builder: (controller) => Column(
                children: <Widget>[
                  CustomFormField(
                    isSuffixIcon: false,
                    isPassWord: false,
                    hintText: 'Enter your name',
                    controller: controller.nameController,
                    prefixIcon: FontAwesomeIcons.user,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      } else if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                        return 'Please enter a valid name';
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
                    controller: controller.emailController,
                    prefixIcon: Icons.email_outlined,
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
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomFormField(
                    isSuffixIcon: true,
                    isPassWord: true,
                    hintText: 'Enter your password',
                    controller: controller.passwordController,
                    prefixIcon: Icons.lock_outline,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      } else if (!RegExp(
                              r'''^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=]).{8,20}$''')
                          .hasMatch(value)) {
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
                  CustomMaterialButton(
                    screenRatio: 0.9,
                    text: 'Sign Up',
                    onPressed: () {
                      if (_formKey.currentState!.validate() &&
                          controller.isChecked) {
                        _profileReop.registerUser(
                            context,
                            controller.emailController.text,
                            controller.passwordController.text,
                            name: controller.nameController.text);
                      }
                      if (_formKey.currentState!.validate() &&
                          !controller.isChecked) {
                        Get.snackbar('Opps',
                            'You have to agree with our Privacy policy');
                      }
                    },
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
      ),
    );
  }
}
