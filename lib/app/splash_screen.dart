import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
  final VoidCallback onFinish;

  const SplashScreen({super.key, required this.onFinish});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      widget.onFinish();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF010A43), Color(0xFF0066FF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Voya",
                style: TextStyle(
                  fontSize: 85,
                  color: Colors.white,
                  fontFamily: 'Schyler', // Using the font defined in pubspec
                  fontWeight: FontWeight.bold,
                  letterSpacing: -2,
                ),
              ),
              const SizedBox(width: 15),
              Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(8),
                child: Image.asset(
                  'assets/images/bus.png',
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
