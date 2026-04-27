import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voya/core/shared/custom_header.dart';
import 'package:voya/features/passenger/booking/logic/cubit/booking_cubit.dart';
import 'package:voya/features/passenger/booking/logic/cubit/booking_state.dart';
import 'package:voya/features/passenger/history/logic/cubit/history_cubit.dart';
import 'payment_screen.dart';

class BookingScreen extends StatelessWidget {
  final int tripId;
  final double pricePerSeat;
  final String fromCity;
  final String toCity;

  const BookingScreen({
    super.key,
    required this.tripId,
    required this.pricePerSeat,
    required this.fromCity,
    required this.toCity,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<BookingCubit>()..init(pricePerSeat),
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F8FE),
        body: SafeArea(
          child: Column(
            children: [
              const CustomHeader(title: 'Select Seats'),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Trip Details",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF1E2432),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEBF1FF),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "\$$pricePerSeat/seat",
                              style: const TextStyle(
                                color: Color(0xFF0D32B3),
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Icon(
                            Icons.circle,
                            size: 10,
                            color: Color(0xFF0D32B3),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            fromCity,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(width: 10),
                          const Icon(
                            Icons.arrow_forward,
                            size: 14,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 10),
                          const Icon(
                            Icons.location_on,
                            size: 14,
                            color: Color(0xFF0D32B3),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            toCity,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 24),
                        child: Divider(
                          color: Color(0xFFF1F4F9),
                          thickness: 1.5,
                        ),
                      ),
                      const Text(
                        "How many seats do you need?",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF5A6B87),
                        ),
                      ),
                      const SizedBox(height: 20),
                      BlocBuilder<BookingCubit, BookingState>(
                        buildWhen: (prev, curr) => curr is BookingSeatsChanged,
                        builder: (context, state) {
                          int seats = 1;
                          if (state is BookingSeatsChanged) {
                            seats = state.seats;
                          }
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildCounterButton(
                                icon: Icons.remove,
                                onTap: () => context
                                    .read<BookingCubit>()
                                    .updateSeats(seats - 1),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 30,
                                ),
                                child: Text(
                                  "$seats",
                                  style: const TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.w900,
                                    color: Color(0xFF1E2432),
                                  ),
                                ),
                              ),
                              _buildCounterButton(
                                icon: Icons.add,
                                onTap: () => context
                                    .read<BookingCubit>()
                                    .updateSeats(seats + 1),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(30),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Total Price",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF5A6B87),
                          ),
                        ),
                        BlocBuilder<BookingCubit, BookingState>(
                          buildWhen: (prev, curr) =>
                              curr is BookingSeatsChanged,
                          builder: (context, state) {
                            double total = pricePerSeat;
                            if (state is BookingSeatsChanged) {
                              total = state.totalPrice;
                            }
                            return Text(
                              "\$${total.toStringAsFixed(2)}",
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF0D32B3),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: BlocBuilder<BookingCubit, BookingState>(
                        builder: (context, state) {
                          int seats = 1;
                          if (state is BookingSeatsChanged) {
                            seats = state.seats;
                          }
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0D32B3),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (c) => MultiBlocProvider(
                                    providers: [
                                      BlocProvider.value(value: context.read<BookingCubit>()),
                                      BlocProvider.value(value: context.read<HistoryCubit>()),
                                    ],
                                    child: PaymentScreen(
                                      tripId: tripId,
                                      numberOfSeats: seats,
                                      totalPrice: seats * pricePerSeat,
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: const Text(
                              "Proceed to Checkout",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCounterButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFF1F4F9),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Icon(icon, color: const Color(0xFF0D32B3), size: 24),
      ),
    );
  }
}
