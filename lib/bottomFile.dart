import 'package:flutter/material.dart';
import 'package:food_service/Home%20Screens/HomePage.dart';
import 'package:food_service/Order%20Screens/PreviousOrders.dart';
import 'package:food_service/Order%20Screens/pastOrders.dart';
import 'package:food_service/Search%20screens/SearchRestraunts.dart';
import 'package:food_service/Settings%20Screns/Account_Settings.dart';

import 'Search screens/search_Categories.dart';

class BottonNavigation extends StatefulWidget {
  BottonNavigation({
    super.key,
  });

  @override
  State<BottonNavigation> createState() => _BottonNavigationState();
}

class _BottonNavigationState extends State<BottonNavigation> {
  int bottomNavIndex = 0;
  final List name = [
    HomePage(
      address: "",
    ),
    SearchRestraunts(),
    PastOrders(),
    SearchCategories(),
    AccountSettings(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: name[bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          onTap: ((index) {
            setState(() {
              bottomNavIndex = index;
            });
          }),
          currentIndex: bottomNavIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.kitchen_sharp),
                label: "Home",
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: "Search",
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: Icon(Icons.border_outer_outlined),
                label: "Orders",
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: Icon(Icons.category),
                label: "Categories",
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Profile",
                backgroundColor: Colors.white),
          ]),
    );
  }
}
