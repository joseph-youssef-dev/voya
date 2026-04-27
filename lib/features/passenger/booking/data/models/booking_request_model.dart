import 'dart:io';
import 'package:dio/dio.dart';

class BookingRequestModel {
  final int tripId;
  final int numberOfSeats;
  final File? receiptImage;

  BookingRequestModel({
    required this.tripId,
    required this.numberOfSeats,
    this.receiptImage,
  });

  Future<Map<String, dynamic>> toMap() async {
    return {
      'TripID': tripId,
      'NumberOfSeats': numberOfSeats,
      if (receiptImage != null)
        'PaymentImage': await MultipartFile.fromFile(receiptImage!.path),
    };
  }
}
