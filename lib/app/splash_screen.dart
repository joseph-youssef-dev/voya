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
//////////////////////////////////
// import 'package:flutter/material.dart';

// class SplashScreen extends StatefulWidget {
//   final VoidCallback onFinish;

//   const SplashScreen({super.key, required this.onFinish});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with TickerProviderStateMixin {
//   late AnimationController _controller;

//   late Animation<double> fadeAnimation;
//   late Animation<double> scaleAnimation;
//   late Animation<Offset> slideAnimation;

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2),
//     );

//     fadeAnimation = Tween<double>(
//       begin: 0,
//       end: 1,
//     ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

//     scaleAnimation = Tween<double>(
//       begin: 0.7,
//       end: 1,
//     ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

//     slideAnimation = Tween<Offset>(
//       begin: const Offset(0, 0.5),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

//     _controller.forward();

//     Future.delayed(const Duration(seconds: 3), () {
//       widget.onFinish();
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xFF010A43), Color(0xFF0066FF)],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Center(
//           child: FadeTransition(
//             opacity: fadeAnimation,
//             child: ScaleTransition(
//               scale: scaleAnimation,
//               child: SlideTransition(
//                 position: slideAnimation,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text(
//                       "Voya",
//                       style: TextStyle(
//                         fontSize: 80,
//                         color: Colors.white,
//                         fontFamily: 'Schyler',
//                         fontWeight: FontWeight.bold,
//                         letterSpacing: -2,
//                       ),
//                     ),
//                     const SizedBox(width: 15),

//                     // الباص مع Animation بسيطة
//                     TweenAnimationBuilder<double>(
//                       tween: Tween(begin: 0.8, end: 1),
//                       duration: const Duration(seconds: 2),
//                       curve: Curves.easeOutBack,
//                       builder: (context, value, child) {
//                         return Transform.scale(scale: value, child: child);
//                       },
//                       child: Container(
//                         width: 110,
//                         height: 110,
//                         decoration: BoxDecoration(
//                           color: Colors.black,
//                           borderRadius: BorderRadius.circular(25),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.3),
//                               blurRadius: 20,
//                               offset: const Offset(0, 10),
//                             ),
//                           ],
//                         ),
//                         padding: const EdgeInsets.all(10),
//                         child: Image.asset(
//                           'assets/images/bus.png',
//                           fit: BoxFit.contain,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

//////////////////////////////////

// import 'package:flutter/material.dart';

// class SplashScreen extends StatefulWidget {
//   final VoidCallback onFinish;

//   const SplashScreen({super.key, required this.onFinish});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with TickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<Offset> textSlide;
//   late Animation<double> textFade;

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2),
//     );

//     textSlide = Tween<Offset>(
//       begin: const Offset(-2.5, 0), // 👈 يبدأ بعيد ورا الباص
//       end: const Offset(0.8, 0), // 👈 يطلع كامل لبرا
//     ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

//     textFade = Tween<double>(
//       begin: 0,
//       end: 1,
//     ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

//     _controller.forward();

//     Future.delayed(const Duration(seconds: 3), () {
//       widget.onFinish();
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xFF010A43), Color(0xFF0066FF)],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Center(
//           child: Stack(
//             clipBehavior: Clip.none, // 👈 مهم جدا علشان الكلمة تطلع بره
//             alignment: Alignment.center,
//             children: [
//               /// 🚌 الصورة (فوق)
//               Container(
//                 width: 120,
//                 height: 120,
//                 decoration: BoxDecoration(
//                   color: Colors.black,
//                   borderRadius: BorderRadius.circular(25),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.3),
//                       blurRadius: 20,
//                       offset: const Offset(0, 10),
//                     ),
//                   ],
//                 ),
//                 padding: const EdgeInsets.all(10),
//                 child: Image.asset(
//                   'assets/images/bus.png',
//                   fit: BoxFit.contain,
//                 ),
//               ),

//               /// ✨ الكلمة (تطلع من ورا)
//               FadeTransition(
//                 opacity: textFade,
//                 child: SlideTransition(
//                   position: textSlide,
//                   child: const Text(
//                     "Voya",
//                     style: TextStyle(
//                       fontSize: 90,
//                       color: Colors.white,
//                       fontFamily: 'Schyler',
//                       fontWeight: FontWeight.bold,
//                       letterSpacing: -2,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

/////////////////////////////////////////////
// import 'package:flutter/material.dart';

// class SplashScreen extends StatefulWidget {
//   final VoidCallback onFinish;

//   const SplashScreen({super.key, required this.onFinish});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with TickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<Offset> textSlide;
//   late Animation<double> textFade;

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 3),
//     );

