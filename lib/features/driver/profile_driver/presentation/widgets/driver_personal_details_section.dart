import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voya/features/driver/profile_driver/logic/cubit/driver_profile_cubit.dart';
import '../../data/models/driver_profile_model.dart';
import '../screens/edit_driver_profile_screen.dart';

class DriverPersonalDetailsSection extends StatelessWidget {
  final DriverProfileModel profile;

  const DriverPersonalDetailsSection({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 16, right: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "PERSONAL INFORMATION",
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF5A6B87),
                  letterSpacing: 1.2,
                ),
              ),
              InkWell(
                onTap: () {
                  final cubit = context.read<DriverProfileCubit>();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EditDriverProfileScreen(
                        profile: profile,
                        cubit: cubit,
                      ),
                    ),
                  );
                },
                child: const Row(
                  children: [
                    Text(
                      "Edit",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0D32B3),
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.edit, size: 14, color: Color(0xFF0D32B3)),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildDetailRow(
                Icons.location_city_outlined,
                "Town",
                profile.town,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Divider(color: Color(0xFFF1F4F9), thickness: 1.5),
              ),
              _buildDetailRow(
                Icons.cake_outlined,
                "Birth Date",
                profile.birthDate,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Divider(color: Color(0xFFF1F4F9), thickness: 1.5),
              ),
              _buildDetailRow(Icons.badge_outlined, "SSN", profile.ssn),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F4F9),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: const Color(0xFF0D32B3), size: 20),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF5A6B87),
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1E2432),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
