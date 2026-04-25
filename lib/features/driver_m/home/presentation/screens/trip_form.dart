import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voya/features/driver_m/Theme/colors/app_colors.dart';
import 'package:voya/features/driver_m/home/presentation/screens/bottom_nav.dart';
import 'package:voya/features/driver_m/home/presentation/widgets/trip_widgets.dart';
import '../../logic/add_trip_cubit.dart';
import '../../logic/add_trip_state.dart';

//   المحافظات
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
          backgroundColor: AppColors.background,
          body: SingleChildScrollView(
            child: Column(
              children: [
                // const TripHeader(),
                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.shadow,
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const SectionTitle("Trip Timeline"),

                        // From
                        DropdownButtonFormField<String>(
                          initialValue: state.from.isEmpty ? null : state.from,
                          decoration: InputDecoration(
                            labelText: "From",
                            prefixIcon: const Icon(Icons.my_location),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          items: egyptCities.map((city) {
                            return DropdownMenuItem(
                              value: city,
                              child: Text(city),
                            );
                          }).toList(),
                          onChanged: (val) {
                            if (val != null) {
                              cubit.updateField(from: val);
                            }
                          },
                        ),

                        const SizedBox(height: 16),

                        // To
                        DropdownButtonFormField<String>(
                          initialValue: state.to.isEmpty ? null : state.to,
                          decoration: InputDecoration(
                            labelText: "To",
                            prefixIcon: const Icon(Icons.location_on_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          items: egyptCities.map((city) {
                            return DropdownMenuItem(
                              value: city,
                              child: Text(city),
                            );
                          }).toList(),
                          onChanged: (val) {
                            if (val != null) {
                              cubit.updateField(to: val);
                            }
                          },
                        ),

                        const Divider(height: 40),

                        const SectionTitle("Schedule & Pricing"),

                        ScheduleRow(state: state),

                        const SizedBox(height: 16),

                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                initialValue: state.price,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: "Price (EGP)",
                                  prefixIcon: const Icon(Icons.attach_money),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                onChanged: (val) =>
                                    cubit.updateField(price: val),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: SeatSelector(
                                controller: TextEditingController(
                                  text: state.seats.toString(),
                                ),
                                onIncrement: () =>
                                    cubit.updateSeats(state.seats + 1),
                                onDecrement: () =>
                                    cubit.updateSeats(state.seats - 1),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        TextFormField(
                          initialValue: state.notes,
                          maxLines: 3,
                          decoration: InputDecoration(
                            labelText: "Notes",
                            hintText: "Extra details...",
                            prefixIcon: const Icon(Icons.note_alt_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onChanged: (val) => cubit.updateField(notes: val),
                        ),

                        const SizedBox(height: 35),

                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 5,
                              shadowColor: AppColors.shadow,
                            ),
                            onPressed: () {
                              cubit.publishTrip();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const CustomBottomNavBar(),
                                ),
                              );
                            },
                            child: const Text(
                              "Publish Trip",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.white,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
