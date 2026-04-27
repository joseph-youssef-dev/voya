import 'package:flutter/material.dart';
import '../../data/models/driver_profile_model.dart';

class DriverPersonalDetailsSection extends StatelessWidget {
  final DriverProfileModel profile;

  const DriverPersonalDetailsSection({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 4, bottom: 16),
          child: Text(
            "PERSONAL INFORMATION",
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w900,
              color: Color(0xFF5A6B87),
              letterSpacing: 1.2,
            ),
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
              _buildDetailRow(Icons.location_city_outlined, "Town", profile.town),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Divider(color: Color(0xFFF1F4F9), thickness: 1.5),
              ),
              _buildDetailRow(Icons.cake_outlined, "Birth Date", profile.birthDate),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Divider(color: Color(0xFFF1F4F9), thickness: 1.5),
              ),
              _buildDetailRow(Icons.badge_outlined, "SSN", profile.ssn),
            ],
          ),
        ),
        if (profile.vehicles.isNotEmpty) ...[
          const SizedBox(height: 30),
          const Padding(
            padding: EdgeInsets.only(left: 4, bottom: 16),
            child: Text(
              "VEHICLES",
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w900,
                color: Color(0xFF5A6B87),
                letterSpacing: 1.2,
              ),
            ),
          ),
          ...profile.vehicles.map((vehicle) => Container(
                margin: const EdgeInsets.only(bottom: 16),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.directions_bus, color: Color(0xFF0D32B3)),
                        const SizedBox(width: 12),
                        Text(
                          vehicle.model,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEBF1FF),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            vehicle.color,
                            style: const TextStyle(
                                color: Color(0xFF0D32B3),
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "License: ${vehicle.vehicleLicense}",
                      style: const TextStyle(
                        color: Color(0xFF0D32B3),
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Capacity: ${vehicle.numberOfPassengers} Passengers",
                      style: const TextStyle(color: Color(0xFF5A6B87), fontSize: 13),
                    ),
                    if (vehicle.features != null && vehicle.features != "None") ...[
                      const SizedBox(height: 8),
                      Text(
                        "Features: ${vehicle.features}",
                        style: const TextStyle(color: Color(0xFF5A6B87), fontSize: 13),
                      ),
                    ],
                  ],
                ),
              )),
        ],
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
