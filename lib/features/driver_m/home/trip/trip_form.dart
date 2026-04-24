// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// //import 'package:voya/core/constants/app_colors.dart' hide AppColors;
// import 'package:voya/features/driver/home/cubit/add_trip_cubit.dart';
// import 'package:voya/features/driver/home/seat_selector.dart';
// import 'package:voya/features/driver/home/trip_header.dart';
// import 'package:voya/features/driver/home/trip_input_home.dart';
// import '../cubit/add_trip_state.dart';
// import 'trip_section_title.dart';
// import 'schedule_row.dart';
// import 'package:voya/features/Theme/colors/app_colors.dart';

// class TripForm extends StatelessWidget {
//   const TripForm({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AddTripCubit, AddTripState>(
//       builder: (context, state) {
//         if (state is! AddTripStateData) return const SizedBox();

//         final cubit = context.read<AddTripCubit>();

//         return Scaffold(
//           backgroundColor: AppColors.background,
//           body: SingleChildScrollView(
//             child: Column(
//               children: [
//                 const TripHeader(),
//                 const SizedBox(height: 20),

//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: Container(
//                     padding: const EdgeInsets.all(25),
//                     decoration: BoxDecoration(
//                       color: AppColors.surface,
//                       borderRadius: BorderRadius.circular(25),
//                       boxShadow: [
//                         BoxShadow(
//                           color: AppColors.shadow,
//                           blurRadius: 20,
//                           offset: const Offset(0, 10),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       children: [
//                         const SectionTitle("Trip Timeline"),

//                         TripInputField(
//                           controller: TextEditingController(text: state.from)
//                             ..selection = TextSelection.collapsed(
//                               offset: state.from.length,
//                             ),
//                           label: "From",
//                           hint: "Departure",
//                           icon: Icons.my_location,
//                           onChanged: (val) => cubit.updateField(from: val),
//                         ),

//                         const SizedBox(height: 16),

//                         TripInputField(
//                           controller: TextEditingController(text: state.to)
//                             ..selection = TextSelection.collapsed(
//                               offset: state.to.length,
//                             ),
//                           label: "To",
//                           hint: "Destination",
//                           icon: Icons.location_on_outlined,
//                           onChanged: (val) => cubit.updateField(to: val),
//                         ),

//                         const Divider(height: 40),

//                         const SectionTitle("Schedule & Pricing"),

//                         ScheduleRow(state: state),

//                         const SizedBox(height: 16),

//                         Row(
//                           children: [
//                             Expanded(
//                               child: TripInputField(
//                                 controller:
//                                     TextEditingController(text: state.price)
//                                       ..selection = TextSelection.collapsed(
//                                         offset: state.price.length,
//                                       ),
//                                 label: "Price (EGP)",
//                                 hint: "0.0",

//                                 icon: Icons.attach_money,
//                                 keyboardType: TextInputType.number,
//                                 onChanged: (val) =>
//                                     cubit.updateField(price: val),
//                               ),
//                             ),
//                             const SizedBox(width: 15),
//                             Expanded(
//                               child: SeatSelector(
//                                 controller: TextEditingController(
//                                   text: state.seats.toString(),
//                                 ),
//                                 onIncrement: () =>
//                                     cubit.updateSeats(state.seats + 1),
//                                 onDecrement: () =>
//                                     cubit.updateSeats(state.seats - 1),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 20),
//                         TripInputField(
//                           controller: TextEditingController(text: state.notes)
//                             ..selection = TextSelection.collapsed(
//                               offset: state.notes.length,
//                             ),
//                           label: "Notes",
//                           hint: "Extra details...",
//                           icon: Icons.note_alt_outlined,
//                           maxLines: 3,
//                           onChanged: (val) => cubit.updateField(notes: val),
//                         ),
//                         const SizedBox(height: 35),
//                         SizedBox(
//                           width: double.infinity,
//                           height: 55,
//                           child: ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: AppColors.primary,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(15),
//                               ),
//                               elevation: 5,
//                               shadowColor: AppColors.shadow,
//                             ),
//                             onPressed: () {
//                               cubit.publishTrip();
//                               Navigator.pop(context);
//                             },
//                             child: const Text(
//                               "Publish Trip",
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 color: AppColors.white,
//                                 letterSpacing: 1,
//                               ),
//                             ),
//                           ),
//                         ),

//                         const SizedBox(height: 20),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voya/features/driver_m/Theme/colors/app_colors.dart';
import 'package:voya/features/driver_m/home/bottom_nav.dart';
import 'package:voya/features/driver_m/home/seat_selector.dart';
import 'package:voya/features/driver_m/home/trip_header.dart';
import '../cubit/add_trip_cubit.dart';
import '../cubit/add_trip_state.dart';
import 'trip_section_title.dart';
import 'schedule_row.dart';

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
                const TripHeader(),
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
