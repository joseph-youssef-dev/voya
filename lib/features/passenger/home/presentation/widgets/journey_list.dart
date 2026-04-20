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

              return JourneyCard(
                driverName: trip.driverName,
                fromCity: trip.fromCity,
                toCity: trip.toCity,
                startDate: trip.startDate,
                pricePerSet: trip.pricePerSet,
                vehicleModel: trip.vehicleModel,
                distance: trip.distance,
                duration: trip.duration,
                availableSeats: trip.availableSeats,
                features: trip.features,
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
