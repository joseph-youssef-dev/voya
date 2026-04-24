import 'package:flutter/material.dart';
import 'package:voya/features/driver_m/Theme/colors/app_colors.dart';

// الهيدر اللي بيظهر في كل الصفحات
class AppBarScreen extends StatelessWidget {
  final String text1;
  final String text2;

  const AppBarScreen({super.key, required this.text1, required this.text2});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 250,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primary, AppColors.primaryLight],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Stack(
            children: [
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.white.withValues(alpha: 0.3),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                right: 70,
                top: 10,
                child: GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.3),
                            blurRadius: 15,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: AppColors.black,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Image.asset("assets/images/bus.png"),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),
                    const Text(
                      'VOYA',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      text1,
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      text2,
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
