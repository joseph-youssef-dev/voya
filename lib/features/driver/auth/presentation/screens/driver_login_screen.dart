import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:voya/core/databases/api/dio_consumer.dart';
import 'package:voya/features/passenger/auth/presentation/widgets/auth_text_field.dart';
import 'package:voya/features/driver/auth/presentation/screens/driver_register_screen.dart';
import 'package:voya/features/driver/auth/data/api/driver_login_api_service.dart';
import 'package:voya/features/driver/auth/logic/cubit/driver_login_cubit.dart';
import 'package:voya/features/driver/auth/logic/cubit/driver_login_state.dart';
import 'package:voya/features/driver/home/presentation/screens/bottom_nav.dart';

class DriverLoginScreen extends StatefulWidget {
  const DriverLoginScreen({super.key});

  @override
  State<DriverLoginScreen> createState() => _DriverLoginScreenState();
}

class _DriverLoginScreenState extends State<DriverLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DriverLoginCubit(
        apiService: DriverLoginApiService(api: DioConsumer(dio: Dio())),
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
                          "Driver Portal",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF1E2432),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "Sign in to start your trip today.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF5A6B87),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 40),

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
                        // TODO: Uncomment when forget password is ready
                        // Align(
                        //   alignment: Alignment.centerRight,
                        //   child: TextButton(
                        //     onPressed: () {
                        //       Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //           builder: (context) => const ForgetPasswordScreen(
                        //             nextScreenAfterReset: DriverLoginScreen(),
                        //           ),
                        //         ),
                        //       );
                        //     },
                        //     child: const Text(
                        //       "Forget Password?",
                        //       style: TextStyle(
                        //         color: Color(0xFF0D32B3),
                        //         fontWeight: FontWeight.w700,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        const SizedBox(height: 10),
                        BlocConsumer<DriverLoginCubit, DriverLoginState>(
                          listener: (context, state) {
                            if (state is DriverLoginSuccess) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(state.message),
                                  backgroundColor: Colors.green,
                                ),
                              );
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const CustomBottomNavBar(),
                                ),
                                (route) => false,
                              );
                            } else if (state is DriverLoginFailure) {
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
                              onPressed: state is DriverLoginLoading
                                  ? null
                                  : () {
                                      if (_formKey.currentState!.validate()) {
                                        context
                                            .read<DriverLoginCubit>()
                                            .loginDriver(
                                              email: _emailController.text
                                                  .trim(),
                                              password:
                                                  _passwordController.text,
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
                              child: state is DriverLoginLoading
                                  ? const SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2.5,
                                      ),
                                    )
                                  : const Text(
                                      "Log In",
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
                              text: "Don't have a driver account? ",
                              style: const TextStyle(
                                color: Color(0xFF5A6B87),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              children: [
                                TextSpan(
                                  text: "Join Us",
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
                                              const DriverRegisterScreen(),
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
