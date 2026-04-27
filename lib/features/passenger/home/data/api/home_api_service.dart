import 'package:voya/core/databases/api/api_consumer.dart';
import 'package:voya/core/constants/end_points.dart';
import '../models/trip_model.dart';

class HomeApiService {
  final ApiConsumer api;

  HomeApiService({required this.api});

  Future<List<TripModel>> getAllTrips({String? from, String? to}) async {
    final Map<String, dynamic> queryParameters = {};
    if (from != null && from.isNotEmpty) queryParameters['From'] = from;
    if (to != null && to.isNotEmpty) queryParameters['To'] = to;

    final response = await api.get(
      EndPoints.getAllTrips,
      queryParameters: queryParameters.isNotEmpty ? queryParameters : null,
    );
    
    if (response is Map<String, dynamic> && response.containsKey('data')) {
      final List dataList = response['data'] as List;
      return dataList.map((tripMap) => TripModel.fromJson(tripMap)).toList();
    }
    
    return [];
  }
}
