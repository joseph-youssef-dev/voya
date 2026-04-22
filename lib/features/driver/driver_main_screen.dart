import 'package:flutter/material.dart';
import 'package:voya/features/driver_m/register/register_driver.dart';

class DriverMainScreen extends StatelessWidget {
  const DriverMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // return Scaffold(body: Center(child: Text("Driver App")));
    return Scaffold(body: RegisterDriver());
  }
}
