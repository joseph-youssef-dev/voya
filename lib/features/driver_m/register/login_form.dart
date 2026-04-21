import 'package:flutter/material.dart';
import 'package:voya/features/driver_m/login/container_design_login.dart';
import 'package:voya/features/driver_m/login/password.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        AppTextField(
          icon: Icons.email_outlined,
          hintText: 'Enter your email',
          text: '',
        ),
        SizedBox(height: 15),
        Password(
          icon: Icons.lock_outline,
          hintText: "Password",
          isPassword: true,
        ),
      ],
    );
  }
}
