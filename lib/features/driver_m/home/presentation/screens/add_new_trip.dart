import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voya/features/driver_m/home/logic/add_trip_cubit.dart';
import 'package:voya/features/driver_m/home/presentation/screens/trip_form.dart';

class AddNewTripPage extends StatelessWidget {
  const AddNewTripPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => AddTripCubit(), child: const TripForm());
  }
}