//     /// ✨ حركة الكلمة (3 مراحل)
//     textSlide = TweenSequence<Offset>([
//       /// 1️⃣ تطلع من ورا الباص
//       TweenSequenceItem(
//         tween: Tween(
//           begin: const Offset(-2.5, 0),
//           end: const Offset(0.5, 0),
//         ).chain(CurveTween(curve: Curves.easeOut)),
//         weight: 40,
//       ),

//       /// 2️⃣ تكمل لليمين
//       TweenSequenceItem(
//         tween: Tween(
//           begin: const Offset(0.5, 0),
//           end: const Offset(1.5, 0),
//         ).chain(CurveTween(curve: Curves.easeOut)),
//         weight: 20,
//       ),

//       /// 3️⃣ ترجع للشمال النهائي
//       TweenSequenceItem(
//         tween: Tween(
//           begin: const Offset(1.5, 0),
//           end: const Offset(-1.2, 0),
//         ).chain(CurveTween(curve: Curves.easeInOut)),
//         weight: 40,
//       ),
//     ]).animate(_controller);

//     textFade = Tween<double>(begin: 0, end: 1).animate(
//       CurvedAnimation(parent: _controller, curve: const Interval(0, 0.3)),
//     );

//     _controller.forward();

//     Future.delayed(const Duration(seconds: 4), () {
//       widget.onFinish();
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xFF010A43), Color(0xFF0066FF)],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Center(
//           child: Stack(
//             clipBehavior: Clip.none,
//             alignment: Alignment.center,
//             children: [
//               /// ✨ الكلمة
//               FadeTransition(
//                 opacity: textFade,
//                 child: SlideTransition(
//                   position: textSlide,
//                   child: const Text(
//                     "Voya",
//                     style: TextStyle(
//                       fontSize: 90,
//                       color: Colors.white,
//                       fontFamily: 'Schyler',
//                       fontWeight: FontWeight.bold,
//                       letterSpacing: -2,
//                     ),
//                   ),
//                 ),
//               ),

//               /// 🚌 الباص (يتحرك في الآخر لليمين)
//               AnimatedBuilder(
//                 animation: _controller,
//                 builder: (context, child) {
//                   double moveRight = 0;

//                   if (_controller.value > 0.6) {
//                     moveRight = (_controller.value - 0.6) * 200;
//                   }

//                   return Transform.translate(
//                     offset: Offset(moveRight, 0),
//                     child: child,
//                   );
//                 },
//                 child: Container(
//                   width: 120,
//                   height: 120,
//                   decoration: BoxDecoration(
//                     color: Colors.black,
//                     borderRadius: BorderRadius.circular(25),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.3),
//                         blurRadius: 20,
//                         offset: const Offset(0, 10),
//                       ),
//                     ],
//                   ),
//                   padding: const EdgeInsets.all(10),
//                   child: Image.asset(
//                     'assets/images/bus.png',
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
/////////////////////////////////////////
// import 'package:flutter/material.dart';

// class SplashScreen extends StatefulWidget {
//   final VoidCallback onFinish;

//   const SplashScreen({super.key, required this.onFinish});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with TickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<Offset> textSlide;
//   late Animation<double> textFade;

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 3),
//     );

