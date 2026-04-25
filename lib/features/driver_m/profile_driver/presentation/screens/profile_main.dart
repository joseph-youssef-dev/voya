import 'package:flutter/material.dart';
import 'package:voya/features/driver_m/home/presentation/screens/app_bar_screen.dart';
import 'package:voya/features/driver_m/profile_driver/presentation/screens/profile.dart';

class DriverProfileScreen extends StatelessWidget {
  const DriverProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBarScreen(text1: 'My Profile', text2: ''),
          Expanded(child: SingleChildScrollView(child: const ProfileScreen())),
        ],
      ),
    );
  }
}
