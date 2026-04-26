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
    CreateTrip(), // Home
    AddNewTripPage(), // Add
    DriverProfileScreen(), // Profile
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FE),
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: GNav(
            selectedIndex: currentIndex,
            onTabChange: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            activeColor: const Color(0xFF0D32B3),
            tabBackgroundColor: const Color(0xFFEBF1FF),
            color: Colors.grey.shade500,
            gap: 8,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            tabs: const [
              GButton(
                icon: Icons.home_outlined,
                text: 'HOME',
              ),
              GButton(
                icon: Icons.add_circle_outline,
                text: 'ADD',
              ),
              GButton(
                icon: Icons.person_outline,
                text: 'PROFILE',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