//     /// ✨ حركة الكلمة (3 مراحل)
//     textSlide = TweenSequence<Offset>([
//       /// 1️⃣ تطلع من ورا الباص
//       TweenSequenceItem(
//         tween: Tween(
//           begin: const Offset(-2.5, 0),
//           end: const Offset(0.5, 0),
//         ).chain(CurveTween(curve: Curves.easeOut)),
//         weight: 40,
//       ),

//       /// 2️⃣ تكمل لليمين
//       TweenSequenceItem(
//         tween: Tween(
//           begin: const Offset(0.5, 0),
//           end: const Offset(1.5, 0),
//         ).chain(CurveTween(curve: Curves.easeOut)),
//         weight: 20,
//       ),

//       /// 3️⃣ ترجع للشمال النهائي (تم التعديل هنا)
//       TweenSequenceItem(
//         tween: Tween(
//           begin: const Offset(1.5, 0),
//           end: const Offset(-0.9, 0), // 👈 هنا الحل
//         ).chain(CurveTween(curve: Curves.easeInOut)),
//         weight: 40,
//       ),
//     ]).animate(_controller);

//     textFade = Tween<double>(begin: 0, end: 1).animate(
//       CurvedAnimation(parent: _controller, curve: const Interval(0, 0.3)),
//     );

//     _controller.forward();

//     Future.delayed(const Duration(seconds: 4), () {
//       widget.onFinish();
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xFF010A43), Color(0xFF0066FF)],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Center(
//           child: Stack(
//             clipBehavior: Clip.none,
//             alignment: Alignment.center,
//             children: [
//               /// ✨ الكلمة
//               FadeTransition(
//                 opacity: textFade,
//                 child: SlideTransition(
//                   position: textSlide,
//                   child: const Text(
//                     "Voya",
//                     style: TextStyle(
//                       fontSize: 90,
//                       color: Colors.white,
//                       fontFamily: 'Schyler',
//                       fontWeight: FontWeight.bold,
//                       letterSpacing: -2,
//                     ),
//                   ),
//                 ),
//               ),

//               /// 🚌 الباص
//               AnimatedBuilder(
//                 animation: _controller,
//                 builder: (context, child) {
//                   double moveRight = 0;

//                   if (_controller.value > 0.6) {
//                     moveRight = (_controller.value - 0.6) * 200;
//                   }

//                   return Transform.translate(
//                     offset: Offset(moveRight, 0),
//                     child: child,
//                   );
//                 },
//                 child: Container(
//                   width: 120,
//                   height: 120,
//                   decoration: BoxDecoration(
//                     color: Colors.black,
//                     borderRadius: BorderRadius.circular(25),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.3),
//                         blurRadius: 20,
//                         offset: const Offset(0, 10),
//                       ),
//                     ],
//                   ),
//                   padding: const EdgeInsets.all(10),
//                   child: Image.asset(
//                     'assets/images/bus.png',
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
/////////////////////////////////////////////////

// import 'package:flutter/material.dart';

// class SplashScreen extends StatefulWidget {
//   final VoidCallback onFinish;

//   const SplashScreen({super.key, required this.onFinish});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> textX;
//   late Animation<double> textFade;

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 3),
//     );

//     final curved = CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeInOut,
//     );

//     /// ✨ الحركة
//     textX = TweenSequence<double>([
//       TweenSequenceItem(tween: Tween(begin: -250.0, end: 40.0), weight: 40),
//       TweenSequenceItem(tween: Tween(begin: 40.0, end: 150.0), weight: 20),
//       TweenSequenceItem(
//         tween: Tween(begin: 150.0, end: -100.0), // 👈 مظبوطة ومش بتقص
//         weight: 40,
//       ),
//     ]).animate(curved);

//     textFade = Tween<double>(begin: 0, end: 1).animate(
//       CurvedAnimation(parent: _controller, curve: const Interval(0, 0.3)),
//     );

//     _controller.forward();

//     Future.delayed(const Duration(seconds: 4), () {
//       widget.onFinish();
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xFF010A43), Color(0xFF0066FF)],
//           ),
//         ),
//         child: Center(
//           child: AnimatedBuilder(
//             animation: _controller,
//             builder: (context, _) {
//               double moveRight = 0;

