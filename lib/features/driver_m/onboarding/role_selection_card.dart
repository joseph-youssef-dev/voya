// import 'package:flutter/material.dart';

// class RoleSelectionCard extends StatelessWidget {
//   final IconData icon;
//   final Color color_backgroun_icon;
//   final String text1;
//   final String text2;
//   final VoidCallback onTap;
//   const RoleSelectionCard({
//     super.key,
//     required this.icon,
//     required this.color_backgroun_icon,
//     required this.text1,
//     required this.text2,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 30),
//       child: Container(
//         padding: EdgeInsets.all(10),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(20),
//           border: Border.all(color: Colors.white),
//         ),
//         child: InkWell(
//           onTap: onTap,
//           borderRadius: BorderRadius.circular(20),
//           child: Center(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   padding: EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     color: color_backgroun_icon,
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Icon(icon, color: Colors.white),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(20),
//                   child: Column(
//                     children: [
//                       Text(text1, style: TextStyle(fontSize: 22)),
//                       Text(text2, style: TextStyle(fontSize: 15)),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
