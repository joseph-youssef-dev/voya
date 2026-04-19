import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voya/features/passenger/home/presentation/widgets/journey_card.dart';
import 'package:voya/features/passenger/home/logic/cubit/home_cubit.dart';
import 'package:voya/features/passenger/home/logic/cubit/home_state.dart';

class JourneyList extends StatelessWidget {
  const JourneyList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator(color: Color(0xFF0D32B3)));
        } else if (state is HomeFailure) {
          return Center(
            child: Text(
              state.errorMessage, 
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
          );
        } else if (state is HomeSuccess) {
          final trips = state.trips;
          
          if (trips.isEmpty) {
            return const Center(
              child: Text(
                "No trips available", 
                style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            itemCount: trips.length,
            separatorBuilder: (context, index) => const SizedBox(height: 20),
            itemBuilder: (context, index) {
              final trip = trips[index];
              
              String formattedTime = "00:00";
              String formattedDay = "Unknown";
              try {
                final date = DateTime.parse(trip.startDate);
                formattedTime = "${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
                
                final now = DateTime.now();
                if (date.year == now.year && date.month == now.month && date.day == now.day) {
                  formattedDay = "Today";
                } else if (date.year == now.year && date.month == now.month && date.day == now.day + 1) {
                  formattedDay = "Tomorrow";
                } else {
                  formattedDay = "${date.day}/${date.month}/${date.year}";
                }
              } catch (_) {}

              return JourneyCard(
                name: trip.driverName.replaceAll(RegExp(r'\\'), '').trim(),
                rating: "4.8",
                trips: trip.availableSeats.toString(),
                pickup: trip.fromCity,
                destination: trip.toCity,
                price: "\$${trip.pricePerSet.toStringAsFixed(2)}",
                time: formattedTime,
                day: formattedDay,
                avatarUrl: "https://i.pravatar.cc/150?u=${trip.id}", 
                isBookable: trip.availableSeats > 0,
              );
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
