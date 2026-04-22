import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voya/features/driver_m/home/date_trime_helper.dart';
import 'package:voya/features/driver_m/home/trip_input_home.dart';
import '../cubit/add_trip_cubit.dart';
import '../cubit/add_trip_state.dart';

class ScheduleRow extends StatelessWidget {
  final AddTripStateData state;

  const ScheduleRow({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddTripCubit>();

    return Row(
      children: [
        Expanded(
          child: TripInputField(
            controller: TextEditingController(text: state.date),
            label: "Date",
            hint: "DD/MM/YYYY",
            icon: Icons.calendar_today,
            isReadOnly: true,
            onTap: () async {
              final controller = TextEditingController(text: state.date);

              await DateTimeHelper.pickDate(
                context: context,
                controller: controller,
              );

              cubit.updateField(date: controller.text);
            },
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: TripInputField(
            controller: TextEditingController(text: state.time),
            label: "Time",
            hint: "00:00",
            icon: Icons.access_time,
            isReadOnly: true,
            onTap: () {
              final controller = TextEditingController(text: state.time);

              DateTimeHelper.pickTime(
                context: context,
                controller: controller,
                onPicked: () {
                  cubit.updateField(time: controller.text);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
