import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:voya/core/databases/api/dio_consumer.dart';
import 'package:voya/core/shared/custom_header.dart';
import 'package:voya/features/driver_m/home/data/api/trip_api_service.dart';
import 'package:voya/features/driver_m/home/logic/driver_home_cubit.dart';
import 'package:voya/features/driver_m/home/logic/driver_home_state.dart';
import 'package:voya/features/driver_m/home/logic/navigation_cubit.dart';
import 'package:voya/features/driver_m/home/presentation/screens/add_new_trip.dart';
import 'package:voya/features/driver_m/home/presentation/widgets/home_widgets.dart';

class CreateTrip extends StatelessWidget {
  const CreateTrip({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FE),
      body: SafeArea(
        child: BlocBuilder<DriverHomeCubit, DriverHomeState>(
          builder: (context, state) {
            return Column(
              children: [
                const CustomHeader(title: 'Driver Hub'),
                const SizedBox(height: 30),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      const Text(
                        "SCHEDULED JOURNEYS",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF5A6B87),
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Divider(color: Color(0xFFEBEFF5), thickness: 2),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                if (state is DriverHomeLoading)
                  const Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  )
                else if (state is DriverHomeError)
                  Expanded(child: Center(child: Text(state.message)))
                else if (state is DriverHomeSuccess)
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () =>
                          context.read<DriverHomeCubit>().fetchTrips(),
                      child: ListView(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        children: [
                          if (state.waitingTrips.isNotEmpty) ...[
                            const _SectionTitle(title: "Waiting Trips"),
                            ...state.waitingTrips.map(
                              (trip) => WaitingTripCard(
                                trip: trip,
                                onEdit: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (innerContext) =>
                                          MultiBlocProvider(
                                            providers: [
                                              BlocProvider.value(
                                                value: context
                                                    .read<DriverHomeCubit>(),
                                              ),
                                              BlocProvider.value(
                                                value: context
                                                    .read<NavigationCubit>(),
                                              ),
                                            ],
                                            child: AddNewTripPage(trip: trip),
                                          ),
                                    ),
                                  ).then(
                                    (_) => context
                                        .read<DriverHomeCubit>()
                                        .fetchTrips(),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 25),
                          ],
                          if (state.completedTrips.isNotEmpty) ...[
                            const _SectionTitle(title: "Completed History"),
                            ...state.completedTrips.map(
                              (trip) => CompletedTripCard(trip: trip),
                            ),
                            const SizedBox(height: 25),
                          ],
                          if (state.rejectedTrips.isNotEmpty) ...[
                            const _SectionTitle(title: "Rejected Trips"),
                            ...state.rejectedTrips.map(
                              (trip) => RejectedTripCard(trip: trip),
                            ),
                          ],
                          if (state.waitingTrips.isEmpty &&
                              state.completedTrips.isEmpty &&
                              state.rejectedTrips.isEmpty)
                            const Center(child: Text("No trips found")),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 4),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w900,
          color: Color(0xFF1E2432),
        ),
      ),
    );
  }
}
