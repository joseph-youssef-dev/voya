import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voya/features/driver_m/home/logic/driver_home_cubit.dart';
import 'package:voya/features/driver_m/home/logic/navigation_cubit.dart';
import 'package:voya/core/shared/custom_header.dart';
import 'package:voya/features/driver_m/home/presentation/widgets/trip_widgets.dart';
import 'package:voya/features/driver_m/profile_driver/data/models/driver_profile_model.dart';
import '../../logic/add_trip_cubit.dart';
import '../../logic/add_trip_state.dart';

const List<String> egyptCities = [
  "Cairo",
  "Alexandria",
  "Giza",
  "Dakahlia",
  "Red Sea",
  "Beheira",
  "Fayoum",
  "Gharbia",
  "Ismailia",
  "Menofia",
  "Minya",
  "Qalyubia",
  "New Valley",
  "Sharqia",
  "Suez",
  "Aswan",
  "Assiut",
  "Beni Suef",
  "Port Said",
  "Damietta",
  "South Sinai",
  "Kafr ElSheikh",
  "Matrouh",
  "Luxor",
  "Qena",
  "North Sinai",
  "Sohag",
];

class TripForm extends StatelessWidget {
  const TripForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddTripCubit, AddTripState>(
      builder: (context, state) {
        if (state is! AddTripStateData) return const SizedBox();

        final cubit = context.read<AddTripCubit>();

        return Scaffold(
          backgroundColor: const Color(0xFFF6F8FE),
          body: BlocListener<AddTripCubit, AddTripState>(
            listener: (context, state) {
              if (state is AddTripStateData && state.errorMessage != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage!),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomHeader(title: state.tripId != null ? 'Edit Trip' : 'Post a Trip'),
                    const SizedBox(height: 30),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SectionTitle("TRIP TIMELINE"),
                            const SizedBox(height: 10),

                            _buildDropdown(
                              label: "Starting Point",
                              icon: Icons.my_location,
                              value: state.from,
                              onChanged: (val) => cubit.updateField(from: val),
                            ),

                            const SizedBox(height: 20),

                            _buildDropdown(
                              label: "Destination",
                              icon: Icons.location_on_outlined,
                              value: state.to,
                              onChanged: (val) => cubit.updateField(to: val),
                            ),

                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 24),
                              child: Divider(
                                color: Color(0xFFF1F4F9),
                                thickness: 1.5,
                              ),
                            ),

                            const SectionTitle("SCHEDULE & PRICING"),
                            const SizedBox(height: 10),

                            ScheduleRow(state: state),

                            const SizedBox(height: 20),

                            Row(
                              children: [
                                Expanded(
                                  child: _buildTextField(
                                    label: "Price (EGP)",
                                    icon: Icons.attach_money,
                                    initialValue: state.price,
                                    keyboardType: TextInputType.number,
                                    onChanged: (val) =>
                                        cubit.updateField(price: val),
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: _buildTextField(
                                    label: "Duration",
                                    icon: Icons.timer_outlined,
                                    initialValue: state.duration,
                                    hint: "e.g. 2h 30m",
                                    onChanged: (val) =>
                                        cubit.updateField(duration: val),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 20),

                            const SectionTitle("VEHICLE & DETAILS"),
                            const SizedBox(height: 10),

                            state.isLoadingVehicles
                                ? const Center(child: CircularProgressIndicator())
                                : _buildVehicleDropdown(
                                    label: "Select Vehicle",
                                    icon: Icons.directions_car,
                                    value: state.vehicleID,
                                    vehicles: state.vehicles,
                                    onChanged: (val) =>
                                        cubit.updateField(vehicleID: val),
                                  ),

                            const SizedBox(height: 20),

                            _buildTextField(
                              label: "Details",
                              icon: Icons.note_alt_outlined,
                              initialValue: state.notes,
                              hint: "Extra details about the trip",
                              maxLines: 3,
                              onChanged: (val) => cubit.updateField(notes: val),
                            ),

                            const SizedBox(height: 40),

                            SizedBox(
                              width: double.infinity,
                              height: 56,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF0D32B3),
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                onPressed: state.isPublishing
                                    ? null
                                    : () async {
                                        final success = await cubit.publishTrip();
                                        if (success && context.mounted) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                state.tripId != null
                                                    ? "Trip Updated Successfully!"
                                                    : "Trip Published Successfully!",
                                              ),
                                              backgroundColor: Colors.green,
                                            ),
                                          );
                                          context.read<DriverHomeCubit>().fetchTrips();
                                          if (Navigator.canPop(context)) {
                                            Navigator.pop(context);
                                          } else {
                                            cubit.resetForm();
                                            context.read<NavigationCubit>().changeIndex(0);
                                          }
                                        }
                                      },
                                child: state.isPublishing
                                    ? const SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : Text(
                                        state.tripId != null ? "Update Trip" : "Publish Trip",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDropdown({
    required String label,
    required IconData icon,
    required String value,
    required Function(String) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w800,
            color: Color(0xFF5A6B87),
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value.isEmpty ? null : value,
          icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF0D32B3)),
          decoration: InputDecoration(
            hintText: "Select City",
            hintStyle: const TextStyle(color: Color(0xFFAAB8D2), fontSize: 14),
            prefixIcon: Icon(icon, color: const Color(0xFF0D32B3), size: 20),
            filled: true,
            fillColor: const Color(0xFFF1F4F9),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
          items: egyptCities.map((city) {
            return DropdownMenuItem(value: city, child: Text(city));
          }).toList(),
          onChanged: (val) => onChanged(val ?? ""),
        ),
      ],
    );
  }

  Widget _buildVehicleDropdown({
    required String label,
    required IconData icon,
    required int? value,
    required List<VehicleModel> vehicles,
    required Function(int) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w800,
            color: Color(0xFF5A6B87),
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<int>(
          value: value,
          icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF0D32B3)),
          decoration: InputDecoration(
            hintText: "Select Your Vehicle",
            hintStyle: const TextStyle(color: Color(0xFFAAB8D2), fontSize: 14),
            prefixIcon: Icon(icon, color: const Color(0xFF0D32B3), size: 20),
            filled: true,
            fillColor: const Color(0xFFF1F4F9),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
          items: vehicles.map((vehicle) {
            return DropdownMenuItem(
              value: vehicle.id,
              child: Text("${vehicle.model} (${vehicle.color})"),
            );
          }).toList(),
          onChanged: (val) => onChanged(val ?? 0),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required IconData icon,
    required String initialValue,
    String? hint,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    required Function(String) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w800,
            color: Color(0xFF5A6B87),
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: initialValue,
          maxLines: maxLines,
          keyboardType: keyboardType,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Color(0xFFAAB8D2), fontSize: 14),
            prefixIcon: Icon(icon, color: const Color(0xFF0D32B3), size: 20),
            filled: true,
            fillColor: const Color(0xFFF1F4F9),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
        ),
      ],
    );
  }
}
