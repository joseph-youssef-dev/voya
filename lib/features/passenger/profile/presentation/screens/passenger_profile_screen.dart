import 'package:flutter/material.dart';

import 'package:voya/features/passenger/home/presentation/widgets/header_widget.dart';
import 'package:voya/features/passenger/profile/presentation/widgets/profile_header_card.dart';
import 'package:voya/features/passenger/profile/presentation/widgets/personal_details_section.dart';
import 'package:voya/features/passenger/profile/presentation/widgets/logout_button.dart';

class PassengerProfileScreen extends StatelessWidget {
  const PassengerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 16),
            HeaderWidget(),
            SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  ProfileHeaderCard(),
                  SizedBox(height: 20),
                  PersonalDetailsSection(),
                  SizedBox(height: 20),
                  LogoutButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
