import 'package:flutter/material.dart';
import 'package:voya/core/shared/voya_app_bar.dart';
import 'package:voya/features/passenger/home/presentation/widgets/journey_list.dart';
import 'package:voya/features/passenger/home/presentation/widgets/section_haeder.dart';

class PassengerHomeScreen extends StatelessWidget {
  const PassengerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const VoyaAppBar(isHome: true),
      body: const Column(
        children: [
          SizedBox(height: 20),
          SectionHeader(),
          SizedBox(height: 10),
          Expanded(child: JourneyList()),
        ],
      ),
    );
  }
}
