import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voya/core/constants/app_colors.dart';
import 'package:voya/core/shared/custom_header.dart';
import 'package:voya/features/passenger/history/data/models/my_trip_model.dart';
import 'package:voya/features/passenger/history/logic/cubit/history_cubit.dart';
import 'package:voya/features/passenger/history/logic/cubit/history_state.dart';

class PassengerHistoryScreen extends StatelessWidget {
  const PassengerHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Column(
          children: [
            const CustomHeader(title: 'My Trips'),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Row(
                children: [
                  Text(
                    "My Trips",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: AppColors.textPrimaryColor,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                    Tab(text: "Pending"),
                    Tab(text: "Approved"),
                    Tab(text: "Rejected"),
                  ],
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<HistoryCubit, HistoryState>(
                buildWhen: (previous, current) =>
                    current is HistoryLoading ||
                    current is HistorySuccess ||
                    current is HistoryFailure,
                builder: (context, state) {
                  if (state is HistoryLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF0D32B3),
                      ),
                    );
                  } else if (state is HistoryFailure) {
                    return Center(
                      child: Text(
                        state.errorMessage,
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                    );
                  } else if (state is HistorySuccess) {
                    final trips = state.trips;

                    return TabBarView(
                      children: [
                        _buildTripList(
                          trips
                              .where((t) => t.status.toLowerCase() == 'pending')
                              .toList(),
                        ),
                        _buildTripList(
                          trips
                              .where(
                                (t) => t.status.toLowerCase() == 'successful',
                              )
                              .toList(),
                        ),
                        _buildTripList(
                          trips
                              .where(
                                (t) => t.status.toLowerCase() == 'rejected',
                              )
                              .toList(),
                        ),
                      ],
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTripList(List<MyTripModel> trips) {
    if (trips.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.receipt_long_outlined,
              size: 64,
              color: Color(0xFFCBD5E1),
            ),
            SizedBox(height: 16),
            Text(
              "No trips yet",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF94A3B8),
              ),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: trips.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        return _MyTripCard(trip: trips[index]);
      },
    );
  }
}

class _MyTripCard extends StatelessWidget {
  final MyTripModel trip;

  const _MyTripCard({required this.trip});

  @override
  Widget build(BuildContext context) {
    String formattedTime = "";
    String formattedDate = "";
    try {
      final date = DateTime.parse(trip.startDate);
      final hour = date.hour % 12 == 0 ? 12 : date.hour % 12;
      final period = date.hour >= 12 ? "PM" : "AM";
      formattedTime =
          "$hour:${date.minute.toString().padLeft(2, '0')} $period";
      formattedDate = "${date.day}/${date.month}/${date.year}";
    } catch (_) {}

    final Color statusColor;
    final Color statusBg;
    switch (trip.status.toLowerCase()) {
      case 'accepted':
      case 'successful':
        statusColor = const Color(0xFF10B981);
        statusBg = const Color(0xFFD1FAE5);
        break;
      case 'rejected':
        statusColor = const Color(0xFFEF4444);
        statusBg = const Color(0xFFFEE2E2);
        break;
      default:
        statusColor = const Color(0xFFF59E0B);
        statusBg = const Color(0xFFFEF3C7);
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: statusBg,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  trip.status.toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    color: statusColor,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Column(
                children: [
                  const SizedBox(height: 4),
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF0D32B3),
                        width: 2.5,
                      ),
                    ),
                  ),
                  Container(
                    width: 2,
                    height: 36,
                    color: const Color(0xFFF0F0F0),
                  ),
                  Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF0D32B3),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "FROM",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.0,
                        color: Color(0xFF5A5A5A),
                      ),
                    ),
                    Text(
                      trip.fromCity,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1E1E1E),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "TO",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.0,
                        color: Color(0xFF5A5A5A),
                      ),
                    ),
                    Text(
                      trip.toCity,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1E1E1E),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "EGP ${(trip.pricePerSet * trip.numberOfSeats).toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF0D32B3),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${trip.numberOfSeats} x EGP ${trip.pricePerSet.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF5A5A5A),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(color: Color(0xFFF0F0F0), height: 1),
          const SizedBox(height: 14),
          Row(
            children: [
              if (trip.driverImage != null && trip.driverImage!.isNotEmpty)
                CircleAvatar(
                  radius: 12,
                  backgroundImage: NetworkImage(trip.driverImage!),
                  backgroundColor: const Color(0xFFF0F0F0),
                )
              else
                const CircleAvatar(
                  radius: 12,
                  backgroundColor: Color(0xFFF0F0F0),
                  child: Icon(
                    Icons.person_outline,
                    size: 14,
                    color: Color(0xFF9E9E9E),
                  ),
                ),
              const SizedBox(width: 8),
              Text(
                trip.driverName.replaceAll(RegExp(r'\\'), '').trim(),
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF5A5A5A),
                ),
              ),
              const Spacer(),
              const Icon(Icons.access_time, size: 16, color: Color(0xFF9E9E9E)),
              const SizedBox(width: 4),
              Text(
                "$formattedTime  ·  $formattedDate",
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF5A5A5A),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
