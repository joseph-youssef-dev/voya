// import 'package:flutter/material.dart';

// class WaveWidget extends StatelessWidget {
//   final bool isBottom;
//   final double height;

//   const WaveWidget({super.key, this.isBottom = false, this.height = 150});

//   @override
//   Widget build(BuildContext context) {
//     return CustomPaint(
//       size: Size(double.infinity, height),
//       painter: WavePainter(isBottom: isBottom),
//     );
//   }
// }

// class WavePainter extends CustomPainter {
//   final bool isBottom;
//   WavePainter({required this.isBottom});

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = const Color(0xFF01002B)
//       ..style = PaintingStyle.fill;

//     final path = Path();

//     if (isBottom) {
//       path.moveTo(0, size.height);
//       path.lineTo(0, size.height * 0.3);
//       path.quadraticBezierTo(
//         size.width * 0.25,
//         0,
//         size.width * 0.5,
//         size.height * 0.3,
//       );
//       path.quadraticBezierTo(
//         size.width * 0.75,
//         size.height * 0.6,
//         size.width,
//         size.height * 0.3,
//       );
//       path.lineTo(size.width, size.height);
//     } else {
//       path.lineTo(0, size.height * 0.7);
//       path.quadraticBezierTo(
//         size.width * 0.25,
//         size.height,
//         size.width * 0.5,
//         size.height * 0.7,
//       );
//       path.quadraticBezierTo(
//         size.width * 0.75,
//         size.height * 0.4,
//         size.width,
//         size.height * 0.7,
//       );
//       path.lineTo(size.width, 0);
//     }

//     path.close();
//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }
