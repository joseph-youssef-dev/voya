import '../../logic/add_trip_cubit.dart';
import '../../logic/add_trip_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voya/features/driver_m/Theme/colors/app_colors.dart';
import 'package:voya/features/driver_m/home/presentation/widgets/home_widgets.dart';

// --- from seat_selector.dart ---

class SeatSelector extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const SeatSelector({
    super.key,
    required this.controller,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Available Seats",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: onDecrement,
                child: const Icon(
                  Icons.remove_circle_outline,
                  color: Color(0xFF002D72),
                ),
              ),
              SizedBox(
                width: 50,
                child: TextField(
                  controller: controller,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(border: InputBorder.none),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              GestureDetector(
                onTap: onIncrement,
                child: const Icon(
                  Icons.add_circle_outline,
                  color: Color(0xFF002D72),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// --- from trip_header.dart ---

class TripHeader extends StatelessWidget {
  const TripHeader({super.key, required String text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF002D72), Color(0xFF0D47A1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "Add New Trip",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Create a trip & connect with passengers",
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

// --- from trip_input_home.dart ---

class TripInputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final bool isReadOnly;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final TextInputType keyboardType;
  final int maxLines;

  const TripInputField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    this.isReadOnly = false,
    this.onTap,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          readOnly: isReadOnly,
          onTap: onTap,
          onChanged: onChanged,
          keyboardType: keyboardType,
          maxLines: maxLines,
          style: const TextStyle(fontSize: 14),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey[400], fontSize: 13),
            prefixIcon: Icon(icon, color: const Color(0xFF002D72), size: 20),
            filled: true,
            fillColor: Colors.grey[100],
            contentPadding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 10,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: Color(0xFF002D72),
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// --- from schedule_row.dart ---

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

// --- from trip_section_title.dart ---

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
      ),
    );
  }
}
