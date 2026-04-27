import 'package:flutter/material.dart';
import 'package:voya/core/shared/custom_header.dart';
import 'package:voya/features/driver_m/home/presentation/widgets/home_widgets.dart';

class CreateTrip extends StatelessWidget {
  const CreateTrip({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FE),
      body: SafeArea(
        child: Column(
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

            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                children: [
                  const _SectionTitle(title: "Waiting Trips"),
                  const WaitingTripCard(),
                  const SizedBox(height: 12),
                  const WaitingTripCard(),
                  const SizedBox(height: 25),
                  const _SectionTitle(title: "Completed History"),
                  CompletedTripCard(
                    origin: 'Cairo',
                    destination: 'Alexandria',
                    price: '${50.00}',
                    passengers: '2',
                  ),
                  const SizedBox(height: 12),
                  CompletedTripCard(
                    origin: 'Giza',
                    destination: 'Hurghada',
                    price: '${120.00}',
                    passengers: '4',
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
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
