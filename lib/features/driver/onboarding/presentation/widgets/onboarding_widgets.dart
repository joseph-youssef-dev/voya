// //--- from color_gradient.dart ---
import 'package:flutter/material.dart';
import 'package:voya/features/driver/Theme/colors/app_colors.dart';

class ColorGradient extends StatelessWidget {
  const ColorGradient({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.primary, AppColors.primaryLight],
        ),
      ),
      child: child,
    );
  }
}

// //--- from image_bus.dart ---
// // import 'package:flutter/material.dart';

class ImageBus extends StatelessWidget {
  const ImageBus({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Image.asset("assets/images/bus.png", width: 80),
    );
  }
}

// //--- from role_selection_card.dart ---
// // import 'package:flutter/material.dart';

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
