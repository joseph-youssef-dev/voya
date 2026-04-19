import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:voya/core/databases/api/dio_consumer.dart';
import 'package:voya/features/passenger/profile/data/api/profile_api_service.dart';
import 'package:voya/features/passenger/profile/logic/cubit/profile_cubit.dart';
import 'package:voya/features/passenger/profile/logic/cubit/profile_state.dart';
import 'package:voya/features/passenger/profile/presentation/widgets/personal_details_section.dart';
import 'package:voya/features/passenger/profile/presentation/widgets/profile_header_card.dart';
import 'package:voya/features/passenger/profile/presentation/widgets/logout_button.dart';

class PassengerProfileScreen extends StatelessWidget {
  const PassengerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(
        apiService: ProfileApiService(api: DioConsumer(dio: Dio())),
      )..fetchProfile(),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 45),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    if (state is ProfileLoading) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 60),
                          child: CircularProgressIndicator(
                            color: Color(0xFF0D32B3),
                          ),
                        ),
                      );
                    } else if (state is ProfileFailure) {
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
                    } else if (state is ProfileSuccess) {
                      final profile = state.profile;
                      return Column(
                        children: [
                          ProfileHeaderCard(profile: profile),
                          const SizedBox(height: 20),
                          PersonalDetailsSection(profile: profile),
                          const SizedBox(height: 20),
                          const LogoutButton(),
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
    );
  }
}
