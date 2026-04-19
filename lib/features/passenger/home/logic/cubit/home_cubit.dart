import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/api/home_api_service.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeApiService apiService;

  HomeCubit({required this.apiService}) : super(HomeInitial());

  Future<void> fetchAllTrips() async {
    emit(HomeLoading());
    try {
      final trips = await apiService.getAllTrips();
      emit(HomeSuccess(trips: trips));
    } catch (e) {
      emit(HomeFailure(errorMessage: e.toString()));
    }
  }
}
