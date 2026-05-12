import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:voya/core/databases/api/dio_consumer.dart';
import 'package:voya/features/passenger/auth/presentation/widgets/auth_text_field.dart';
import 'package:voya/features/passenger/auth/presentation/widgets/profile_photo_uploader.dart';
import 'package:voya/features/driver/auth/presentation/screens/driver_login_screen.dart';
import 'package:voya/features/driver/auth/data/api/driver_register_api_service.dart';
import 'package:voya/features/driver/auth/logic/cubit/driver_register_cubit.dart';
import 'package:voya/features/driver/auth/logic/cubit/driver_register_state.dart';
import 'package:voya/features/shared_auth/presentation/screens/otp_screen.dart';

class DriverRegisterScreen extends StatefulWidget {
  const DriverRegisterScreen({super.key});

  @override
  State<DriverRegisterScreen> createState() => _DriverRegisterScreenState();
}

class _DriverRegisterScreenState extends State<DriverRegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  File? _profileImage;
  final List<File> _vehicleImages = [];
  final ImagePicker _picker = ImagePicker();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _ssnController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _townController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();

  // Vehicle info
  final TextEditingController _vehicleModelController = TextEditingController();
  final TextEditingController _vehicleColorController = TextEditingController();
  final TextEditingController _vehicleLicenseController =
      TextEditingController();
  final TextEditingController _numberOfPassengersController =
      TextEditingController();

  // License info
  final TextEditingController _licenseNumberController =
      TextEditingController();
  final TextEditingController _licenseExpiryDateController =
      TextEditingController();
  File? _licenseImage;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _ssnController.dispose();
    _phoneController.dispose();
    _townController.dispose();
    _birthDateController.dispose();
    _vehicleModelController.dispose();
    _vehicleColorController.dispose();
    _vehicleLicenseController.dispose();
    _licenseNumberController.dispose();
    _licenseExpiryDateController.dispose();
    _numberOfPassengersController.dispose();
    super.dispose();
  }

  Future<void> _pickVehicleImages() async {
    final List<XFile> images = await _picker.pickMultiImage();
    if (images.isNotEmpty) {
      setState(() {
        _vehicleImages.addAll(images.map((e) => File(e.path)));
      });
    }
  }

  Future<void> _pickLicenseImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _licenseImage = File(image.path);
      });
    }
  }

  Future<void> _selectDate(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 20)),
      firstDate: DateTime(1950),
      lastDate: DateTime.now().add(const Duration(days: 365 * 20)),
    );
    if (picked != null) {
      setState(() {
        controller.text =
            "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DriverRegisterCubit(
        apiService: DriverRegisterApiService(api: DioConsumer(dio: Dio())),
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFFEBEFF5),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          "Driver Registration",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF1E2432),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "Enter your details and vehicle information.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF5A6B87),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 30),

                        ProfilePhotoUploader(
                          onPhotoSelected: (file) {
                            setState(() {
                              _profileImage = file;
                            });
                          },
                        ),
                        const SizedBox(height: 40),

                        // Section Title: Personal Details
                        _buildSectionHeader("PERSONAL DETAILS"),
                        const SizedBox(height: 20),

                        AuthTextField(
                          label: "FIRST NAME",
                          hint: "John",
                          prefixIcon: Icons.person,
                          controller: _firstNameController,
                        ),
                        const SizedBox(height: 20),
                        AuthTextField(
                          label: "LAST NAME",
                          hint: "Doe",
                          prefixIcon: Icons.person_outline,
                          controller: _lastNameController,
                        ),
                        const SizedBox(height: 20),
                        AuthTextField(
                          label: "EMAIL ADDRESS",
                          hint: "driver@voya.com",
                          prefixIcon: Icons.email,
                          controller: _emailController,
                        ),
                        const SizedBox(height: 20),
                        AuthTextField(
                          label: "PASSWORD",
                          hint: "Enter your password",
                          prefixIcon: Icons.lock,
                          isPassword: true,
                          controller: _passwordController,
                        ),
                        const SizedBox(height: 20),
                        AuthTextField(
                          label: "NATIONAL ID (SSN)",
                          hint: "Enter 14-digit SSN",
                          prefixIcon: Icons.badge,
                          controller: _ssnController,
                        ),
                        const SizedBox(height: 20),
                        AuthTextField(
                          label: "PHONE NUMBER",
                          hint: "+201234567890",
                          prefixIcon: Icons.phone,
                          controller: _phoneController,
                        ),
                        const SizedBox(height: 20),
                        AuthTextField(
                          label: "TOWN",
                          hint: "Cairo, Egypt",
                          prefixIcon: Icons.location_city,
                          controller: _townController,
                        ),
                        const SizedBox(height: 20),
                        AuthTextField(
                          label: "BIRTH DATE",
                          hint: "YYYY-MM-DD",
                          prefixIcon: Icons.cake,
                          controller: _birthDateController,
                          readOnly: true,
                          onTap: () =>
                              _selectDate(context, _birthDateController),
                        ),
                        const SizedBox(height: 40),

                        // Section Title: License Details
                        _buildSectionHeader("LICENSE DETAILS"),
                        const SizedBox(height: 20),

                        AuthTextField(
                          label: "LICENSE NUMBER",
                          hint: "Enter license number",
                          prefixIcon: Icons.credit_card,
                          controller: _licenseNumberController,
                        ),
                        const SizedBox(height: 20),
                        AuthTextField(
                          label: "EXPIRY DATE",
                          hint: "YYYY-MM-DD",
                          prefixIcon: Icons.event,
                          controller: _licenseExpiryDateController,
                          readOnly: true,
                          onTap: () => _selectDate(
                            context,
                            _licenseExpiryDateController,
                          ),
                        ),
                        const SizedBox(height: 20),

                        const Text(
                          "LICENSE IMAGE",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF5A6B87),
                            letterSpacing: 1.0,
                          ),
                        ),
                        const SizedBox(height: 12),
                        GestureDetector(
                          onTap: _pickLicenseImage,
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF1F4F9),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: const Color(0xFFAAB8D2),
                              ),
                            ),
                            child: _licenseImage != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.file(
                                      _licenseImage!,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : const Icon(
                                    Icons.add_a_photo,
                                    color: Color(0xFF0D32B3),
                                    size: 40,
                                  ),
                          ),
                        ),
                        const SizedBox(height: 40),

                        // Section Title: Vehicle Details
                        _buildSectionHeader("VEHICLE DETAILS"),
                        const SizedBox(height: 20),

                        AuthTextField(
                          label: "VEHICLE MODEL",
                          hint: "Toyota Hiace 2023",
                          prefixIcon: Icons.directions_bus,
                          controller: _vehicleModelController,
                        ),
                        const SizedBox(height: 20),
                        AuthTextField(
                          label: "VEHICLE COLOR",
                          hint: "White",
                          prefixIcon: Icons.color_lens,
                          controller: _vehicleColorController,
                        ),
                        const SizedBox(height: 20),
                        AuthTextField(
                          label: "VEHICLE LICENSE",
                          hint: "Enter vehicle plate number",
                          prefixIcon: Icons.pin,
                          controller: _vehicleLicenseController,
                        ),
                        const SizedBox(height: 20),
                        AuthTextField(
                          label: "NUMBER OF PASSENGERS",
                          hint: "14",
                          prefixIcon: Icons.groups,
                          controller: _numberOfPassengersController,
                        ),
                        const SizedBox(height: 30),

                        // Vehicle Images Section
                        const Text(
                          "VEHICLE IMAGES",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF5A6B87),
                            letterSpacing: 1.0,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            ..._vehicleImages.map(
                              (file) => Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.file(
                                      file,
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _vehicleImages.remove(file);
                                        });
                                      },
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: _pickVehicleImages,
                              child: Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF1F4F9),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: const Color(0xFFAAB8D2),
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.add_photo_alternate,
                                  color: Color(0xFF0D32B3),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),

                        // Sign Up Button
                        BlocConsumer<DriverRegisterCubit, DriverRegisterState>(
                          listener: (context, state) {
                            if (state is DriverRegisterSuccess) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(state.message),
                                  backgroundColor: Colors.green,
                                ),
                              );
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OtpScreen(
                                    email: _emailController.text.trim(),
                                    nextScreen: const DriverLoginScreen(),
                                  ),
                                ),
                              );
                            } else if (state is DriverRegisterFailure) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(state.errorMessage),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                          builder: (context, state) {
                            return ElevatedButton(
                              onPressed: state is DriverRegisterLoading
                                  ? null
                                  : () {
                                      if (_formKey.currentState!.validate()) {
                                        context
                                            .read<DriverRegisterCubit>()
                                            .registerDriver(
                                              ssn: _ssnController.text.trim(),
                                              email: _emailController.text
                                                  .trim(),
                                              password:
                                                  _passwordController.text,
                                              firstName: _firstNameController
                                                  .text
                                                  .trim(),
                                              lastName: _lastNameController.text
                                                  .trim(),
                                              profileImage: _profileImage,
                                              phone: _phoneController.text
                                                  .trim(),
                                              town: _townController.text.trim(),
                                              birthDate: _birthDateController
                                                  .text
                                                  .trim(),
                                              vehicleModel:
                                                  _vehicleModelController.text
                                                      .trim(),
                                              vehicleColor:
                                                  _vehicleColorController.text
                                                      .trim(),
                                              vehicleLicense:
                                                  _vehicleLicenseController.text
                                                      .trim(),
                                              numberOfPassengers:
                                                  int.tryParse(
                                                    _numberOfPassengersController
                                                        .text
                                                        .trim(),
                                                  ) ??
                                                  0,
                                              vehicleImages: _vehicleImages,
                                              licenseNumber:
                                                  _licenseNumberController.text
                                                      .trim(),
                                              licenseExpiryDate:
                                                  _licenseExpiryDateController
                                                      .text
                                                      .trim(),
                                              licenseImage: _licenseImage,
                                            );
                                      }
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF0D32B3),
                                foregroundColor: Colors.white,
                                minimumSize: const Size(double.infinity, 56),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                elevation: 0,
                              ),
                              child: state is DriverRegisterLoading
                                  ? const SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2.5,
                                      ),
                                    )
                                  : const Text(
                                      "Register Now",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                            );
                          },
                        ),

                        const SizedBox(height: 30),

                        Center(
                          child: RichText(
                            text: TextSpan(
                              text: "Already have a driver account? ",
                              style: const TextStyle(
                                color: Color(0xFF5A6B87),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              children: [
                                TextSpan(
                                  text: "Log In",
                                  style: const TextStyle(
                                    color: Color(0xFF0D32B3),
                                    fontWeight: FontWeight.w800,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const DriverLoginScreen(),
                                        ),
                                      );
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w900,
            color: Color(0xFF1E2432),
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(width: 12),
        const Expanded(child: Divider(color: Color(0xFFEBEFF5), thickness: 2)),
      ],
    );
  }
}
