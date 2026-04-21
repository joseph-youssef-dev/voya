// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:voya/features/driver_m/onboarding/roles_selection_page.dart';

// class OnboardingPage extends StatefulWidget {
//   const OnboardingPage({super.key});

//   @override
//   State<OnboardingPage> createState() => _OnboardingPageState();
// }

// class _OnboardingPageState extends State<OnboardingPage> {
//   final PageController _pageController = PageController();
//   int currentIndex = 0;

//   final List<Map<String, dynamic>> onboardingData = [
//     {
//       "title": "Welcome to Voya",
//       "description":
//           "The best platform to book rides and travel safely and comfortably.",
//       "image": "assets/images/bus_voya.jpeg",
//     },
//     {
//       "title": "Easy Booking",
//       "description":
//           "Choose your destination from hundreds of available trips every day.",
//       "image": "assets/images/screen2.jpeg",
//     },
//     {
//       "title": "Earn & Travel",
//       "description":
//           "Join as a driver to earn money or as a passenger to reach anywhere.",
//       "image": "assets/images/screen3.jpeg",
//     },
//   ];

//   /// حفظ إن المستخدم شاف الـ onboarding
//   Future<void> _finishOnboarding() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('onboarding_seen', true);

//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => const RoleSelectionPage()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,

//       /// APP BAR (Skip)
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         actions: [
//           if (currentIndex != onboardingData.length - 1)
//             TextButton(
//               onPressed: _finishOnboarding,
//               child: const Text(
//                 'Skip',
//                 style: TextStyle(color: Colors.grey, fontSize: 16),
//               ),
//             ),
//         ],
//       ),

//       body: Column(
//         children: [
//           /// PAGES
//           Expanded(
//             child: PageView.builder(
//               controller: _pageController,
//               itemCount: onboardingData.length,
//               onPageChanged: (index) {
//                 setState(() {
//                   currentIndex = index;
//                 });
//               },
//               itemBuilder: (context, index) {
//                 final data = onboardingData[index];

//                 return Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 30),
//                   child: SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         const SizedBox(height: 40),

//                         Image.asset(data['image'], height: 240),

//                         const SizedBox(height: 40),

//                         Text(
//                           data['title'],
//                           textAlign: TextAlign.center,
//                           style: const TextStyle(
//                             fontSize: 26,
//                             fontWeight: FontWeight.bold,
//                             color: Color(0xFF0D1B3E),
//                           ),
//                         ),

//                         const SizedBox(height: 20),

//                         Text(
//                           data['description'],
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             fontSize: 15,
//                             color: Colors.grey.shade600,
//                             height: 1.5,
//                           ),
//                         ),

//                         const SizedBox(height: 40),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),

//           /// BOTTOM
//           Padding(
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               children: [
//                 /// INDICATOR
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: List.generate(
//                     onboardingData.length,
//                     (index) => AnimatedContainer(
//                       duration: const Duration(milliseconds: 300),
//                       margin: const EdgeInsets.symmetric(horizontal: 4),
//                       height: 8,
//                       width: currentIndex == index ? 24 : 8,
//                       decoration: BoxDecoration(
//                         color: currentIndex == index
//                             ? const Color(0xFF0D1B3E)
//                             : Colors.grey.shade300,
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 20),

//                 /// SMALL BUTTON
//                 ElevatedButton(
//                   onPressed: () {
//                     if (currentIndex == onboardingData.length - 1) {
//                       _finishOnboarding();
//                     } else {
//                       _pageController.nextPage(
//                         duration: const Duration(milliseconds: 400),
//                         curve: Curves.easeInOut,
//                       );
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF0D1B3E),
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 24,
//                       vertical: 12,
//                     ),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                   ),
//                   child: Text(
//                     currentIndex == onboardingData.length - 1
//                         ? "Get Started"
//                         : "Next",
//                     style: const TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
