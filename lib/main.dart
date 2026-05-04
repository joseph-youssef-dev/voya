import 'package:flutter/material.dart';
import 'package:voya/app/app_root.dart';
import 'package:voya/core/databases/cache/cache_helper.dart';
import 'package:voya/core/constants/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper().init();
  // Session persistence enabled



  runApp(const Voya());
}

class Voya extends StatelessWidget {
  const Voya({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: const ColorScheme.light(
          primary: AppColors.primaryColor,
          onPrimary: Colors.white,
          surface: Colors.white,
          onSurface: AppColors.textPrimaryColor,
        ),
        datePickerTheme: const DatePickerThemeData(
          backgroundColor: Colors.white,
          headerBackgroundColor: AppColors.primaryColor,
          headerForegroundColor: Colors.white,
        ),
        timePickerTheme: const TimePickerThemeData(
          backgroundColor: Colors.white,
          dialHandColor: AppColors.primaryColor,
          dialBackgroundColor: Color(0xFFEBF1FF),
          hourMinuteTextColor: AppColors.primaryColor,
          hourMinuteColor: Color(0xFFEBF1FF),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primaryColor,
          ),
        ),
      ),
      home: SafeArea(child: const AppRoot()),
    );
  }
}
