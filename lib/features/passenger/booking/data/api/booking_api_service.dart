import 'package:voya/core/databases/api/api_consumer.dart';
import 'package:voya/core/constants/end_points.dart';
import '../models/booking_request_model.dart';

class BookingApiService {
  final ApiConsumer api;

  BookingApiService({required this.api});

  Future<dynamic> createBooking(BookingRequestModel request) async {
    final response = await api.post(
      EndPoints.createBooking,
      data: await request.toMap(),
      isFormData: true,
    );
    return response;
  }
}
