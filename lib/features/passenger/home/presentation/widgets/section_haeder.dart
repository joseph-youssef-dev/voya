import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voya/features/passenger/home/logic/cubit/home_cubit.dart';
import 'package:voya/features/passenger/home/logic/cubit/home_state.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Available Journeys",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 22,
                  color: Color(0xFF000000),
                ),
              ),
              const SizedBox(height: 4),
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  int count = 0;
                  if (state is HomeSuccess) {
                    count = state.trips.length;
                  }
                  return Text(
                    "Found $count trips matching your profile",
                    style: const TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  );
                },
              ),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
