import 'package:flutter/material.dart';
import 'package:voya/features/passenger/home/presentation/widgets/header_widget.dart';
import 'package:voya/features/passenger/home/presentation/widgets/journey_list.dart';
import 'package:voya/features/passenger/home/presentation/widgets/section_haeder.dart';

class PassengerHomeScreen extends StatelessWidget {
  const PassengerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Column(
        children: [
          SizedBox(height: 16),
          HeaderWidget(),
          SizedBox(height: 30),
          SectionHeader(),
          SizedBox(height: 10),
          Expanded(child: JourneyList()),
        ],
      ),
    );
  }
}
