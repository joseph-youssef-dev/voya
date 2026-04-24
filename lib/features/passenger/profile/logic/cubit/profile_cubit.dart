import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/api/profile_api_service.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileApiService apiService;

  ProfileCubit({required this.apiService}) : super(ProfileInitial());

  Future<void> fetchProfile() async {
    emit(ProfileLoading());
    try {
      final profile = await apiService.getProfile();
      emit(ProfileSuccess(profile: profile));
    } catch (e) {
      emit(ProfileFailure(errorMessage: e.toString()));
    }
  }

  Future<void> updateProfile({
    required String firstName,
    required String lastName,
    required String birthDate,
    required String phone,
    required String town,
    String? profileImagePath,
  }) async {
    emit(ProfileUpdateLoading());
    try {
      await apiService.updateProfile(
        firstName: firstName,
        lastName: lastName,
        birthDate: birthDate,
        phone: phone,
        town: town,
        profileImagePath: profileImagePath,
      );
      emit(ProfileUpdateSuccess(message: "Profile updated successfully"));
      // Wait for listeners (Navigator.pop) to process before refreshing
      await Future.delayed(const Duration(milliseconds: 300));
      fetchProfile();
    } catch (e) {
      emit(ProfileUpdateFailure(errorMessage: e.toString()));
    }
  }
}
