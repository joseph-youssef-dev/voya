import 'package:flutter/material.dart';
import 'package:voya/features/driver_m/Theme/colors/app_colors.dart';

class AuthBackground extends StatelessWidget {
  final Widget child;

  const AuthBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(height: 120, color: AppColors.primary),

        Transform.translate(
          offset: const Offset(0, 60),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: AppColors.backgroundSoft,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: child,
          ),
        ),
      ],
    );
  }
}
