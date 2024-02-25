import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulse/Core/utils/constants.dart';
import 'package:pulse/Core/utils/styles.dart';
import 'package:pulse/Core/widgets/custom_appbar.dart';
import 'package:pulse/Core/widgets/custom_material_button.dart';
import 'package:pulse/Core/widgets/custom_text_form_field.dart';
import 'package:pulse/Features/authentication/presentation/views/registration_view.dart';
import '../../../../Core/widgets/outlined_button_icon_login.dart';

class SignInView extends StatelessWidget {
  SignInView({super.key});
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Sign In',
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
                  hintText: 'Enter your email',
                  controller: emailController,
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
                  controller: passwordController,
                  prefixIcon: Icons.lock_outline,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    } else if (!RegExp(
                            r'''^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=]).{8,20}$''')
                        .hasMatch(value)) {
                      return 'Password needs 8+ chars, 1+ digit, lower and upper case letters, and a special char';
                    }
                    return null;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          'Forgot Password?',
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
                  text: 'Sign In',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {}
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don’t have an account?",
                        style: Styles.textStyleNormal14),
                    TextButton(
                      onPressed: () {
                        Get.off(() => RegistrationView());
                      },
                      child: Text(
                        'Sign Up',
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
                          'OR',
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
                const OutlinedButtonIconLogin(
                  image: 'assets/images/Google.jpg',
                  text: 'Sign In with Google',
                ),
                const SizedBox(
                  height: 25,
                ),
                const OutlinedButtonIconLogin(
                  image: 'assets/images/Facebook.jpg',
                  text: 'Sign in with Facebook',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
