import 'package:flutter_bloc/flutter_bloc.dart';
import 'add_trip_state.dart';

class AddTripCubit extends Cubit<AddTripState> {
  AddTripCubit()
    : super(
        AddTripStateData(
          seats: 1,
          from: '',
          to: '',
          date: '',
          time: '',
          price: '',
          notes: '',
        ),
      );

  AddTripStateData get data => state as AddTripStateData;

  void updateSeats(int newSeats) {
    if (newSeats >= 1 && newSeats <= 100) {
      emit(data.copyWith(seats: newSeats));
    }
  }

  void updateField({
    String? from,
    String? to,
    String? date,
    String? time,
    String? price,
    String? notes,
  }) {
    emit(
      data.copyWith(
        from: from,
        to: to,
        date: date,
        time: time,
        price: price,
        notes: notes,
      ),
    );
  }

  void publishTrip() {
    // TODO: API / Database logic
  }
}
