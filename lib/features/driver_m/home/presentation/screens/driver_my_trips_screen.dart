import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voya/core/shared/custom_header.dart';
import 'package:voya/features/driver_m/home/logic/driver_home_cubit.dart';
import 'package:voya/features/driver_m/home/logic/driver_home_state.dart';
import 'package:voya/features/driver_m/home/presentation/widgets/home_widgets.dart';

class DriverMyTripsScreen extends StatelessWidget {
  const DriverMyTripsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F8FE),
        body: SafeArea(
          child: Column(
            children: [
              const CustomHeader(title: 'My Journeys'),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEBF1FF),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(4),
                  child: TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Colors.transparent,
                    indicator: BoxDecoration(
                      color: const Color(0xFF0D32B3),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: const Color(0xFF5A6B87),
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 13,
                    ),
                    tabs: const [
                      Tab(text: "OPEN"),
                      Tab(text: "COMPLETED"),
                      Tab(text: "REJECTED"),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: BlocBuilder<DriverHomeCubit, DriverHomeState>(
                  builder: (context, state) {
                    if (state is DriverHomeLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is DriverHomeError) {
                      return Center(child: Text(state.message));
                    } else if (state is DriverHomeSuccess) {
                      return RefreshIndicator(
                        onRefresh: () =>
                            context.read<DriverHomeCubit>().fetchTrips(),
                        child: TabBarView(
                          children: [
                            _buildTripList(
                              context,
                              state.openTrips,
                              "No active journeys",
                              isWaitingCard: true,
                            ),
                            _buildTripList(
                              context,
                              state.completedTrips,
                              "No completed journeys",
                              isCompletedCard: true,
                            ),
                            _buildTripList(
                              context,
                              state.rejectedTrips,
                              "No rejected journeys",
                              isRejectedCard: true,
                            ),
                          ],
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTripList(
    BuildContext context,
    List trips,
    String emptyMessage, {
    bool isWaitingCard = false,
    bool isCompletedCard = false,
    bool isRejectedCard = false,
  }) {
    if (trips.isEmpty) {
      return Center(
        child: Text(
          emptyMessage,
          style: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      itemCount: trips.length,
      itemBuilder: (context, index) {
        final trip = trips[index];
        if (isWaitingCard) {
          return WaitingTripCard(
            trip: trip,
          );
        } else if (isCompletedCard) {
          return CompletedTripCard(trip: trip);
        } else if (isRejectedCard) {
          return RejectedTripCard(trip: trip);
        }
        return const SizedBox.shrink();
      },
    );
  }
}
