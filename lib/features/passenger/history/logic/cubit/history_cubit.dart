import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/api/history_api_service.dart';
import 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final HistoryApiService apiService;

  HistoryCubit({required this.apiService}) : super(HistoryInitial());

  Future<void> fetchMyTrips() async {
    emit(HistoryLoading());
    try {
      final trips = await apiService.getMyTrips();
      emit(HistorySuccess(trips: trips));
    } catch (e) {
      emit(HistoryFailure(errorMessage: e.toString()));
    }
  }
}
