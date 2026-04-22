// import 'package:flutter/material.dart';
// import 'package:voya/features/driver_m/Theme/colors/app_colors.dart';
// import 'package:voya/features/driver_m/onboarding/color_gradient.dart';
// import 'package:voya/features/driver_m/onboarding/image_bus.dart';
// import 'package:voya/features/driver_m/onboarding/role_selection_card.dart';
// import 'package:voya/features/driver_m/register/register_driver.dart';
// import 'package:voya/features/passenger/home/presentation/screens/passenger_home_screen.dart';

// class RoleSelectionPage extends StatelessWidget {
//   const RoleSelectionPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ColorGradient(
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const ImageBus(),

//               const SizedBox(height: 20),

//               const Text(
//                 "Welcome to Voya",
//                 style: TextStyle(
//                   fontSize: 40,
//                   fontFamily: 'Lobster',
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.white,
//                 ),
//               ),

//               const SizedBox(height: 10),

//               const Text(
//                 "Choose your role to continue",
//                 style: TextStyle(color: AppColors.white),
//               ),

//               const SizedBox(height: 30),

//               RoleSelectionCard(
//                 color_backgroun_icon: AppColors.iconBackground,
//                 icon: Icons.people,
//                 text1: "I’m a Passenger",
//                 text2: "Find and book rides",
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const PassengerHomeScreen(),
//                     ),
//                   );
//                 },
//               ),

//               const SizedBox(height: 35),

//               RoleSelectionCard(
//                 icon: Icons.local_taxi,
//                 color_backgroun_icon: AppColors.primary,
//                 text1: "I’m a Driver",
//                 text2: "Offer rides and earn",
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const RegisterDriver(),
//                     ),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
