import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:voya/core/constants/app_colors.dart';
import 'package:voya/features/passenger/history/presentation/screens/passenger_history_screen.dart';
import 'package:voya/features/passenger/home/presentation/screens/passenger_home_screen.dart';
import 'package:voya/features/passenger/profile/presentation/screens/passenger_profile_screen.dart';
import 'package:voya/features/passenger/search/presentation/screens/passenger_search_screen.dart';

class PassengerMainScreen extends StatefulWidget {
  const PassengerMainScreen({super.key});

  @override
  State<PassengerMainScreen> createState() => _PassengerMainScreenState();
}

class _PassengerMainScreenState extends State<PassengerMainScreen> {
  int selectedIndex = 0;

  final List<Widget> screens = [
    const PassengerHomeScreen(),
    const PassengerSearchScreen(),
    const PassengerHistoryScreen(),
    const PassengerProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FE),
      body: screens[selectedIndex],
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: GNav(
            selectedIndex: selectedIndex,
            onTabChange: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            activeColor: const Color(0xFF0D32B3),
            tabBackgroundColor: const Color(0xFFEBF1FF),
            color: Colors.grey.shade500,
            gap: 8,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            tabs: const [
              GButton(icon: Icons.directions_car, text: 'HOME'),
              GButton(icon: Icons.search, text: 'SEARCH'),
              GButton(icon: Icons.receipt_long, text: 'MY TRIPS'),
              GButton(icon: Icons.person, text: 'PROFILE'),
            ],
          ),
        ),
      ),
    );
  }
}
