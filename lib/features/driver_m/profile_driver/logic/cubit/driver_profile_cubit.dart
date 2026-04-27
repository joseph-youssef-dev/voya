import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/api/driver_profile_api_service.dart';
import 'driver_profile_state.dart';

class DriverProfileCubit extends Cubit<DriverProfileState> {
  final DriverProfileApiService apiService;

  DriverProfileCubit({required this.apiService}) : super(DriverProfileInitial());

  Future<void> fetchProfile() async {
    emit(DriverProfileLoading());
    try {
      final profile = await apiService.getProfile();
      emit(DriverProfileSuccess(profile: profile));
    } catch (e) {
      emit(DriverProfileFailure(errorMessage: e.toString()));
    }
  }
}
