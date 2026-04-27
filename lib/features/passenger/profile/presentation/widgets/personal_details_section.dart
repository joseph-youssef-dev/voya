import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voya/features/passenger/profile/data/models/passenger_profile_model.dart';
import 'package:voya/features/passenger/profile/logic/cubit/profile_cubit.dart';
import 'package:voya/features/passenger/profile/presentation/screens/edit_passenger_profile_screen.dart';

class PersonalDetailsSection extends StatelessWidget {
  final PassengerProfileModel profile;

  const PersonalDetailsSection({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Personal Details",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1E1E1E),
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EditPassengerProfileScreen(
                        profile: profile,
                        cubit: context.read<ProfileCubit>(),
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.edit, size: 16, color: Color(0xFF0D32B3)),
                label: const Text(
                  "Edit",
                  style: TextStyle(
                    color: Color(0xFF0D32B3),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildDetailItem(
            icon: Icons.location_city,
            title: "TOWN",
            value: profile.town,
          ),
          const SizedBox(height: 20),
          _buildDetailItem(
            icon: Icons.cake,
            title: "BIRTH DATE",
            value: profile.birthDate,
          ),
          const SizedBox(height: 20),
          _buildDetailItem(
            icon: Icons.badge,
            title: "SSN",
            value: profile.ssn,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            color: Color(0xFFF3F6FF),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: const Color(0xFF0D32B3), size: 20),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.0,
                color: Color(0xFF8A8A8A),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1E1E1E),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
