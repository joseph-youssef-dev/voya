// import 'package:bloc/bloc.dart';

// abstract class AddTripState {}

// class AddTripInitial extends AddTripState {}

// class AddTripStateData extends AddTripState {
//   final int seats;
//   final String from;
//   final String to;
//   final String date;
//   final String time;
//   final String price;
//   final String notes;

//   AddTripStateData({
//     required this.seats,
//     required this.from,
//     required this.to,
//     required this.date,
//     required this.time,
//     required this.price,
//     required this.notes,
//   });

//   AddTripStateData copyWith({
//     int? seats,
//     String? from,
//     String? to,
//     String? date,
//     String? time,
//     String? price,
//     String? notes,
//   }) {
//     return AddTripStateData(
//       seats: seats ?? this.seats,
//       from: from ?? this.from,
//       to: to ?? this.to,
//       date: date ?? this.date,
//       time: time ?? this.time,
//       price: price ?? this.price,
//       notes: notes ?? this.notes,
//     );
//   }
// }

// class AddTripCubit extends Cubit<AddTripState> {
//   AddTripCubit()
//     : super(
//         AddTripStateData(
//           seats: 1,
//           from: '',
//           to: '',
//           date: '',
//           time: '',
//           price: '',
//           notes: '',
//         ),
//       );

//   void updateSeats(int newSeats) {
//     if (state is AddTripStateData) {
//       if (newSeats >= 1 && newSeats <= 100) {
//         emit((state as AddTripStateData).copyWith(seats: newSeats));
//       }
//     }
//   }

//   void updateField({
//     String? from,
//     String? to,
//     String? date,
//     String? time,
//     String? price,
//     String? notes,
//   }) {
//     if (state is AddTripStateData) {
//       emit(
//         (state as AddTripStateData).copyWith(
//           from: from,
//           to: to,
//           date: date,
//           time: time,
//           price: price,
//           notes: notes,
//         ),
//       );
//     }
//   }

//   void publishTrip() {
//     // Logic to save the trip to the database
//   }
// }

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
