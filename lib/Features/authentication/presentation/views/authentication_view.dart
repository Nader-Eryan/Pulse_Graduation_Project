import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulse/Core/utils/styles.dart';
import 'package:pulse/Core/widgets/custom_materialbutton.dart';
import 'package:pulse/Core/widgets/custom_outlinedbutton.dart';
import 'package:pulse/Features/authentication/presentation/views/Signin_view.dart';
import 'package:pulse/Features/authentication/presentation/views/registration_view.dart';

class AuthenticationView extends StatelessWidget {
  const AuthenticationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/logoFree.png',
              width: double.infinity,
              height: Get.height * 0.5,
              color: const Color(0xFF407CE2),
            ),
            const Text(
              'Let’s get started!',
              style: Styles.textStyleBold22,
            ),
            const SizedBox(
              height: 30.0,
            ),
            CustomMaterialButton(
              screenRatio: 0.7,
              onPressed: () {
                Get.to(() =>  SignInView());
              },
              text: 'Login',
            ),
            const SizedBox(
              height: 20.0,
            ),
            CustomOutlinedButton(
                screenRatio: 0.7,
                onPressed: () {
                  Get.to(() => RegistrationView());
                },
                text: 'Sign Up'),
          ],
        ),
      ),
    );
  }
}
