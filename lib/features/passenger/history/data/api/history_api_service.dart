import 'package:voya/core/databases/api/api_consumer.dart';
import 'package:voya/core/constants/end_points.dart';
import '../models/my_trip_model.dart';

class HistoryApiService {
  final ApiConsumer api;

  HistoryApiService({required this.api});

  Future<List<MyTripModel>> getMyTrips() async {
    final response = await api.get(EndPoints.getMyTrips);
    return _parseTripsFromResponse(response);
  }

  List<MyTripModel> _parseTripsFromResponse(dynamic response) {
    if (response is Map<String, dynamic> && response.containsKey('data')) {
      final data = response['data'];
      final List<MyTripModel> allTrips = [];

      if (data is Map<String, dynamic>) {
        final List waiting = data['waitingTrips'] ?? [];
        final List accepted = data['acceptedTrips'] ?? [];
        final List rejected = data['rejectedTrips'] ?? [];
        
        allTrips.addAll(waiting.map((t) => MyTripModel.fromJson({...t, 'status': 'pending'})));
        allTrips.addAll(accepted.map((t) => MyTripModel.fromJson({...t, 'status': 'successful'})));
        allTrips.addAll(rejected.map((t) => MyTripModel.fromJson({...t, 'status': 'rejected'})));
      } else if (data is List) {
        allTrips.addAll(data.map((t) => MyTripModel.fromJson(t)));
      }
      
      return allTrips;
    }

    return [];
  }

}
