import 'package:flutter/material.dart';
import 'package:voya/features/driver_m/Theme/colors/app_colors.dart';
import 'package:voya/features/driver_m/register/login_button.dart';
import 'package:voya/features/driver_m/register/login_form.dart';
import 'package:voya/features/driver_m/register/register_header.dart';
import 'package:voya/features/driver_m/register/signup_row.dart';

class RegisterDriver extends StatelessWidget {
  const RegisterDriver({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundSoft,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 25,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RegisterHeader(),
                SizedBox(height: 30),
                LoginForm(),
                SizedBox(height: 30),
                LoginButton(),
                SizedBox(height: 20),
                SignupRow(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
