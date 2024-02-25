import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pulse/Core/utils/constants.dart';
import 'package:pulse/Core/utils/styles.dart';

class BottomNavBarViews extends StatefulWidget {
  const BottomNavBarViews({super.key});

  @override
  State<BottomNavBarViews> createState() => _BottomNavBarViewsState();
}

class _BottomNavBarViewsState extends State<BottomNavBarViews> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: Styles.textStyleSemiBold18,
    ),
    Text(
      'Index 1: Interactions',
      style: Styles.textStyleSemiBold18,
    ),
    Text(
      'Index 2: Meds history',
      style: Styles.textStyleSemiBold18,
    ),
    Text(
      'Index 3: Profile settings',
      style: Styles.textStyleSemiBold18,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.pills),
            label: 'Interactions',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.fileMedical),
            label: 'Medications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: kPrimaryColor,
        unselectedItemColor: Colors.grey,
        selectedIconTheme: const IconThemeData(size: 30),
        selectedFontSize: 14,
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor.withOpacity(.7),
        shape: const CircleBorder(),
        onPressed: () {},
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
