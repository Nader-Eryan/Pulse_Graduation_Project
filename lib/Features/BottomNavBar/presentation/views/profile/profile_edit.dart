import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pulse/Core/utils/constants.dart';
import 'package:pulse/Core/utils/styles.dart';
import 'package:pulse/Core/widgets/custom_appbar.dart';
import 'package:pulse/Core/widgets/custom_text_form_field.dart';

class ProfileEdit extends StatelessWidget {
  ProfileEdit({Key? key}) : super(key: key);
  final TextEditingController roleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Profile',
      ),
      body: Padding(
        padding: const EdgeInsets.all(kPaddingView),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CircleAvatar(
                radius: Get.width * .17,
                backgroundColor: Colors.black,
                child: CircleAvatar(
                  radius: Get.width * .168,
                  backgroundImage:
                      const AssetImage('assets/images/onboarding_meds.jpg'),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Change picture',
                  style: Styles.textStyleSemiBold16.copyWith(
                    color: const Color(0xff407CE2),
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * .06,
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
                height: 20,
              ),
              CustomFormField(
                prefixIcon: FontAwesomeIcons.user,
                isSuffixIcon: false,
                isPassWord: false,
                hintText: 'Name',
                data: 'Ruchita',
                controller: TextEditingController(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  } else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                    return 'Please enter a valid name';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CustomFormField(
                data: 'Sarah@gmail.com',
                isSuffixIcon: false,
                isPassWord: false,
                hintText: 'Enter your email',
                controller: TextEditingController(),
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
                height: 20,
              ),
              CustomFormField(
                data: '0154568',
                isSuffixIcon: false,
                isPassWord: false,
                hintText: 'Enter your Phone Number',
                controller: TextEditingController(),
                prefixIcon: Icons.phone_in_talk,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Phone Number';
                  } else if (!RegExp(r'''(^(?:[+0]9)?[0-9]{10,12}$)''')
                      .hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CustomFormField(
                data: '123456',
                isSuffixIcon: true,
                isPassWord: true,
                hintText: 'Enter your password',
                controller: TextEditingController(),
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
            ],
          ),
        ),
      ),
    );
  }
}
