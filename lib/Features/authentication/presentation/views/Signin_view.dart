import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulse/Core/utils/constants.dart';
import 'package:pulse/Core/utils/styles.dart';
import 'package:pulse/Core/widgets/custom_appbar.dart';
import 'package:pulse/Core/widgets/custom_material_button.dart';
import 'package:pulse/Core/widgets/custom_text_form_field.dart';
import 'package:pulse/Features/authentication/data/repo/auth_repo.dart';
import 'package:pulse/Features/authentication/data/repo/auth_repo_impl.dart';
import 'package:pulse/Features/authentication/presentation/views/forgot_password_view.dart';
import 'package:pulse/Features/authentication/presentation/views/registration_view.dart';
import 'package:pulse/generated/l10n.dart';
import '../../../../Core/widgets/outlined_button_icon_login.dart';

class SignInView extends StatelessWidget {
  SignInView({super.key});
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthRepo profileRepo = AuthRepoImpl();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: S.of(context).signIn,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(kPaddingView),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                CustomFormField(
                  isSuffixIcon: false,
                  isPassWord: false,
                  hintText: S.of(context).email,
                  controller: emailController,
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
                  controller: passwordController,
                  prefixIcon: Icons.lock_outline,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return S.of(context).confirmPassword;
                    }
                    return null;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          Get.to(const ResetPasswordView());
                        },
                        child: Text(
                          S.of(context).forgotPassword,
                          style: Styles.textStyleMedium14
                              .copyWith(color: const Color(0xFF407CE2)),
                        ))
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                CustomMaterialButton(
                  screenRatio: 0.9,
                  text: S.of(context).signIn,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      profileRepo.signInUser(context, emailController.text,
                          passwordController.text);
                    }
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(S.of(context).doNotHaveAnAccount,
                        style: Styles.textStyleNormal14),
                    TextButton(
                      onPressed: () {
                        Get.off(() => RegistrationView());
                      },
                      child: Text(
                        S.of(context).signUp,
                        style: Styles.textStyleSemiBold14
                            .copyWith(color: const Color(0xFF407CE2)),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Expanded(
                      child: Divider(),
                    ),
                    Center(
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 8,
                        ),
                        child: Text(
                          S.of(context).or,
                          style: Styles.textStyleNormal16
                              .copyWith(color: const Color(0xffA1A8B0)),
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Divider(),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                OutlinedButtonIconLogin(
                  image: 'assets/images/Google.jpg',
                  text: S.of(context).signInWithGoogle,
                  onPressed: () {
                    profileRepo.signInWithGoogle(context);
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                OutlinedButtonIconLogin(
                  image: 'assets/images/Facebook.jpg',
                  text: S.of(context).signInWithFacebook,
                  onPressed: () {
                    profileRepo.signInWithFacebook(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
