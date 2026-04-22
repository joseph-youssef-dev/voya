import 'package:flutter/material.dart';

class SignInUp extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const SignInUp({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 50,
          width: 150,
          decoration: BoxDecoration(
            color: Color(0xFF002D6E),
            border: Border.all(color: Color(0xFF002D6E), width: 1.5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              // "Sign Up",
              text,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      //),
    );
  }
}
