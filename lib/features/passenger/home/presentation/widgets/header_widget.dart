import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.shade200,
            ),
          ),
          const SizedBox(width: 12),
          const Text(
            "voya",
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 26,
              color: Color(0xFF0D32B3),
              letterSpacing: 1.0,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