//               if (_controller.value > 0.6) {
//                 moveRight = (_controller.value - 0.6) * 200;
//               }

//               return Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   /// ✨ الكلمة
//                   Transform.translate(
//                     offset: Offset(textX.value, 0),
//                     child: Opacity(
//                       opacity: textFade.value,
//                       child: const Text(
//                         "Voya",
//                         style: TextStyle(
//                           fontSize: 90,
//                           color: Colors.white,
//                           fontFamily: 'Schyler',
//                           fontWeight: FontWeight.bold,
//                           letterSpacing: -2,
//                         ),
//                       ),
//                     ),
//                   ),

//                   /// 🚌 الباص
//                   Transform.translate(
//                     offset: Offset(moveRight, 0),
//                     child: Container(
//                       width: 120,
//                       height: 120,
//                       decoration: BoxDecoration(
//                         color: Colors.black,
//                         borderRadius: BorderRadius.circular(25),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.3),
//                             blurRadius: 20,
//                             offset: const Offset(0, 10),
//                           ),
//                         ],
//                       ),
//                       padding: const EdgeInsets.all(10),
//                       child: Image.asset(
//                         'assets/images/bus.png',
//                         fit: BoxFit.contain,
//                       ),
//                     ),
//                   ),
//                 ],
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
//////////////////////////////////////////
// import 'package:flutter/material.dart';

// class SplashScreen extends StatefulWidget {
//   final VoidCallback onFinish;

//   const SplashScreen({super.key, required this.onFinish});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> textFade;

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 3),
//     );

//     textFade = Tween<double>(begin: 0, end: 1).animate(
//       CurvedAnimation(parent: _controller, curve: const Interval(0, 0.3)),
//     );

//     _controller.forward();

//     Future.delayed(const Duration(seconds: 4), () {
//       widget.onFinish();
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;

//     /// ✨ animation ديناميك (يمنع تقطيع الكلمة)
//     final textX = TweenSequence<double>([
//       /// من بره الشاشة
//       TweenSequenceItem(
//         tween: Tween(begin: -screenWidth, end: 40.0),
//         weight: 40,
//       ),

//       /// لليمين
//       TweenSequenceItem(tween: Tween(begin: 40.0, end: 150.0), weight: 20),

//       /// رجوع للشمال (مظبوط)
//       TweenSequenceItem(
//         tween: Tween(
//           begin: 150.0,
//           end: -screenWidth * 0.22, // 👈 أهم تعديل
//         ),
//         weight: 40,
//       ),
//     ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xFF010A43), Color(0xFF0066FF)],
//           ),
//         ),
//         child: Center(
//           child: AnimatedBuilder(
//             animation: _controller,
//             builder: (context, _) {
//               double moveRight = 0;

//               if (_controller.value > 0.6) {
//                 moveRight = (_controller.value - 0.6) * 200;
//               }

//               return Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   /// ✨ الكلمة
//                   Transform.translate(
//                     offset: Offset(textX.value, 0),
//                     child: Opacity(
//                       opacity: textFade.value,
//                       child: const Text(
//                         "Voya",
//                         style: TextStyle(
//                           fontSize: 90,
//                           color: Colors.white,
//                           fontFamily: 'Schyler',
//                           fontWeight: FontWeight.bold,
//                           letterSpacing: -2,
//                         ),
//                       ),
//                     ),
//                   ),

//                   /// 🚌 الباص
//                   Transform.translate(
//                     offset: Offset(moveRight, 0),
//                     child: Container(
//                       width: 120,
//                       height: 120,
//                       decoration: BoxDecoration(
//                         color: Colors.black,
//                         borderRadius: BorderRadius.circular(25),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.3),
//                             blurRadius: 20,
//                             offset: const Offset(0, 10),
//                           ),
//                         ],
//                       ),
//                       padding: const EdgeInsets.all(10),
//                       child: Image.asset(
//                         'assets/images/bus.png',
//                         fit: BoxFit.contain,
//                       ),
//                     ),
//                   ),
//                 ],
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
