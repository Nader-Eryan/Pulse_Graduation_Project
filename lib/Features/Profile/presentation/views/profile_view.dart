import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pulse/Core/managers/language.dart';
import 'package:pulse/Core/utils/constants.dart';
import 'package:pulse/Core/utils/styles.dart';
import 'package:pulse/Features/Profile/presentation/views/uid.dart';
import 'package:pulse/Features/Profile/presentation/views/widgets/profile_item.dart';
import 'package:pulse/Features/authentication/presentation/views/authentication_view.dart';
import 'package:pulse/core/utils/profile_pic.dart';
import 'package:pulse/core/utils/sql_database.dart';
import 'package:pulse/generated/l10n.dart';

import '../../../../Core/utils/service_locator.dart';
import 'profile_edit.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kPaddingView),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //maneging mixsize in circle avatar
          const ProfilePic(),
          SizedBox(
            height: Get.height * .02,
          ),
          SizedBox(
            height: Get.height * .05,
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              radius: Get.width * .06,
              backgroundColor:
                  const Color(0xff407CE2).withGreen(200).withOpacity(0.3),
              child: SvgPicture.asset(
                'assets/images/language.svg',
                colorFilter: const ColorFilter.mode(
                  Color(0xff407CE2),
                  BlendMode.srcIn,
                ),
                height: Get.height * .03,
              ),
            ),
            title: Text(
              S.of(context).changeLanguage,
              style: Styles.textStyleSemiBold16,
            ),
            trailing: Obx(() => DropdownButton<String>(
                  value: LanguageController.to.language.value,
                  items: LanguageController.to.languages.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    LanguageController.to.switchLanguage();
                  },
                )),
          ),
          Divider(
            endIndent: 10.0,
            indent: 10.0,
            thickness: 1,
            color: const Color(0xff407CE2).withOpacity(0.15),
          ),
          SizedBox(
            height: Get.height * .01,
          ),
          ProfileItem(
            text: S.of(context).profileEdit,
            icon: 'assets/images/Profile.svg',
            onTap: () {
              Get.to(() => const ProfileEdit());
            },
          ),
          // ProfileItem(
          //   text: S.of(context).drugHistory,
          //   icon: 'assets/images/Document.svg',
          //   onTap: () {
          //     Get.to(() => const DrugHistory());
          //   },
          // ),
          ProfileItem(
            text: S.of(context).showMyUID,
            icon: 'assets/images/Wallet.svg',
            onTap: () {
              Get.to(UidView());
            },
          ),
          ProfileItem(
            text: S.of(context).faqs,
            icon: 'assets/images/Chat.svg',
            onTap: () {},
          ),

          ProfileItem(
            text: S.of(context).logout,
            icon: 'assets/images/layer1.svg',
            onTap: () {
              getIt<FirebaseAuth>().signOut().then((value) async {
                SqlDb sqlDb = SqlDb();
                await sqlDb.myDeleteDatabase();
                Get.offAll(() => const AuthenticationView());
              });
            },
          ),
        ],
      ),
    );
  }
}
