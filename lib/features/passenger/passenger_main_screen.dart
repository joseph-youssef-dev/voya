import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:voya/core/databases/api/dio_consumer.dart';
import 'package:voya/features/passenger/home/data/api/home_api_service.dart';
import 'package:voya/features/passenger/home/logic/cubit/home_cubit.dart';
import 'package:voya/features/passenger/history/presentation/screens/passenger_history_screen.dart';
import 'package:voya/features/passenger/home/presentation/screens/passenger_home_screen.dart';
import 'package:voya/features/passenger/profile/presentation/screens/passenger_profile_screen.dart';
import 'package:voya/features/passenger/search/presentation/screens/passenger_search_screen.dart';
import 'package:voya/features/passenger/history/logic/cubit/history_cubit.dart';
import 'package:voya/features/passenger/history/data/api/history_api_service.dart';
import 'package:voya/features/passenger/search/logic/cubit/search_cubit.dart';

class PassengerMainScreen extends StatefulWidget {
  const PassengerMainScreen({super.key});

  @override
  State<PassengerMainScreen> createState() => _PassengerMainScreenState();
}

class _PassengerMainScreenState extends State<PassengerMainScreen> {
  int selectedIndex = 0;

  final List<Widget> screens = [
    const PassengerHomeScreen(),
    const PassengerSearchScreen(),
    const PassengerHistoryScreen(),
    const PassengerProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit(
            apiService: HomeApiService(api: DioConsumer(dio: Dio())),
          )..fetchAllTrips(),
        ),
        BlocProvider(
          create: (context) => HistoryCubit(
            apiService: HistoryApiService(api: DioConsumer(dio: Dio())),
          )..fetchMyTrips(),
        ),
        BlocProvider(
          create: (context) => SearchCubit(
            apiService: HomeApiService(api: DioConsumer(dio: Dio())),
          ),
        ),
      ],
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F8FE),
        body: IndexedStack(index: selectedIndex, children: screens),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 25,
                color: Colors.black.withValues(alpha: 0.08),
                offset: const Offset(0, -5),
              )
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
              child: GNav(
                rippleColor: Colors.grey[300]!,
                hoverColor: Colors.grey[100]!,
                gap: 6,
                activeColor: const Color(0xFF0D32B3),
                iconSize: 22,
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                duration: const Duration(milliseconds: 400),
                tabBackgroundColor: const Color(0xFFEBF1FF),
                color: const Color(0xFF5A6B87),
                tabs: const [
                  GButton(
                    icon: Icons.home_rounded,
                    text: 'Home',
                  ),
                  GButton(
                    icon: Icons.search_rounded,
                    text: 'Search',
                  ),
                  GButton(
                    icon: Icons.history_rounded,
                    text: 'History',
                  ),
                  GButton(
                    icon: Icons.person_rounded,
                    text: 'Profile',
                  ),
                ],
                selectedIndex: selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
