import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/driver_profile_model.dart';
import '../../logic/cubit/driver_profile_cubit.dart';
import '../screens/manage_vehicles_screen.dart';

class DriverVehiclesSection extends StatelessWidget {
  final DriverProfileModel profile;

  const DriverVehiclesSection({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DriverProfileCubit>();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 20,
            offset: const Offset(0, 10),
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
                'VEHICLES',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1E2432),
                  letterSpacing: 1.2,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ManageVehiclesScreen(cubit: cubit),
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
          const SizedBox(height: 10),
          if (profile.vehicles.isEmpty)
            const Text('No vehicles found.', style: TextStyle(color: Colors.grey))
          else
            ...profile.vehicles.map((v) => _buildPreviewVehicleCard(v)),
        ],
      ),
    );
  }

  Widget _buildPreviewVehicleCard(VehicleModel vehicle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEBF1FF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.directions_car, color: Color(0xFF0D32B3)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '${vehicle.model} (${vehicle.color})',
                  style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'License: ${vehicle.vehicleLicense} • Seats: ${vehicle.numberOfPassengers}',
            style: const TextStyle(color: Color(0xFF5A6B87), fontSize: 13, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
