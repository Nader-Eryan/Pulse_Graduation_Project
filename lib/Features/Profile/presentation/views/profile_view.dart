import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulse/Core/utils/constants.dart';
import 'package:pulse/Core/utils/styles.dart';
import 'package:pulse/Features/Profile/presentation/views/widgets/profile_item.dart';
import 'package:pulse/Features/authentication/presentation/views/authentication_view.dart';
import 'package:pulse/core/utils/profile_pic.dart';
import 'package:pulse/core/utils/sql_database.dart';

import '../../../../Core/utils/service_locator.dart';
import 'drug_history.dart';
import 'profile_edit.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

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
          const Text(
            'Ruchita',
            style: Styles.textStyleSemiBold14,
          ),
          SizedBox(
            height: Get.height * .05,
          ),
          ProfileItem(
            text: 'Profile edit',
            icon: 'assets/images/Profile.svg',
            onTap: () {
              Get.to(() => const ProfileEdit());
            },
          ),
          ProfileItem(
            text: 'Drug history',
            icon: 'assets/images/Document.svg',
            onTap: () {
              Get.to(() => const DrugHistory());
            },
          ),
          ProfileItem(
            text: 'Donation',
            icon: 'assets/images/Wallet.svg',
            onTap: () {},
          ),
          ProfileItem(
            text: 'FAQs',
            icon: 'assets/images/Chat.svg',
            onTap: () {},
          ),
          ProfileItem(
            text: 'Logout',
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
