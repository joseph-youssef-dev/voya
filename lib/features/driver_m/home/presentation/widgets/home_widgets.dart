import 'package:flutter/material.dart';
import 'package:voya/features/passenger/home/data/models/trip_model.dart';

class CompletedTripCard extends StatelessWidget {
  final TripModel trip;

  const CompletedTripCard({
    super.key,
    required this.trip,
  });

  @override
  Widget build(BuildContext context) {
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
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFD1FAE5),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.check_circle, color: Color(0xFF10B981), size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${trip.fromCity} to ${trip.toCity}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1E2432),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "${trip.availableSeats} Available Seats · Completed",
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF5A6B87),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "EGP ${trip.pricePerSet}",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: Color(0xFF10B981),
            ),
          ),
        ],
      ),
    );
  }
}

class RejectedTripCard extends StatelessWidget {
  final TripModel trip;

  const RejectedTripCard({
    super.key,
    required this.trip,
  });

  @override
  Widget build(BuildContext context) {
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
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFFEE2E2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.cancel, color: Color(0xFFDC2626), size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${trip.fromCity} to ${trip.toCity}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1E2432),
                  ),
                ),
                const SizedBox(height: 4),
                RichText(
                  text: TextSpan(
                    text: "${trip.availableSeats} Available Seats · ",
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF5A6B87),
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Inter',
                    ),
                    children: const [
                      TextSpan(
                        text: "Rejected",
                        style: TextStyle(
                          color: Color(0xFFDC2626),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Text(
            "EGP ${trip.pricePerSet}",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: Color(0xFFDC2626),
            ),
          ),
        ],
      ),
    );
  }
}

class WaitingTripCard extends StatelessWidget {
  final TripModel trip;
  final VoidCallback onEdit;

  const WaitingTripCard({
    super.key,
    required this.trip,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFFEBF1FF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  "UPCOMING",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF0D32B3),
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: onEdit,
                    icon: const Icon(Icons.edit_outlined, size: 20, color: Color(0xFF5A6B87)),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  const SizedBox(height: 4),
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFF0D32B3), width: 2),
                    ),
                  ),
                  Container(width: 1.5, height: 25, color: const Color(0xFFF1F4F9)),
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF0D32B3),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      trip.fromCity,
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Color(0xFF1E2432)),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      trip.toCity,
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Color(0xFF1E2432)),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "EGP ${trip.pricePerSet}",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Color(0xFF0D32B3)),
                  ),
                  const Text(
                    "per seat",
                    style: TextStyle(fontSize: 11, color: Color(0xFF5A6B87), fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(color: Color(0xFFF1F4F9), thickness: 1.5),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.calendar_today_outlined, size: 14, color: Color(0xFF5A6B87)),
                  const SizedBox(width: 6),
                  Text(
                    trip.startDate.split('T')[0],
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF5A6B87)),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.people_outline, size: 16, color: Color(0xFF5A6B87)),
                  const SizedBox(width: 6),
                  Text(
                    "${trip.availableSeats} seats available",
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF5A6B87)),
                  ),
                ],
              ),
            ],
          ),
          if (trip.details.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              trip.details,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xFF5A6B87),
              ),
            ),
          ],
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
