import 'package:flutter/material.dart';
import 'package:voya/features/driver_m/Theme/colors/app_colors.dart';

class RegisterHeader extends StatelessWidget {
  const RegisterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.3),
                blurRadius: 15,
                spreadRadius: 2,
              ),
            ],
          ),
          child: CircleAvatar(
            radius: 30,
            backgroundColor: AppColors.primary,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Image.asset("assets/images/bus.png"),
            ),
          ),
        ),

        const SizedBox(height: 20),

        const Text(
          "Welcome Back",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),

        const SizedBox(height: 8),

        const Text(
          "Sign in to continue",
          style: TextStyle(color: AppColors.textSecondary),
        ),
      ],
    );
  }
}
