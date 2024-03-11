import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulse/Features/home/presentation/views/home_view.dart';
import 'package:pulse/Features/BottomNavBar/presentation/views/interactions_view.dart';
import 'package:pulse/Features/BottomNavBar/presentation/views/medication_view.dart';
import 'package:pulse/Features/BottomNavBar/presentation/views/widgets/add_new_medicine .dart';
import 'package:pulse/Features/Profile/presentation/views/profile_view.dart';
import 'package:pulse/Features/BottomNavBar/presentation/views/widgets/bottom_nav_bar_item.dart';

class BottomNavBarViews extends StatefulWidget {
  const BottomNavBarViews({super.key});

  @override
  State<BottomNavBarViews> createState() => _BottomNavBarViewsState();
}

class _BottomNavBarViewsState extends State<BottomNavBarViews> {
  int _selectedIndex = 0;

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
