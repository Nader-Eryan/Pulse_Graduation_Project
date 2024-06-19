import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulse/Features/BottomNavBar/presentation/manager/nav_controller.dart';
import 'package:pulse/Features/home/presentation/views/home_view.dart';
import 'package:pulse/Features/BottomNavBar/presentation/views/interactions_view.dart';
import 'package:pulse/Features/medication/presentation/views/medication_view.dart';
import 'package:pulse/Features/BottomNavBar/presentation/views/widgets/add_new_medicine .dart';
import 'package:pulse/Features/Profile/presentation/views/profile_view.dart';
import 'package:pulse/Features/BottomNavBar/presentation/views/widgets/bottom_nav_bar_item.dart';
import 'package:pulse/core/utils/service_locator.dart';
import 'package:pulse/generated/l10n.dart';

class BottomNavBarViews extends StatefulWidget {
  const BottomNavBarViews({super.key});

  @override
  State<BottomNavBarViews> createState() => _BottomNavBarViewsState();
}

class _BottomNavBarViewsState extends State<BottomNavBarViews> {
  //int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeView(),
    InteractionsView(),
    MedicationView(),
    ProfileView(),
  ];

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavController>(
      init: NavController(),
      builder: (c) => Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          toolbarHeight: 0,
          elevation: 0.0,
          backgroundColor:
              c.index == 0 ? const Color(0xffD5EDF2) : Colors.white,
        ),
        body: SingleChildScrollView(
          child: _widgetOptions.elementAt(c.index),
        ),
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          child: BottomAppBar(
            color: Colors.white,
            shape: const CircularNotchedRectangle(),
            elevation: 1.0,
            notchMargin: 8.0,
            height: Get.height * .09,
            padding:
                EdgeInsetsDirectional.symmetric(horizontal: Get.width * .03),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                BottomNavBarItem(
                  onTap: () {
                    c.onItemTapped(0);
                  },
                  title: S.of(context).home,
                  selectedIcon: 'assets/images/selected_home.svg',
                  unSelectedIcon: 'assets/images/unselected_home.svg',
                  isSelected: c.index == 0,
                ),
                BottomNavBarItem(
                  onTap: () {
                    c.onItemTapped(1);
                  },
                  title: S.of(context).interactions,
                  selectedIcon: 'assets/images/selected_interactions.svg',
                  unSelectedIcon: 'assets/images/unselected_interactions.svg',
                  isSelected: c.index == 1,
                ),
                BottomNavBarItem(
                  onTap: () {
                    c.onItemTapped(2);
                  },
                  title: S.of(context).medication,
                  selectedIcon: 'assets/images/selected_medication.svg',
                  unSelectedIcon: 'assets/images/unselected_medication.svg',
                  isSelected: c.index == 2,
                ),
                BottomNavBarItem(
                  onTap: () {
                    c.onItemTapped(3);
                  },
                  title: S.of(context).profile,
                  selectedIcon: 'assets/images/selected_profile.svg',
                  unSelectedIcon: 'assets/images/unselected_profile.svg',
                  isSelected: c.index == 3,
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(
            Icons.add,
            color: Colors.blue,
          ),
          onPressed: () async {
            final String uid = getIt.get<FirebaseAuth>().currentUser!.uid;

            final res = await getIt
                .get<FirebaseFirestore>()
                .collection('users')
                .doc(uid)
                .get();
            if (res.exists &&
                res.data()!['role'] != null &&
                res.data()!['role'] == 'Care receiver') {
              Get.snackbar(
                  'Unauthorized edit', 'Change the role in edit profile!');
            } else {
              Get.to(const CustomFloatingActionButton());
            }
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
