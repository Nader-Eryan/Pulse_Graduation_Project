import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
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
import 'package:pulse/generated/l10n.dart';
import '../../../authentication/presentation/views/forgot_password_view.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({Key? key}) : super(key: key);

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  final TextEditingController roleController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController cgUidController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numController = TextEditingController();
  final ProfileRepo profileRepo = ProfileRepoImpl();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String uid = getIt.get<FirebaseAuth>().currentUser!.uid;
  TimeOfDay? bf = TimeOfDay.now(), lu = TimeOfDay.now(), di = TimeOfDay.now();
  @override
  void dispose() {
    roleController.dispose();
    nameController.dispose();
    emailController.dispose();
    numController.dispose();
    cgUidController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: S.of(context).profileEdit,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kPaddingView),
        child: SingleChildScrollView(
          child: FutureBuilder<DocumentSnapshot>(
              future: getIt
                  .get<FirebaseFirestore>()
                  .collection('users')
                  .doc(uid)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                      child: Text(
                    S.of(context).somethingWentWrong,
                  ));
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (!snapshot.hasData) {}

                return Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      GetBuilder<ProfileEditController>(
                        init: ProfileEditController(),
                        builder: (controller) => GestureDetector(
                          child: Column(
                            children: [
                              const ProfilePic(),
                              Text(
                                S.of(context).changePicture,
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
                      TextButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(EdgeInsets.zero),
                          visualDensity: VisualDensity.compact,
                        ),
                        onPressed: () {
                          Get.to(const ResetPasswordView());
                        },
                        child: Text(
                          S.of(context).changePassword,
                          style: Styles.textStyleSemiBold16
                              .copyWith(color: const Color(0xFF407CE2)),
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.022,
                      ),
                      CustomFormField(
                        data: snapshot.data!['role'],
                        isSuffixIcon: true,
                        isPassWord: false,
                        hintText: S.of(context).enterYourRole,
                        controller: roleController,
                        prefixIcon: FontAwesomeIcons.user,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return S.of(context).enterYourRole;
                          }
                          return null;
                        },
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: Get.height * 0.022,
                          ),
                          CustomFormField(
                            data: snapshot.data!['cgUid'],
                            isSuffixIcon: false,
                            isPassWord: false,
                            hintText: S.of(context).careGiverUid,
                            controller: cgUidController,
                            prefixIcon: Icons.link,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return null;
                              } else if (cgUidController.text.length < 28) {
                                return 'Wrong uid';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.022,
                      ),
                      CustomFormField(
                        prefixIcon: FontAwesomeIcons.user,
                        isSuffixIcon: false,
                        isPassWord: false,
                        hintText: S.of(context).name,
                        data: snapshot.data!['name'],
                        controller: nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return S.of(context).confirmName;
                          } else if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                            return S.of(context).validateName;
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: Get.height * 0.022,
                      ),
                      CustomFormField(
                        data: snapshot.data!['email'],
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
                      SizedBox(
                        height: Get.height * 0.022,
                      ),
                      CustomFormField(
                        data: snapshot.data?['num'],
                        isSuffixIcon: false,
                        isPassWord: false,
                        isPhone: true,
                        hintText: S.of(context).phoneNumber,
                        controller: numController,
                        prefixIcon: Icons.phone_in_talk,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return null;
                          } else if (!RegExp(r'''(^(?:[+0]9)?[0-9]{10,12}$)''')
                              .hasMatch(value)) {
                            return S.of(context).invalidNumber;
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: Get.height * 0.022,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            MaterialButton(
                                onPressed: () async {
                                  final breakfastT = showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay(
                                          hour: snapshot.data!['bfH'],
                                          minute: snapshot.data!['bfM']));
                                  bf = await breakfastT;
                                },
                                child: Text(
                                  S.of(context).breakfastTime,
                                  style: Styles.textStyleSemiBold14
                                      .copyWith(color: Colors.blue),
                                )),
                            MaterialButton(
                              onPressed: () async {
                                final lunchT = showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay(
                                        hour: snapshot.data!['luH'],
                                        minute: snapshot.data!['luM']));
                                lu = await lunchT;
                              },
                              child: Text(
                                S.of(context).lunchTime,
                                style: Styles.textStyleSemiBold14
                                    .copyWith(color: Colors.blue),
                              ),
                            ),
                            MaterialButton(
                              onPressed: () async {
                                final dinnerT = showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay(
                                        hour: snapshot.data!['diH'],
                                        minute: snapshot.data!['diM']));
                                di = await dinnerT;
                              },
                              child: Text(
                                S.of(context).dinnerTime,
                                style: Styles.textStyleSemiBold14
                                    .copyWith(color: Colors.blue),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomMaterialButton(
                          text: S.of(context).saveChanges,
                          onPressed: () {
                            if (_formKey.currentState!.validate() &&
                                (bf != null || snapshot.data!['bfH'] != null) &&
                                (lu != null || snapshot.data!['luH'] != null) &&
                                (di != null || snapshot.data!['diH'] != null)) {
                              profileRepo.updateUserData(
                                cgUid: cgUidController.text,
                                email: emailController.text,
                                name: nameController.text,
                                num: numController.text,
                                role: roleController.text,
                                breakfast: bf ??
                                    TimeOfDay(
                                        hour: snapshot.data!['bfH'],
                                        minute: snapshot.data!['bfM']),
                                lunch: lu ??
                                    TimeOfDay(
                                        hour: snapshot.data!['luH'],
                                        minute: snapshot.data!['luM']),
                                dinner: di ??
                                    TimeOfDay(
                                        hour: snapshot.data!['diH'],
                                        minute: snapshot.data!['diM']),
                              );
                            } else if (bf == null || lu == null || di == null) {
                              Get.snackbar(
                                  S.of(context).failedSnackBar,
                                  S
                                      .of(context)
                                      .makeSureThatYouPickedAllMealTime);
                            }
                          },
                          screenRatio: .9),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
