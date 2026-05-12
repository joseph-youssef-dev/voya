import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:voya/core/databases/api/dio_consumer.dart';
import 'package:voya/features/passenger/booking/presentation/screens/booking_screen.dart';
import 'package:voya/features/passenger/booking/logic/cubit/booking_cubit.dart';
import 'package:voya/features/passenger/booking/data/api/booking_api_service.dart';
import 'package:voya/features/passenger/history/logic/cubit/history_cubit.dart';
import 'package:voya/features/passenger/home/logic/cubit/home_cubit.dart';

class JourneyCard extends StatelessWidget {
  final int tripId;
  final String driverName;
  final String driverImage;
  final String fromCity;
  final String toCity;
  final String startDate;
  final double pricePerSet;
  final String vehicleModel;
  final double distance;
  final double duration;
  final int availableSeats;
  final List<dynamic> features;
  final String details;
  final bool isBookable;

  const JourneyCard({
    super.key,
    required this.tripId,
    required this.driverName,
    required this.driverImage,
    required this.fromCity,
    required this.toCity,
    required this.startDate,
    required this.pricePerSet,
    required this.vehicleModel,
    required this.distance,
    required this.duration,
    required this.availableSeats,
    required this.features,
    required this.details,
    this.isBookable = true,
  });

  @override
  Widget build(BuildContext context) {
    String formattedTime = "";
    String formattedDate = "";
    try {
      final date = DateTime.parse(startDate);
      final hour = date.hour % 12 == 0 ? 12 : date.hour % 12;
      final period = date.hour >= 12 ? "PM" : "AM";
      formattedTime = "$hour:${date.minute.toString().padLeft(2, '0')} $period";
      formattedDate = "${date.day}/${date.month}/${date.year}";
    } catch (_) {}

    final cleanDriver = driverName.replaceAll(RegExp(r'\\'), '').trim();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Driver Row
          Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: const Color(0xFFEBF1FF),
                backgroundImage: driverImage.isNotEmpty ? NetworkImage(driverImage) : null,
                child: driverImage.isEmpty
                    ? const Icon(
                        Icons.person,
                        color: Color(0xFF0D32B3),
                        size: 22,
                      )
                    : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cleanDriver,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                        color: Color(0xFF1E1E1E),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      vehicleModel,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF9E9E9E),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFEBF1FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "EGP ${pricePerSet.toStringAsFixed(0)}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF0D32B3),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          // Route
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.0,
                        color: Color(0xFF5A5A5A),
                      ),
                    ),
                    Text(
                      fromCity,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1E1E1E),
                      ),
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      "TO",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.0,
                        color: Color(0xFF5A5A5A),
                      ),
                    ),
                    Text(
                      toCity,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1E1E1E),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),
          const Divider(color: Color(0xFFF5F5F5), height: 1),
          const SizedBox(height: 14),

          // Stats Row
          Wrap(
            spacing: 12,
            runSpacing: 8,
            children: [
              _InfoChip(
                icon: Icons.access_time,
                label: "$formattedTime · $formattedDate",
              ),
              _InfoChip(
                icon: Icons.map_outlined,
                label: "${distance.toStringAsFixed(0)} km",
              ),
              _InfoChip(
                icon: Icons.event_seat_outlined,
                label: "$availableSeats seats",
              ),
            ],
          ),

          // Details
          if (details.isNotEmpty) ...[
            const SizedBox(height: 14),
            Text(
              details,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF5A5A5A),
              ),
            ),
          ],

          // Features
          if (features.isNotEmpty) ...[
            const SizedBox(height: 14),
            const Divider(color: Color(0xFFF5F5F5), height: 1),
            const SizedBox(height: 12),
            const Text(
              "FEATURES",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.0,
                color: Color(0xFF5A5A5A),
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 6,
              children: features.map((f) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEBF1FF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    f.toString(),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0D32B3),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],

          const SizedBox(height: 16),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: isBookable
                  ? () {
                      final historyCubit = context.read<HistoryCubit>();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MultiBlocProvider(
                            providers: [
                              BlocProvider(
                                create: (context) => BookingCubit(
                                  apiService: BookingApiService(
                                    api: DioConsumer(dio: Dio()),
                                  ),
                                ),
                              ),
                              BlocProvider.value(value: historyCubit),
                            ],
                            child: BookingScreen(
                              tripId: tripId,
                              pricePerSeat: pricePerSet,
                              fromCity: fromCity,
                              toCity: toCity,
                              availableSeats: availableSeats,
                            ),
                          ),
                        ),
                      ).then((_) {
                        if (context.mounted) {
                          try {
                            context.read<HomeCubit>().fetchAllTrips();
                          } catch (_) {}
                        }
                      });
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: isBookable
                    ? const Color(0xFF0D32B3)
                    : const Color(0xFFD6DFF7),
                foregroundColor: isBookable
                    ? Colors.white
                    : const Color(0xFF0D32B3),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: Text(
                isBookable ? "Book Seat" : "Not Available",
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: const Color(0xFF9E9E9E)),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF5A5A5A),
          ),
        ),
      ],
    );
  }
}
