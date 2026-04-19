import 'package:flutter/material.dart';
import 'package:voya/features/passenger/profile/data/models/passenger_profile_model.dart';

class ProfileHeaderCard extends StatelessWidget {
  final PassengerProfileModel profile;

  const ProfileHeaderCard({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF0D32B3),
            Color(0xFF0A2B99),
          ],
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0D32B3).withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: const Color(0xFF163ECA), width: 3),
              color: Colors.white24,
            ),
            child: profile.profileImage != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(22),
                    child: Image.network(profile.profileImage!, fit: BoxFit.cover),
                  )
                : const Icon(Icons.person, color: Colors.white, size: 44),
          ),
          const SizedBox(height: 16),
          Text(
            "${profile.firstName} ${profile.lastName}",
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 26,
              height: 1.1,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.phone_iphone, color: Colors.white, size: 14),
                const SizedBox(width: 8),
                Text(
                  profile.phone,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
