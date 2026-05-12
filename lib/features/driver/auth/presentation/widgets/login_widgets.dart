import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:voya/features/driver/Theme/colors/app_colors.dart';

// --- from add_image.dart ---

class AddImage extends StatefulWidget {
  const AddImage({super.key});
  @override
  State<AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: pickImage,
        child: CircleAvatar(
          radius: 50,
          backgroundColor: Colors.grey[300],
          backgroundImage: _image != null ? FileImage(_image!) : null,
          child: _image == null
              ? Icon(Icons.camera_alt, size: 30, color: Colors.grey[700])
              : null,
        ),
      ),
    );
  }
}

// --- from add_image_car.dart ---

class CarImageUploader extends StatefulWidget {
  const CarImageUploader({super.key});

  @override
  State<CarImageUploader> createState() => _CarImageUploaderState();
}

class _CarImageUploaderState extends State<CarImageUploader> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          " Image of your car",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          child: _image == null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.cloud_upload,
                      size: 50,
                      color: Colors.blue,
                    ),
                    const Text("Drag file here"),
                    const Text("OR"),
                    ElevatedButton(
                      onPressed: _pickImage,
                      child: const Text("Upload image"),
                    ),
                  ],
                )
              : Image.file(_image!, fit: BoxFit.cover),
        ),
      ],
    );
  }
}

// --- from auth_background.dart ---

class AuthBackground extends StatelessWidget {
  final Widget child;

  const AuthBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(height: 120, color: AppColors.primary),

        Transform.translate(
          offset: const Offset(0, 60),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: AppColors.backgroundSoft,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: child,
          ),
        ),
      ],
    );
  }
}

// --- from container_design_login.dart ---

class AppTextField extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final String text;

  const AppTextField({
    super.key,
    required this.icon,
    required this.hintText,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      margin: const EdgeInsets.symmetric(vertical: 8),

      decoration: BoxDecoration(
        color: AppColors.backgroundSoft,
        border: Border.all(color: AppColors.primary, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),

      child: Row(
        children: [
          Icon(icon, color: AppColors.primary),
          const SizedBox(width: 10),

          Expanded(
            child: TextField(
              style: const TextStyle(color: AppColors.textPrimary),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: const TextStyle(color: AppColors.textSecondary),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- from custom_app_bar.dart ---

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showBack;

  const CustomAppBar({super.key, this.title, this.showBack = true});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      elevation: 0,
      centerTitle: true,

      leading: showBack
          ? IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            )
          : null,

      title: title != null
          ? Text(
              title!,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// --- from date_of_Birth.dart ---
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

// --- from password.dart ---

class Password extends StatefulWidget {
  final IconData icon;
  final String hintText;
  final bool isPassword;

  const Password({
    super.key,
    required this.icon,
    required this.hintText,
    this.isPassword = false,
  });

  @override
  State<Password> createState() => _ContainerDesignLoginState();
}

class _ContainerDesignLoginState extends State<Password> {
  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.symmetric(vertical: 8),

      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        border: Border.all(color: Color(0xFF002D6E), width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),

      child: Row(
        children: [
          Icon(widget.icon, color: Color(0xFF002D6E)),

          SizedBox(width: 10),

          Expanded(
            child: TextField(
              obscureText: widget.isPassword ? isHidden : false,

              decoration: InputDecoration(
                hintText: widget.hintText,
                border: InputBorder.none,
              ),
            ),
          ),

          //  العين
          if (widget.isPassword)
            IconButton(
              icon: Icon(isHidden ? Icons.visibility_off : Icons.visibility),
              onPressed: () {
                setState(() {
                  isHidden = !isHidden;
                });
              },
            ),
        ],
      ),
    );
  }
}

// --- from sign_in_up.dart ---

class SignInUp extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const SignInUp({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 50,
          width: 150,
          decoration: BoxDecoration(
            color: Color(0xFF002D6E),
            border: Border.all(color: Color(0xFF002D6E), width: 1.5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              // "Sign Up",
              text,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      //),
    );
  }
}
