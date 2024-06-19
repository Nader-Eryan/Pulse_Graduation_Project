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
import 'package:pulse/generated/l10n.dart';

class RegistrationView extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _profileReop = AuthRepoImpl();
  RegistrationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: S.of(context).signUp,
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
                    hintText: S.of(context).name,
                    controller: controller.nameController,
                    prefixIcon: FontAwesomeIcons.user,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return S.of(context).confirmName;
                      } else if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                        return S.of(context).validateName;
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
                    hintText: S.of(context).email,
                    controller: controller.emailController,
                    prefixIcon: Icons.email_outlined,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return S.of(context).confirmEmail;
                      } else if (!RegExp(
                              r'''^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$''')
                          .hasMatch(value)) {
                        return S.of(context).validateEmail;
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
                    hintText: S.of(context).password,
                    controller: controller.passwordController,
                    prefixIcon: Icons.lock_outline,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return S.of(context).confirmPassword;
                      } else if (!RegExp(
                        r'''^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=]).{8,20}$''',
                      ).hasMatch(value)) {
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
                    text: S.of(context).signUp,
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
                        Get.snackbar(S.of(context).failedSnackBar,
                            S.of(context).agreePrivacyPolicy);
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(S.of(context).alreadyHaveAnAccount,
                            style: Styles.textStyleNormal14),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.off(() => SignInView());
                        },
                        child: Text(
                          S.of(context).signIn,
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
