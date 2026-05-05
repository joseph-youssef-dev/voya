import 'package:flutter/material.dart';
import 'package:voya/features/passenger/home/data/models/trip_model.dart';

class CompletedTripCard extends StatelessWidget {
  final TripModel trip;

  const CompletedTripCard({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    return _BaseTripCard(
      trip: trip,
      status: "COMPLETED",
      statusColor: const Color(0xFF10B981),
      statusBg: const Color(0xFFD1FAE5),
    );
  }
}

class RejectedTripCard extends StatelessWidget {
  final TripModel trip;

  const RejectedTripCard({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    return _BaseTripCard(
      trip: trip,
      status: "REJECTED",
      statusColor: const Color(0xFFEF4444),
      statusBg: const Color(0xFFFEE2E2),
    );
  }
}

class WaitingTripCard extends StatelessWidget {
  final TripModel trip;
  final VoidCallback? onEdit;

  const WaitingTripCard({
    super.key,
    required this.trip,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return _BaseTripCard(
      trip: trip,
      status: trip.status.toUpperCase(),
      statusColor: trip.status.toLowerCase() == 'pending' 
          ? const Color(0xFFF59E0B) 
          : const Color(0xFF0D32B3),
      statusBg: trip.status.toLowerCase() == 'pending' 
          ? const Color(0xFFFEF3C7) 
          : const Color(0xFFEBF1FF),
      onEdit: onEdit,
    );
  }
}

class _BaseTripCard extends StatelessWidget {
  final TripModel trip;
  final String status;
  final Color statusColor;
  final Color statusBg;
  final VoidCallback? onEdit;

  const _BaseTripCard({
    required this.trip,
    required this.status,
    required this.statusColor,
    required this.statusBg,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    String formattedTime = "";
    String formattedDate = "";
    try {
      final date = DateTime.parse(trip.startDate);
      final hour = date.hour % 12 == 0 ? 12 : date.hour % 12;
      final period = date.hour >= 12 ? "PM" : "AM";
      formattedTime = "$hour:${date.minute.toString().padLeft(2, '0')} $period";
      formattedDate = "${date.day}/${date.month}/${date.year}";
    } catch (_) {}

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
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
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: statusBg,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    color: statusColor,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              if (onEdit != null)
                IconButton(
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit_outlined, size: 20, color: Color(0xFF5A6B87)),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
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
                      border: Border.all(color: const Color(0xFF0D32B3), width: 2.5),
                    ),
                  ),
                  Container(width: 2, height: 36, color: const Color(0xFFF0F0F0)),
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
                    "EGP ${trip.pricePerSet.toStringAsFixed(0)}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF0D32B3),
                    ),
                  ),
                  const Text(
                    "per seat",
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(0xFF5A6B87),
                      fontWeight: FontWeight.w500,
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
              const Icon(Icons.calendar_today_outlined, size: 14, color: Color(0xFF9E9E9E)),
              const SizedBox(width: 6),
              Text(
                "$formattedDate · $formattedTime",
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF5A5A5A),
                ),
              ),
              const Spacer(),
              const Icon(Icons.people_outline, size: 16, color: Color(0xFF9E9E9E)),
              const SizedBox(width: 6),
              Text(
                "${trip.availableSeats} seats",
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

class DateTimeHelper {
  static Future<void> pickDate({
    required BuildContext context,
    required TextEditingController controller,
  }) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      controller.text = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
    }
  }

  static Future<void> pickTime({
    required BuildContext context,
    required TextEditingController controller,
    required VoidCallback onPicked,
  }) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      final hour = picked.hourOfPeriod == 0 ? 12 : picked.hourOfPeriod;
      final minute = picked.minute.toString().padLeft(2, '0');
      final period = picked.period == DayPeriod.am ? "AM" : "PM";

      controller.text = "$hour:$minute $period";
      onPicked();
    }
  }
}
