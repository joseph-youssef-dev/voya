import 'package:flutter/material.dart';
import 'package:voya/features/driver/Theme/colors/app_colors.dart';

class AppTextStyles {
  static const TextStyle logo = TextStyle(
    fontSize: 60,
    fontFamily: 'Lobster',
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  static const TextStyle title = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );

  static const TextStyle body = TextStyle(
    fontSize: 16,
    color: AppColors.textSecondary,
  );

  static const TextStyle small = TextStyle(
    fontSize: 14,
    color: AppColors.textSecondary,
  );
}
