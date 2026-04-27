import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/api/booking_api_service.dart';
import '../../data/models/booking_request_model.dart';
import 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  final BookingApiService apiService;

  BookingCubit({required this.apiService}) : super(BookingInitial());

  int _currentSeats = 1;
  double _pricePerSeat = 0;

  void init(double pricePerSeat) {
    _pricePerSeat = pricePerSeat;
    emit(BookingSeatsChanged(seats: _currentSeats, totalPrice: _currentSeats * _pricePerSeat));
  }

  void updateSeats(int seats) {
    if (seats < 1) return;
    _currentSeats = seats;
    emit(BookingSeatsChanged(seats: _currentSeats, totalPrice: _currentSeats * _pricePerSeat));
  }

  Future<void> createBooking(BookingRequestModel request) async {
    emit(BookingLoading());
    try {
      await apiService.createBooking(request);
      emit(BookingSuccess(message: "Booking requested successfully!"));
    } catch (e) {
      emit(BookingFailure(errorMessage: e.toString()));
    }
  }
}
