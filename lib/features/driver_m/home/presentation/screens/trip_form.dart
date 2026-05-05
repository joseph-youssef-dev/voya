import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voya/features/driver_m/home/logic/driver_home_cubit.dart';
import 'package:voya/features/driver_m/home/logic/navigation_cubit.dart';
import 'package:voya/core/shared/custom_header.dart';
import 'package:voya/features/driver_m/home/presentation/widgets/trip_widgets.dart';
import 'package:voya/features/driver_m/profile_driver/data/models/driver_profile_model.dart';
import '../../logic/add_trip_cubit.dart';
import '../../logic/add_trip_state.dart';
import 'package:voya/core/constants/egypt_cities.dart';

class TripForm extends StatefulWidget {
  const TripForm({super.key});

  @override
  State<TripForm> createState() => _TripFormState();
}

class _TripFormState extends State<TripForm> {
  final _priceController = TextEditingController();
  final _durationController = TextEditingController();
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _priceController.dispose();
    _durationController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddTripCubit, AddTripState>(
      builder: (context, state) {
        if (state is! AddTripStateData) return const SizedBox();

        final cubit = context.read<AddTripCubit>();

        // Update controllers only if they are empty and state is not, 
        // or if we are in Edit mode and controllers don't match state (initial load)
        if (_priceController.text != state.price && state.price.isNotEmpty && _priceController.text.isEmpty) {
          _priceController.text = state.price;
        }
        if (_durationController.text != state.duration && state.duration.isNotEmpty && _durationController.text.isEmpty) {
          _durationController.text = state.duration;
        }
        if (_notesController.text != state.notes && state.notes.isNotEmpty && _notesController.text.isEmpty) {
          _notesController.text = state.notes;
        }
        
        // Forced update for Edit mode initial load
        if (state.tripId != null && _priceController.text.isEmpty && state.price.isNotEmpty) {
           _priceController.text = state.price;
        }

        return Scaffold(
          backgroundColor: const Color(0xFFF6F8FE),
          body: MultiBlocListener(
            listeners: [
              BlocListener<AddTripCubit, AddTripState>(
                listener: (context, state) {
                  if (state is AddTripStateData) {
                    if (state.errorMessage != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.errorMessage!),
                          backgroundColor: Colors.red,
                        ),
                      );
                      cubit.clearError();
                    }
                    
                    // Handle reset
                    if (state.price.isEmpty && _priceController.text.isNotEmpty) {
                      _priceController.clear();
                      _durationController.clear();
                      _notesController.clear();
                    }
                  }
                },
              ),
              BlocListener<NavigationCubit, int>(
                listener: (context, index) {
                  if (index == 1) {
                    cubit.fetchVehicles();
                  }
                },
              ),
            ],
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
                                    icon: Icons.payments_outlined,
                                    controller: _priceController,
                                    keyboardType: TextInputType.number,
                                    onChanged: (val) => cubit.updateField(price: val),
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: _buildTextField(
                                    label: "Duration",
                                    icon: Icons.timer_outlined,
                                    controller: _durationController,
                                    hint: "e.g. 2h 30m",
                                    onChanged: (val) => cubit.updateField(duration: val),
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
                                    onChanged: (val) => cubit.updateField(vehicleID: val),
                                  ),
                            const SizedBox(height: 20),
                            _buildTextField(
                              label: "Details",
                              icon: Icons.note_alt_outlined,
                              controller: _notesController,
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
                                          if (state.tripId != null && Navigator.canPop(context)) {
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
          key: ValueKey(value),
          initialValue: value.isEmpty ? null : value,
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
          items: EgyptCities.list.map((city) {
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
          key: ValueKey(value),
          initialValue: value,
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
    required TextEditingController controller,
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
          controller: controller,
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
