import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:voya/core/databases/api/dio_consumer.dart';
import 'package:voya/features/passenger/auth/presentation/widgets/auth_text_field.dart';
import 'package:voya/features/passenger/auth/presentation/widgets/profile_photo_uploader.dart';
import 'package:voya/features/passenger/auth/presentation/screens/passenger_login_screen.dart';
import 'package:voya/features/passenger/auth/data/api/register_api_service.dart';
import 'package:voya/features/passenger/auth/logic/cubit/register_cubit.dart';
import 'package:voya/features/passenger/auth/logic/cubit/register_state.dart';

class PassengerRegisterScreen extends StatefulWidget {
  const PassengerRegisterScreen({super.key});

  @override
  State<PassengerRegisterScreen> createState() => _PassengerRegisterScreenState();
}

class _PassengerRegisterScreenState extends State<PassengerRegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  File? _profileImage;
  
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _ssnController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _townController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _ssnController.dispose();
    _birthDateController.dispose();
    _phoneController.dispose();
    _townController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(apiService: RegisterApiService(api: DioConsumer(dio: Dio()))),
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
                        "Create Account",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF1E2432),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Join the elite network of travelers today.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF5A6B87),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 30),
                      
                      // Upload Photo Widget
                      ProfilePhotoUploader(
                        onPhotoSelected: (file) {
                          setState(() {
                            _profileImage = file;
                          });
                        },
                      ),
                      const SizedBox(height: 40),
                      
                      // Fields
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
                        hint: "john@architect.com",
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
                        hint: "Enter ID Number",
                        prefixIcon: Icons.badge,
                        controller: _ssnController,
                      ),
                      const SizedBox(height: 20),
                      AuthTextField(
                        label: "BIRTH DATE",
                        hint: "YYYY-MM-DD",
                        prefixIcon: Icons.calendar_today,
                        controller: _birthDateController,
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime(2000),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: const ColorScheme.light(
                                    primary: Color(0xFF0D32B3),
                                    onPrimary: Colors.white,
                                    onSurface: Colors.black,
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );

                          if (pickedDate != null) {
                            String formattedDate = 
                                "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                            setState(() {
                              _birthDateController.text = formattedDate;
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      AuthTextField(
                        label: "PHONE NUMBER",
                        hint: "+123456789",
                        prefixIcon: Icons.phone,
                        controller: _phoneController,
                      ),
                      const SizedBox(height: 20),
                      AuthTextField(
                        label: "TOWN",
                        hint: "Enter your town",
                        prefixIcon: Icons.location_city,
                        controller: _townController,
                      ),
                      const SizedBox(height: 30),
                      
                      // Sign Up Button
                      BlocConsumer<RegisterCubit, RegisterState>(
                        listener: (context, state) {
                          if (state is RegisterSuccess) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.message), backgroundColor: Colors.green),
                            );
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PassengerLoginScreen(),
                              ),
                            );
                          } else if (state is RegisterFailure) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.errorMessage), backgroundColor: Colors.red),
                            );
                          }
                        },
                        builder: (context, state) {
                          return ElevatedButton(
                            onPressed: state is RegisterLoading
                                ? null
                                : () {
                                    if (_formKey.currentState!.validate()) {
                                      context.read<RegisterCubit>().registerUser(
                                        ssn: _ssnController.text.trim(),
                                        email: _emailController.text.trim(),
                                        password: _passwordController.text,
                                        firstName: _firstNameController.text.trim(),
                                        lastName: _lastNameController.text.trim(),
                                        profileImage: _profileImage,
                                        birthDate: _birthDateController.text.trim(),
                                        phone: _phoneController.text.trim(),
                                        town: _townController.text.trim(),
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
                            child: state is RegisterLoading
                                ? const SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2.5,
                                    ),
                                  )
                                : const Text(
                                    "Sign Up",
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
                            text: "Already have an account? ",
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
                                        builder: (context) => const PassengerLoginScreen(),
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
}
