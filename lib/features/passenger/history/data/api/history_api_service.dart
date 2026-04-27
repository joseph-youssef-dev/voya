import 'package:voya/core/databases/api/api_consumer.dart';
import 'package:voya/core/constants/end_points.dart';
import '../models/my_trip_model.dart';
import 'package:dio/dio.dart';

class HistoryApiService {
  final ApiConsumer api;

  HistoryApiService({required this.api});

  Future<List<MyTripModel>> getMyTrips() async {
    final response = await api.get(EndPoints.getMyTrips);

    if (response is Map<String, dynamic> && response.containsKey('data')) {
      final data = response['data'];
      if (data is Map<String, dynamic>) {
        final List waiting = data['waitingTrips'] ?? [];
        final List accepted = data['acceptedTrips'] ?? [];
        final List rejected = data['rejectedTrips'] ?? [];
        
        final List<MyTripModel> allTrips = [];
        allTrips.addAll(waiting.map((t) => MyTripModel.fromJson({...t, 'status': 'Pending'})));
        allTrips.addAll(accepted.map((t) => MyTripModel.fromJson({...t, 'status': 'Accepted'})));
        allTrips.addAll(rejected.map((t) => MyTripModel.fromJson({...t, 'status': 'Rejected'})));
        
        return allTrips;
      }
    }

    return [];
  }

  Future<void> updateBooking({
    required int bookingId,
    required int numberOfSeats,
    dynamic receiptImage,
  }) async {
    final Map<String, dynamic> data = {
      'NumberOfSeats': numberOfSeats,
      if (receiptImage != null)
        'PaymentImage': receiptImage is String 
            ? await MultipartFile.fromFile(receiptImage)
            : receiptImage,
    };

    await api.post(
      EndPoints.updateBooking.replaceFirst('{id}', bookingId.toString()),
      data: data,
      isFormData: true,
    );
  }
}
