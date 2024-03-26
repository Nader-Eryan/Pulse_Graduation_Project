import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pulse/Features/BottomNavBar/presentation/views/bottom_nav_bar_views.dart';
import 'package:pulse/Features/Profile/data/repo/profile_repo.dart';
import 'package:pulse/Features/Profile/data/repo/profile_repo_impl.dart';
import 'package:pulse/core/utils/constants.dart';
import 'package:pulse/core/utils/profile_pic.dart';
import 'package:pulse/core/utils/service_locator.dart';
import 'package:pulse/core/utils/styles.dart';
import 'package:pulse/core/widgets/custom_appbar.dart';
import 'package:pulse/core/widgets/custom_material_button.dart';
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
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numController = TextEditingController();
  final ProfileRepo profileRepo = ProfileRepoImpl();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    roleController.dispose();
    nameController.dispose();
    emailController.dispose();
    numController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ProfileEditController(),
      builder: (controller) => Scaffold(
        appBar: const CustomAppBar(title: 'Profile'),
        body: Padding(
          padding: const EdgeInsets.all(kPaddingView),
          child: SingleChildScrollView(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (controller.userData.value == null) {
                return const Center(
                  child: Text('No data available'),
                );
              }
              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    GestureDetector(
                      child: Column(
                        children: [
                          const ProfilePic(),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Change picture',
                            style: Styles.textStyleSemiBold14.copyWith(
                              color: const Color(0xff407CE2),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        controller.pickPicture(context);
                      },
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(const ResetPasswordView());
                      },
                      child: Text(
                        'Change Password',
                        style: Styles.textStyleSemiBold14
                            .copyWith(color: const Color(0xFF407CE2)),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * .03,
                    ),
                    CustomFormField(
                      data: controller.userData.value!['role'],
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
                      data: controller.userData.value!['name'],
                      controller: nameController,
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
                      height: 20,
                    ),
                    CustomFormField(
                      data: controller.userData.value!['email'],
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
                      height: 20,
                    ),
                    CustomFormField(
                      data: controller.userData.value!['num'],
                      isSuffixIcon: false,
                      isPassWord: false,
                      isPhone: true,
                      hintText: 'Phone number (optional)',
                      controller: numController,
                      prefixIcon: Icons.phone_in_talk,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return null;
                        } else if (!RegExp(r'''(^(?:[+0]9)?[0-9]{10,12}$)''')
                            .hasMatch(value)) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomMaterialButton(
                        text: 'Save Changes',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            profileRepo.updateUserData(
                              email: emailController.text,
                              name: nameController.text,
                              num: numController.text,
                              role: roleController.text,
                            );
                          }
                          Get.offAll(const BottomNavBarViews());
                        },
                        screenRatio: .9),
                  ],
                ),
              );
            }),
            // child: FutureBuilder<DocumentSnapshot>(
            //     future: getIt
            //         .get<FirebaseFirestore>()
            //         .collection('users')
            //         .doc(ProfileRepoImpl.uid)
            //         .get(),
            //     builder: (context, snapshot) {
            //       if (snapshot.hasError) {
            //         return const Center(child: Text('Something went wrong'));
            //       } else if (snapshot.connectionState ==
            //           ConnectionState.waiting) {
            //         return const Center(
            //           child: CircularProgressIndicator(),
            //         );
            //       } else if (!snapshot.hasData) {}
            //       return Form(
            //         key: _formKey,
            //         child: Column(
            //           children: [
            //             GestureDetector(
            //               child: Column(
            //                 children: [
            //                   const ProfilePic(),
            //                   const SizedBox(
            //                     height: 20,
            //                   ),
            //                   Text(
            //                     'Change picture',
            //                     style: Styles.textStyleSemiBold14.copyWith(
            //                       color: const Color(0xff407CE2),
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //               onTap: () {
            //                 controller.pickPicture(context);
            //               },
            //             ),
            //             TextButton(
            //               onPressed: () {
            //                 Get.to(const ResetPasswordView());
            //               },
            //               child: Text(
            //                 'Change Password',
            //                 style: Styles.textStyleSemiBold14
            //                     .copyWith(color: const Color(0xFF407CE2)),
            //               ),
            //             ),
            //             SizedBox(
            //               height: Get.height * .03,
            //             ),
            //             CustomFormField(
            //               data: snapshot.data!['role'],
            //               isSuffixIcon: true,
            //               isPassWord: false,
            //               hintText: 'Enter your role',
            //               controller: roleController,
            //               prefixIcon: FontAwesomeIcons.user,
            //               validator: (value) {
            //                 if (value == null || value.isEmpty) {
            //                   return 'Please enter your role';
            //                 }
            //                 return null;
            //               },
            //             ),
            //             const SizedBox(
            //               height: 20,
            //             ),
            //             CustomFormField(
            //               prefixIcon: FontAwesomeIcons.user,
            //               isSuffixIcon: false,
            //               isPassWord: false,
            //               hintText: 'Name',
            //               data: snapshot.data!['name'],
            //               controller: nameController,
            //               validator: (value) {
            //                 if (value == null || value.isEmpty) {
            //                   return 'Please enter your name';
            //                 } else if (!RegExp(r'^[a-zA-Z ]+$')
            //                     .hasMatch(value)) {
            //                   return 'Please enter a valid name';
            //                 }
            //                 return null;
            //               },
            //             ),
            //             const SizedBox(
            //               height: 20,
            //             ),
            //             CustomFormField(
            //               data: snapshot.data!['email'],
            //               isSuffixIcon: false,
            //               isPassWord: false,
            //               hintText: 'Enter your email',
            //               controller: emailController,
            //               prefixIcon: Icons.email_outlined,
            //               validator: (value) {
            //                 if (value == null || value.isEmpty) {
            //                   return 'Please enter your email';
            //                 } else if (!RegExp(
            //                         r'''^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$''')
            //                     .hasMatch(value)) {
            //                   return 'Please enter a valid email';
            //                 }
            //                 return null;
            //               },
            //             ),
            //             const SizedBox(
            //               height: 20,
            //             ),
            //             CustomFormField(
            //               data: snapshot.data?['num'],
            //               isSuffixIcon: false,
            //               isPassWord: false,
            //               isPhone: true,
            //               hintText: 'Phone number (optional)',
            //               controller: numController,
            //               prefixIcon: Icons.phone_in_talk,
            //               validator: (value) {
            //                 if (value == null || value.isEmpty) {
            //                   return null;
            //                 } else if (!RegExp(
            //                         r'''(^(?:[+0]9)?[0-9]{10,12}$)''')
            //                     .hasMatch(value)) {
            //                   return 'Please enter a valid number';
            //                 }
            //                 return null;
            //               },
            //             ),
            //             const SizedBox(
            //               height: 20,
            //             ),
            //             CustomMaterialButton(
            //                 text: 'Save Changes',
            //                 onPressed: () {
            //                   if (_formKey.currentState!.validate()) {
            //                     profileRepo.updateUserData(
            //                       email: emailController.text,
            //                       name: nameController.text,
            //                       num: numController.text,
            //                       role: roleController.text,
            //                     );
            //                   }
            //                   Get.offAll(const BottomNavBarViews());
            //                 },
            //                 screenRatio: .9),
            //           ],
            //         ),
            //       );
            //     }),
          ),
        ),
      ),
    );
  }
}
