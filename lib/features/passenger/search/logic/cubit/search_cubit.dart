import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voya/features/passenger/home/data/api/home_api_service.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final HomeApiService apiService;

  SearchCubit({required this.apiService}) : super(SearchInitial());

  Future<void> searchTrips({required String from, required String to}) async {
    emit(SearchLoading());
    try {
      final trips = await apiService.getAllTrips(from: from, to: to);
      emit(SearchSuccess(trips: trips));
    } catch (e) {
      emit(SearchFailure(errorMessage: e.toString()));
    }
  }

  void resetSearch() {
    emit(SearchInitial());
  }
}
