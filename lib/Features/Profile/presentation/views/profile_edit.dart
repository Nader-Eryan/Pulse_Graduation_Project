import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pulse/core/utils/constants.dart';
import 'package:pulse/core/utils/profile_pic.dart';
import 'package:pulse/core/utils/service_locator.dart';
import 'package:pulse/core/utils/styles.dart';
import 'package:pulse/core/widgets/custom_appbar.dart';
import 'package:pulse/core/widgets/custom_text_form_field.dart';
import 'package:pulse/Features/Profile/presentation/manager/profile_edit_controller.dart';

import '../../../authentication/presentation/views/forgot_password_view.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({Key? key}) : super(key: key);

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  final TextEditingController roleController = TextEditingController();
  final String uid = getIt.get<FirebaseAuth>().currentUser!.uid;

  @override
  void dispose() {
    roleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Profile',
      ),
      body: Padding(
        padding: const EdgeInsets.all(kPaddingView),
        child: SingleChildScrollView(
          child: FutureBuilder<DocumentSnapshot>(
              future: getIt
                  .get<FirebaseFirestore>()
                  .collection('users')
                  .doc(uid)
                  .get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return Column(
                  children: [
                    GetBuilder<ProfileEditController>(
                      init: ProfileEditController(),
                      builder: (controller) => GestureDetector(
                        child: Column(
                          children: [
                            const ProfilePic(),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Change picture',
                              style: Styles.textStyleSemiBold16.copyWith(
                                color: const Color(0xff407CE2),
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          controller.pickPicture(context);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(const ResetPasswordView());
                      },
                      child: Text(
                        'Change Password',
                        style: Styles.textStyleSemiBold16
                            .copyWith(color: const Color(0xFF407CE2)),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * .03,
                    ),
                    CustomFormField(
                      data: snapshot.data!['role'],
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
                      data: snapshot.data!['name'],
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
                      data: snapshot.data!['email'],
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
                      data: snapshot.data?['num'],
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
                  ],
                );
              }),
        ),
      ),
    );
  }
}
