import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voya/core/constants/app_colors.dart';
import 'package:voya/core/shared/custom_header.dart';
import 'package:voya/features/passenger/home/presentation/widgets/journey_card.dart';
import 'package:voya/features/passenger/search/logic/cubit/search_cubit.dart';
import 'package:voya/features/passenger/search/logic/cubit/search_state.dart';
import 'package:voya/core/constants/egypt_cities.dart';

class PassengerSearchScreen extends StatefulWidget {
  const PassengerSearchScreen({super.key});

  @override
  State<PassengerSearchScreen> createState() => _PassengerSearchScreenState();
}

class _PassengerSearchScreenState extends State<PassengerSearchScreen> {
  String? _selectedFrom;
  String? _selectedTo;
  final _dateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final List<String> _governorates = EgyptCities.list;

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const CustomHeader(title: "Search Journey"),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDropdownField(
                    value: _selectedFrom,
                    hint: "From (e.g. Cairo)",
                    icon: Icons.my_location,
                    items: _governorates
                        .where((city) => city != _selectedTo)
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedFrom = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please select departure location";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildDropdownField(
                    value: _selectedTo,
                    hint: "To (e.g. Alexandria)",
                    icon: Icons.location_on,
                    items: _governorates
                        .where((city) => city != _selectedFrom)
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedTo = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please select destination";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildInputField(
                    controller: _dateController,
                    icon: Icons.calendar_today,
                    hint: "Date (e.g. 15 Oct)",
                    readOnly: true,
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2030),
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: const ColorScheme.light(
                                primary: AppColors.primaryColor,
                                onPrimary: Colors.white,
                                onSurface: AppColors.textPrimaryColor,
                              ),
                            ),
                            child: child!,
                          );
                        },
                      );
                      if (picked != null) {
                        setState(() {
                          _dateController.text =
                              "${picked.day}/${picked.month}/${picked.year}";
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: BlocBuilder<SearchCubit, SearchState>(
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              context.read<SearchCubit>().searchTrips(
                                from: _selectedFrom!,
                                to: _selectedTo!,
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: state is SearchLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text(
                                  "Search",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Search Results",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 22,
                        color: Color(0xFF000000),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "All available trips",
                      style: TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                if (state is SearchInitial) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search, size: 64, color: Color(0xFFCBD5E1)),
                        SizedBox(height: 16),
                        Text(
                          "Enter search details to find a trip",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF94A3B8),
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (state is SearchLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  );
                } else if (state is SearchFailure) {
                  return Center(
                    child: Text(
                      state.errorMessage,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                } else if (state is SearchSuccess) {
                  final trips = state.trips;
                  if (trips.isEmpty) {
                    return const Center(
                      child: Text(
                        "No trips found for this route.",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF94A3B8),
                        ),
                      ),
                    );
                  }
                  return ListView.separated(
                    padding: const EdgeInsets.all(20),
                    itemCount: trips.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final trip = trips[index];
                      return JourneyCard(
                        tripId: trip.id,
                        driverName: trip.driverName,
                        fromCity: trip.fromCity,
                        toCity: trip.toCity,
                        startDate: trip.startDate,
                        pricePerSet: trip.pricePerSet,
                        vehicleModel: trip.vehicleModel,
                        distance: trip.distance,
                        duration: trip.duration,
                        availableSeats: trip.availableSeats,
                        features: trip.features,
                        details: trip.details,
                        isBookable: trip.availableSeats > 0,
                      );
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownField({
    required String? value,
    required String hint,
    required IconData icon,
    required List<String> items,
    required void Function(String?) onChanged,
    String? Function(String?)? validator,
  }) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        );
      }).toList(),
      onChanged: onChanged,
      validator: validator,
      icon: const Icon(
        Icons.keyboard_arrow_down,
        color: AppColors.primaryColor,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.grey.shade400,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        prefixIcon: Icon(icon, color: AppColors.primaryColor, size: 20),
        filled: true,
        fillColor: const Color(0xFFF1F4F9),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required IconData icon,
    required String hint,
    bool readOnly = false,
    VoidCallback? onTap,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.grey.shade400,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        prefixIcon: Icon(icon, color: AppColors.primaryColor, size: 20),
        filled: true,
        fillColor: const Color(0xFFF1F4F9),
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
