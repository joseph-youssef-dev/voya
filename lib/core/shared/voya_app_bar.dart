import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VoyaAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isHome;
  final String? title;

  const VoyaAppBar({super.key, this.isHome = false, this.title});

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF0D32B3),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(24),
            bottomRight: Radius.circular(24),
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: SizedBox(
            height: 80,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: isHome ? _HomeContent() : _PageContent(title: title ?? ''),
            ),
          ),
        ),
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            // child: Text(
            //   "V",
            //   style: TextStyle(
            //     color: Colors.white,
            //     fontWeight: FontWeight.w900,
            //     fontSize: 20,
            //   ),
            // ),
          ),
        ),
        const SizedBox(width: 10),
        const Text(
          "voya",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 30,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}

class _PageContent extends StatelessWidget {
  final String title;
  const _PageContent({required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w900,
          fontSize: 22,
        ),
      ),
    );
  }
}
