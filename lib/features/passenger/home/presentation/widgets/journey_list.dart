import 'package:flutter/material.dart';
import 'package:voya/features/passenger/home/presentation/widgets/journey_card.dart';

class JourneyList extends StatelessWidget {
  final int itemCount;

  const JourneyList({super.key, this.itemCount = 5});

  @override
  Widget build(BuildContext context) {
    // Mock list of template cards to cycle through
    final List<Map<String, dynamic>> mockData = [
      {
        "name": "Alex Chen",
        "rating": "4.9",
        "trips": "128",
        "pickup": "Downtown Arts District",
        "destination": "International Airport (T3)",
        "price": "\$32.00",
        "time": "14:30",
        "day": "Today",
        "avatarUrl": "https://i.pravatar.cc/150?img=11",
        "isBookable": true,
      },
      {
        "name": "Sarah Miller",
        "rating": "5.0",
        "trips": "42",
        "pickup": "North Campus Plaza",
        "destination": "Waterfront Tech Hub",
        "price": "\$18.50",
        "time": "08:15",
        "day": "Tomorrow",
        "avatarUrl": "https://i.pravatar.cc/150?img=5",
        "isBookable": false,
      },
    ];

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      itemCount: itemCount,
      separatorBuilder: (context, index) => const SizedBox(height: 20),
      itemBuilder: (context, index) {
        final data = mockData[index % mockData.length];
        
        return JourneyCard(
          name: data["name"],
          rating: data["rating"],
          trips: data["trips"],
          pickup: data["pickup"],
          destination: data["destination"],
          price: data["price"],
          time: data["time"],
          day: data["day"],
          avatarUrl: data["avatarUrl"],
          isBookable: data["isBookable"],
        );
      },
    );
  }
}
