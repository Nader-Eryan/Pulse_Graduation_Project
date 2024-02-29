import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulse/Core/utils/styles.dart';
import 'package:pulse/Features/BottomNavBar/presentation/views/profile/drug_history.dart';
import 'package:pulse/Features/BottomNavBar/presentation/views/profile/profile_edit.dart';
import 'package:pulse/Features/BottomNavBar/presentation/views/widgets/profile_item.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //maneging mixsize in circle avatar
        CircleAvatar(
          radius: Get.width * .17,
          backgroundColor: Colors.black,
          child: CircleAvatar(
            radius: Get.width * .168,
            backgroundImage:
                const AssetImage('assets/images/onboarding_meds.jpg'),
          ),
        ),
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
            Get.to(() =>  ProfileEdit());
          },
        ),
        ProfileItem(
          text: 'Drug history',
          icon: 'assets/images/Document.svg',
          onTap: () {
            Get.to(() =>  const DrugHistory());
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
          onTap: () {},
        ),
      ],
    );
  }
}
