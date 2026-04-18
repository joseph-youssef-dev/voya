import 'package:flutter/material.dart';
import 'package:voya/core/constants/app_colors.dart';
import 'package:voya/features/passenger/home/presentation/widgets/journey_card.dart';

class PassengerHistoryScreen extends StatelessWidget {
  const PassengerHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Row(
                children: [
                  Text(
                    "My Trips",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: AppColors.textPrimaryColor,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TabBar(
                dividerColor: Colors.transparent,
                indicator: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: Colors.white,
                unselectedLabelColor: AppColors.textSecondaryColor,
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                ),
                tabs: const [
                  Tab(text: "Success"),
                  Tab(text: "Pending"),
                  Tab(text: "Failed"),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildTripsList(context, tripType: "success"),
                  _buildTripsList(context, tripType: "pending"),
                  _buildTripsList(context, tripType: "failed"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTripsList(BuildContext context, {required String tripType}) {
    int itemCount = tripType == 'success' ? 4 : (tripType == 'pending' ? 1 : 2);
    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: itemCount,
      separatorBuilder: (context, index) => const SizedBox(height: 20),
      itemBuilder: (context, index) {
        return JourneyCard(
          name: "Ahmed Mohamed",
          rating: "4.8",
          trips: "120",
          pickup: "Cairo, Nasr City",
          destination: "Alexandria, Smouha",
          price: "EGP 250",
          time: "08:30 AM",
          day: "Mon, 12 Oct",
          isBookable: false,
          avatarUrl: 'https://i.pravatar.cc/150?img=${index + 10 + (tripType == "pending" ? 5 : 0)}',
        );
      },
    );
  }
}
