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
}
