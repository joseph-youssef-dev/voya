import 'package:voya/core/databases/api/api_consumer.dart';
import 'package:voya/core/constants/end_points.dart';
import '../models/my_trip_model.dart';

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
        final all = [...waiting, ...accepted];
        return all.map((t) => MyTripModel.fromJson(t)).toList();
      }
    }

    return [];
  }
}
