import 'package:flutter/material.dart';

class DateTimeHelper {
  static Future<void> pickDate({
    required BuildContext context,
    required TextEditingController controller,
  }) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      controller.text = "${picked.day}/${picked.month}/${picked.year}";
    }
  }

  /// ⏰ TIME PICKER
  static Future<void> pickTime({
    required BuildContext context,
    required TextEditingController controller,
    required Null Function() onPicked,
  }) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      final hour = picked.hourOfPeriod == 0 ? 12 : picked.hourOfPeriod;
      final minute = picked.minute.toString().padLeft(2, '0');
      final period = picked.period == DayPeriod.am ? "AM" : "PM";

      controller.text = "$hour:$minute $period";
    }
  }
}
