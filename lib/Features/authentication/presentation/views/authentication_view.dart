import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulse/Core/utils/styles.dart';
import 'package:pulse/Core/widgets/custom_material_button.dart';
import 'package:pulse/Core/widgets/custom_outlined_button.dart';
import 'package:pulse/Features/authentication/presentation/views/signin_view.dart';
import 'package:pulse/Features/authentication/presentation/views/registration_view.dart';
import 'package:pulse/generated/l10n.dart';

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
            Text(
              S.of(context).authenticationText,
              style: Styles.textStyleBold22,
            ),
            const SizedBox(
              height: 30.0,
            ),
            CustomMaterialButton(
              screenRatio: 0.7,
              onPressed: () {
                Get.to(() => SignInView());
              },
              text: S.of(context).login,
            ),
            const SizedBox(
              height: 20.0,
            ),
            CustomOutlinedButton(
              screenRatio: 0.7,
              onPressed: () {
                Get.to(() => RegistrationView());
              },
              text: S.of(context).signUp,
            ),
          ],
        ),
      ),
    );
  }
}
