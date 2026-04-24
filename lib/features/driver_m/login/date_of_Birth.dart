// import 'package:flutter/material.dart';

// class BirthDateField extends StatefulWidget {
//   const BirthDateField({super.key});

//   @override
//   State<BirthDateField> createState() => _BirthDateFieldState();
// }

// class _BirthDateFieldState extends State<BirthDateField> {
//   DateTime? selectedDate;

//   Future<void> pickDate() async {
//     DateTime now = DateTime.now();

//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime(now.year - 18), // يبدأ من سن 18
//       firstDate: DateTime(1900),
//       lastDate: now,
//     );

//     if (picked != null) {
//       setState(() {
//         selectedDate = picked;
//       });
//     }
//   }

//   String formatDate(DateTime date) {
//     return "${date.day}/${date.month}/${date.year}";
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: pickDate,
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
//         decoration: BoxDecoration(
//           border: Border.all(color: Colors.grey),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Text(
//           selectedDate == null
//               ? "Date of Birth"
//               : formatDate(selectedDate!),
//           style: TextStyle(
//             color: selectedDate == null ? Colors.grey : Colors.black,
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:voya/features/driver_m/Theme/colors/app_colors.dart';

class BirthDateField extends StatefulWidget {
  const BirthDateField({super.key});

  @override
  State<BirthDateField> createState() => _BirthDateFieldState();
}

class _BirthDateFieldState extends State<BirthDateField> {
  DateTime? selectedDate;

  Future<void> pickDate() async {
    DateTime now = DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year - 18),
      firstDate: DateTime(1900),
      lastDate: now,
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  String formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: pickDate,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        margin: const EdgeInsets.symmetric(vertical: 8),

        decoration: BoxDecoration(
          color: AppColors.backgroundSoft,
          border: Border.all(color: AppColors.primary, width: 1.5),
          borderRadius: BorderRadius.circular(12),
        ),

        child: Row(
          children: [
            Icon(Icons.calendar_today, color: AppColors.primary),
            const SizedBox(width: 10),

            Expanded(
              child: Text(
                selectedDate == null
                    ? "Date of Birth"
                    : formatDate(selectedDate!),
                style: TextStyle(
                  color: selectedDate == null
                      ? AppColors.textSecondary
                      : AppColors.textPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
