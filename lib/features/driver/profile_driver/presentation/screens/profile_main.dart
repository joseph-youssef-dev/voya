import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:voya/core/databases/api/dio_consumer.dart';
import 'package:voya/core/shared/custom_header.dart';
import 'package:voya/features/driver/profile_driver/data/api/driver_profile_api_service.dart';
import 'package:voya/features/driver/profile_driver/logic/cubit/driver_profile_cubit.dart';
import 'package:voya/features/driver/profile_driver/logic/cubit/driver_profile_state.dart';
import 'package:voya/features/driver/profile_driver/presentation/widgets/driver_personal_details_section.dart';
import 'package:voya/features/driver/profile_driver/presentation/widgets/driver_profile_header_card.dart';
import 'package:voya/features/driver/profile_driver/presentation/widgets/driver_vehicles_section.dart';
import 'package:voya/features/passenger/profile/presentation/widgets/logout_button.dart';

class DriverProfileScreen extends StatelessWidget {
  const DriverProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DriverProfileCubit(
        apiService: DriverProfileApiService(api: DioConsumer(dio: Dio())),
      )..fetchProfile(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F8FE),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const CustomHeader(title: 'Driver Profile'),
                const SizedBox(height: 45),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: BlocConsumer<DriverProfileCubit, DriverProfileState>(
                    listener: (context, state) {
                      // DriverProfileScreen handles general profile errors.
                      // Specific actions (like adding a vehicle or editing profile)
                      // are handled in their respective screens.
                    },
                    builder: (context, state) {
                      if (state is DriverProfileLoading ||
                          state is DriverVehicleActionLoading) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 60),
                            child: CircularProgressIndicator(
                              color: Color(0xFF0D32B3),
                            ),
                          ),
                        );
                      } else if (state is DriverProfileFailure) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 60),
                            child: Text(
                              state.errorMessage,
                              style: const TextStyle(color: Colors.red),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      } else if (state is DriverProfileSuccess) {
                        final profile = state.profile;
                        return Column(
                          children: [
                            DriverProfileHeaderCard(profile: profile),
                            const SizedBox(height: 20),
                            DriverPersonalDetailsSection(profile: profile),
                            const SizedBox(height: 20),
                            DriverVehiclesSection(profile: profile),
                            const SizedBox(height: 20),
                            const LogoutButton(),
                            const SizedBox(height: 20),
                          ],
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
