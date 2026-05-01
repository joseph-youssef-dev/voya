import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:voya/core/databases/api/dio_consumer.dart';
import 'package:voya/features/driver_m/home/data/api/trip_api_service.dart';
import 'package:voya/features/driver_m/home/logic/add_trip_cubit.dart';
import 'package:voya/features/driver_m/home/presentation/screens/trip_form.dart';

import 'package:voya/features/passenger/home/data/models/trip_model.dart';

class AddNewTripPage extends StatelessWidget {
  final TripModel? trip;
  const AddNewTripPage({super.key, this.trip});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) {
            final cubit = AddTripCubit(
              apiService: TripApiService(api: DioConsumer(dio: Dio())),
            );
            if (trip != null) {
              cubit.initForUpdate(trip!);
            }
            return cubit;
          },
      child: const TripForm(),
    );
  }
}
