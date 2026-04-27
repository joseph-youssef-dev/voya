import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:voya/features/driver_m/home/presentation/screens/addtrip.dart';
import 'package:voya/features/driver_m/home/presentation/screens/add_new_trip.dart';
import 'package:voya/features/driver_m/profile_driver/presentation/screens/profile_main.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int currentIndex = 0;

  final List<Widget> pages = const [
    CreateTrip(),
    AddNewTripPage(),
    DriverProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FE),
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 25,
              color: Colors.black.withOpacity(0.08),
              offset: const Offset(0, -5),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: const Color(0xFF0D32B3),
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: const Color(0xFFEBF1FF),
              color: const Color(0xFF5A6B87),
              tabs: const [
                GButton(
                  icon: Icons.dashboard_rounded,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.add_box_rounded,
                  text: 'Add Trip',
                ),
                GButton(
                  icon: Icons.person_rounded,
                  text: 'Profile',
                ),
              ],
              selectedIndex: currentIndex,
              onTabChange: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
