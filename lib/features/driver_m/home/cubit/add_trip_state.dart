abstract class AddTripState {}

class AddTripInitial extends AddTripState {}

class AddTripStateData extends AddTripState {
  final int seats;
  final String from;
  final String to;
  final String date;
  final String time;
  final String price;
  final String notes;

  AddTripStateData({
    required this.seats,
    required this.from,
    required this.to,
    required this.date,
    required this.time,
    required this.price,
    required this.notes,
  });

  AddTripStateData copyWith({
    int? seats,
    String? from,
    String? to,
    String? date,
    String? time,
    String? price,
    String? notes,
  }) {
    return AddTripStateData(
      seats: seats ?? this.seats,
      from: from ?? this.from,
      to: to ?? this.to,
      date: date ?? this.date,
      time: time ?? this.time,
      price: price ?? this.price,
      notes: notes ?? this.notes,
    );
  }
}
