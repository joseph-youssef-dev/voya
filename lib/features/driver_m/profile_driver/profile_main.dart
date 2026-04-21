import 'package:flutter/material.dart';
import 'package:voya/features/driver_m/home/app_bar_screen.dart';
import 'package:voya/features/driver_m/profile_driver/profile.dart';

class DriverProfileScreen extends StatelessWidget {
  const DriverProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppBarScreen(text1: 'My Profile', text2: ''),
            const SizedBox(height: 20),
            const ProfileScreenUI(),
          ],
        ),
      ),
    );
  }
}
