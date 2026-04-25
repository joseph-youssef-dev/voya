import 'package:flutter/material.dart';

import 'package:voya/features/driver_m/Theme/colors/app_colors.dart';
import 'package:voya/features/driver_m/auth/presentation/widgets/login_widgets.dart';
import 'package:voya/features/driver_m/auth/presentation/screens/driver_register_screen.dart';

class DesignLoginDriver extends StatelessWidget {
  const DesignLoginDriver({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),

      body: AuthBackground(
        child: ListView(
          children: [
            const AddImage(),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Let's Get Started",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Create an account",
                  style: TextStyle(color: AppColors.textSecondary),
                ),

                const SizedBox(height: 20),

                AppTextField(
                  icon: Icons.person,
                  hintText: "Enter your full name",
                  text: '',
                ),

                AppTextField(
                  icon: Icons.email,
                  hintText: "Enter your email",
                  text: '',
                ),
                const BirthDateField(),

                AppTextField(
                  icon: Icons.badge,
                  hintText: "National ID number",
                  text: '',
                ),

                AppTextField(
                  icon: Icons.phone,
                  hintText: "Enter your number",
                  text: '',
                ),
                const SizedBox(height: 10),
                AppTextField(
                  icon: Icons.location_city,
                  hintText: "City",
                  text: '',
                ),

                const SizedBox(height: 10),

                const Password(
                  icon: Icons.lock,
                  hintText: "Password",
                  isPassword: true,
                ),
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    "Data Car",
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                AppTextField(
                  icon: Icons.confirmation_number,
                  hintText: "Driver's license",
                  text: '',
                ),
                AppTextField(
                  icon: Icons.badge,
                  hintText: 'License number',
                  text: '',
                ),

                AppTextField(
                  icon: Icons.confirmation_number,
                  hintText: 'Car license plate',
                  text: '',
                ),
                AppTextField(
                  icon: Icons.credit_card,
                  hintText: "car license",
                  text: "",
                ),

                AppTextField(
                  icon: Icons.directions_car,
                  hintText: 'Car type',
                  text: '',
                ),
                AppTextField(
                  icon: Icons.directions_car,
                  hintText: "Car model ",
                  text: '',
                ),

                AppTextField(
                  icon: Icons.color_lens,
                  hintText: "Color Car",
                  text: '',
                ),
                AppTextField(
                  icon: Icons.event_seat,
                  hintText: "Number of chairs",
                  text: '',
                ),
                const SizedBox(height: 30),

                CarImageUploader(),
                const SizedBox(height: 30),

                SignInUp(
                  text: "Sign Up",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterDriver(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
