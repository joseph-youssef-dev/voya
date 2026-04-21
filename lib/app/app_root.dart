import 'package:flutter/material.dart';
import 'package:voya/app/role_decision.dart';
import 'package:voya/app/splash_screen.dart';
import 'package:voya/core/constants/app_strings.dart';
import 'package:voya/core/databases/cache/cache_helper.dart';
import 'package:voya/core/enums/role_enum.dart';
import 'package:voya/features/driver/driver_main_screen.dart';
import 'package:voya/features/driver_m/register/register_driver.dart';
import 'package:voya/features/passenger/passenger_main_screen.dart';
import 'package:voya/features/passenger/auth/presentation/screens/passenger_register_screen.dart';

class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  bool isSplashFinished = false;
  UserRole? role;

  @override
  void initState() {
    super.initState();
    loadRole();
  }

  void loadRole() {
    bool isLoggedIn = CacheHelper().getData(key: "isLoggedIn") ?? false;

    if (!isLoggedIn) return;

    String? roleString = CacheHelper().getDataString(key: kUserRole);

    if (roleString == 'passenger') {
      role = UserRole.passenger;
    } else if (roleString == 'driver') {
      role = UserRole.driver;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (!isSplashFinished) {
      return SplashScreen(
        onFinish: () {
          setState(() {
            isSplashFinished = true;
          });
        },
      );
    }

    bool isLoggedIn = CacheHelper().getData(key: "isLoggedIn") ?? false;

    /// 🔹 لو مش عامل login → اختار role
    if (!isLoggedIn) {
      return RoleSelectionScreen(
        onSelect: (selectedRole) {
          setState(() {
            role = selectedRole;
          });

          if (selectedRole == UserRole.passenger) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PassengerRegisterScreen(),
              ),
            );
          }
        },
      );
    }

    /// 🔹 لو عامل login → يفتح مباشرة
    if (role == UserRole.passenger) {
      return PassengerMainScreen();
    }

    return RegisterDriver();
  }
}
