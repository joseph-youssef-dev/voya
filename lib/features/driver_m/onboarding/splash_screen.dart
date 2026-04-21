// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:voya/features/driver_m/Theme/fonts/app_text_styles.dart';
// import 'package:voya/features/driver_m/onboarding/color_gradient.dart';
// import 'package:voya/features/driver_m/onboarding/image_bus.dart';
// import 'package:voya/features/driver_m/onboarding/onboarding_page.dart';
// import 'package:voya/features/driver_m/onboarding/roles_selection_page.dart';
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();

//     Timer(const Duration(seconds: 3), () async {
//       final prefs = await SharedPreferences.getInstance();
//       final hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;

//       if (!mounted) return;

//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => hasSeenOnboarding
//               ? const RoleSelectionPage()
//               : const OnboardingPage(),
//         ),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ColorGradient(
//         child: Center(
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: const [
//               Text("Voya ", style: AppTextStyles.logo),
//               SizedBox(width: 20),
//               ImageBus(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
