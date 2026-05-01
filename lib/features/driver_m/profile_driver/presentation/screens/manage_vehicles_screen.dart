import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voya/core/shared/custom_header.dart';
import 'package:voya/features/driver_m/profile_driver/data/models/driver_profile_model.dart';
import 'package:voya/features/driver_m/profile_driver/logic/cubit/driver_profile_cubit.dart';
import 'package:voya/features/driver_m/profile_driver/logic/cubit/driver_profile_state.dart';
import 'package:voya/features/driver_m/profile_driver/presentation/widgets/vehicle_form_dialog.dart';

class ManageVehiclesScreen extends StatelessWidget {
  final DriverProfileCubit cubit;

  const ManageVehiclesScreen({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: Scaffold(
        backgroundColor: const Color(0xFFF9FAFF),
        body: SafeArea(
          child: Column(
            children: [
              const CustomHeader(title: 'Manage Vehicles'),
              Expanded(
                child: BlocConsumer<DriverProfileCubit, DriverProfileState>(
                  listener: (context, state) {
                    if (state is DriverVehicleActionSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message), backgroundColor: Colors.green),
                      );
                    } else if (state is DriverVehicleActionFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.errorMessage), backgroundColor: Colors.red),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is DriverProfileLoading || state is DriverVehicleActionLoading) {
                      return const Center(child: CircularProgressIndicator(color: Color(0xFF0D32B3)));
                    }

                    if (state is DriverProfileSuccess) {
                      final vehicles = state.profile.vehicles;
                      if (vehicles.isEmpty) {
                        return const Center(
                          child: Text(
                            'No vehicles found.',
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                        );
                      }

                      return ListView.separated(
                        padding: const EdgeInsets.all(20),
                        itemCount: vehicles.length,
                        separatorBuilder: (context, index) => const SizedBox(height: 16),
                        itemBuilder: (context, index) {
                          final vehicle = vehicles[index];
                          return _buildManageVehicleCard(context, vehicle, cubit);
                        },
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0D32B3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => VehicleFormDialog(cubit: cubit),
                      );
                    },
                    child: const Text(
                      'Add New Vehicle',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildManageVehicleCard(BuildContext context, VehicleModel vehicle, DriverProfileCubit cubit) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
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
              Expanded(
                child: Text(
                  vehicle.model,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => VehicleFormDialog(vehicle: vehicle, cubit: cubit),
                  );
                },
                icon: const Icon(Icons.edit, size: 20, color: Color(0xFF0D32B3)),
                constraints: const BoxConstraints(),
                padding: EdgeInsets.zero,
              ),
              const SizedBox(width: 16),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Delete Vehicle'),
                      content: const Text('Are you sure you want to delete this vehicle?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
                        ),
                        TextButton(
                          onPressed: () {
                            cubit.deleteVehicle(vehicle.id);
                            Navigator.pop(context);
                          },
                          child: const Text('Delete', style: TextStyle(color: Colors.red)),
                        ),
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.delete, size: 20, color: Colors.red),
                constraints: const BoxConstraints(),
                padding: EdgeInsets.zero,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFEBF1FF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              vehicle.color,
              style: const TextStyle(color: Color(0xFF0D32B3), fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),
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
        ],
      ),
    );
  }
}
