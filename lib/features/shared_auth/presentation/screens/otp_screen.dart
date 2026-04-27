import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voya/core/databases/api/dio_consumer.dart';
import 'package:voya/features/shared_auth/data/api/shared_auth_api_service.dart';
import 'package:voya/features/shared_auth/logic/cubit/shared_auth_cubit.dart';
import 'package:voya/features/shared_auth/logic/cubit/shared_auth_state.dart';

class OtpScreen extends StatefulWidget {
  final String email;
  final Widget nextScreen;

  const OtpScreen({super.key, required this.email, required this.nextScreen});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SharedAuthCubit(apiService: SharedAuthApiService(api: DioConsumer(dio: Dio()))),
      child: Scaffold(
        backgroundColor: const Color(0xFFEBEFF5),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: const BackButton(color: Color(0xFF1E2432)),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                          "Verify Account",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF1E2432),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Enter the OTP sent to ${widget.email}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF5A6B87),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 40),
                        
                        TextFormField(
                          controller: _otpController,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Please enter OTP";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: "OTP",
                            labelStyle: const TextStyle(
                              color: Color(0xFF5A6B87),
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                            prefixIcon: const Icon(Icons.security, color: Color(0xFF5A6B87), size: 20),
                            filled: true,
                            fillColor: const Color(0xFFF6F8FE),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        
                        BlocConsumer<SharedAuthCubit, SharedAuthState>(
                          listener: (context, state) {
                            if (state is SharedAuthSuccess) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(state.message), backgroundColor: Colors.green),
                              );
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => widget.nextScreen),
                              );
                            } else if (state is SharedAuthFailure) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(state.errorMessage), backgroundColor: Colors.red),
                              );
                            }
                          },
                          builder: (context, state) {
                            return ElevatedButton(
                              onPressed: state is SharedAuthLoading
                                  ? null
                                  : () {
                                      if (_formKey.currentState!.validate()) {
                                        context.read<SharedAuthCubit>().verifyOtp(
                                          email: widget.email,
                                          otp: _otpController.text.trim(),
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
                              child: state is SharedAuthLoading
                                  ? const SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
                                    )
                                  : const Text(
                                      "Verify OTP",
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
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
      ),
    );
  }
}
