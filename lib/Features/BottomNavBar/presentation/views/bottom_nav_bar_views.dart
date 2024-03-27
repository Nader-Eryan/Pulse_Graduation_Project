import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulse/Features/BottomNavBar/utils/functions/check_role.dart';
import 'package:pulse/Features/Profile/presentation/views/profile_edit.dart';
import 'package:pulse/Features/home/presentation/views/home_view.dart';
import 'package:pulse/Features/BottomNavBar/presentation/views/interactions_view.dart';
import 'package:pulse/Features/medication/presentation/views/medication_view.dart';
import 'package:pulse/Features/BottomNavBar/presentation/views/add_new_medicine_view.dart';
import 'package:pulse/Features/Profile/presentation/views/profile_view.dart';
import 'package:pulse/Features/BottomNavBar/presentation/views/widgets/bottom_nav_bar_item.dart';

class BottomNavBarViews extends StatefulWidget {
  const BottomNavBarViews({super.key});

  @override
  State<BottomNavBarViews> createState() => _BottomNavBarViewsState();
}

class _BottomNavBarViewsState extends State<BottomNavBarViews> {
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    checkRole();
  }

  static const List<Widget> _widgetOptions = <Widget>[
    HomeView(),
    InteractionsView(),
    MedicationView(),
    ProfileView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> checkRole() async {
    bool roleIsNull = await isRoleNull();
    if (roleIsNull) {
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Alert !'),
            content: const Text(
                'Please enter your role and main meals of the day to continue'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () async {
                  //_onItemTapped(3);
                  await Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const ProfileEdit(),
                    ),
                  );
                  checkRole();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0.0,
        backgroundColor:
            _selectedIndex == 0 ? const Color(0xffD5EDF2) : Colors.white,
      ),
      body: SingleChildScrollView(
        child: _widgetOptions.elementAt(_selectedIndex),
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
          padding: EdgeInsetsDirectional.symmetric(horizontal: Get.width * .03),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              BottomNavBarItem(
                onTap: () {
                  _onItemTapped(0);
                },
                title: 'Home',
                selectedIcon: 'assets/images/selected_home.svg',
                unSelectedIcon: 'assets/images/unselected_home.svg',
                isSelected: _selectedIndex == 0,
              ),
              BottomNavBarItem(
                onTap: () {
                  _onItemTapped(1);
                },
                title: 'Interactions',
                selectedIcon: 'assets/images/selected_interactions.svg',
                unSelectedIcon: 'assets/images/unselected_interactions.svg',
                isSelected: _selectedIndex == 1,
              ),
              BottomNavBarItem(
                onTap: () {
                  _onItemTapped(2);
                },
                title: 'Medication',
                selectedIcon: 'assets/images/selected_medication.svg',
                unSelectedIcon: 'assets/images/unselected_medication.svg',
                isSelected: _selectedIndex == 2,
              ),
              BottomNavBarItem(
                onTap: () {
                  _onItemTapped(3);
                },
                title: 'Profile',
                selectedIcon: 'assets/images/selected_profile.svg',
                unSelectedIcon: 'assets/images/unselected_profile.svg',
                isSelected: _selectedIndex == 3,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: const CustomFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
