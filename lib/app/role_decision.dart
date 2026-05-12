import 'package:flutter/material.dart';
import 'package:voya/core/enums/role_enum.dart';

class RoleSelectionScreen extends StatefulWidget {
  final Function(UserRole) onSelect;

  const RoleSelectionScreen({super.key, required this.onSelect});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  UserRole? selectedRole;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F4F9),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 24),

              // Header
              const Text(
                "IDENTITY",
                style: TextStyle(
                  color: Color(0xFF0D32B3),
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2.0,
                ),
              ),
              const SizedBox(height: 16),

              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                    height: 1.2,
                  ),
                  children: [
                    TextSpan(
                      text: "Choose your\n",
                      style: TextStyle(color: Color(0xFF1E2432)),
                    ),
                    TextSpan(
                      text: "journey style.",
                      style: TextStyle(color: Color(0xFF0D32B3)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              const Text(
                "Select your primary role to customize\nyour experience and access specific\ntools.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF5A6B87),
                  fontSize: 14,
                  height: 1.5,
                  fontWeight: FontWeight.w500,
                ),
              ),

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: _buildRoleCard(
                        role: UserRole.driver,
                        icon: Icons.drive_eta,
                        title: "I am a Driver",
                        description:
                            "Join our fleet of professional architects of movement. Set your schedule and earn on your terms.",
                      ),
                    ),
                    const SizedBox(height: 12),
                    Flexible(
                      child: _buildRoleCard(
                        role: UserRole.passenger,
                        icon: Icons.location_on,
                        title: "I am a Passenger",
                        description:
                            "Experience premium transportation tailored to your needs. Fast, reliable, and exceptionally smooth.",
                      ),
                    ),
                  ],
                ),
              ),

              // Bottom Section
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  if (selectedRole != null) {
                    widget.onSelect(selectedRole!);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please select a role first"),
                      ),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Continue",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward, size: 20),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleCard({
    required UserRole role,
    required IconData icon,
    required String title,
    required String description,
  }) {
    final bool isSelected = selectedRole == role;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedRole = role;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? const Color(0xFF0D32B3) : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isSelected ? 0.08 : 0.04),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Color(0xFFEBF1FF),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: const Color(0xFF0D32B3), size: 24),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E2432),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF5A6B87),
                height: 1.5,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Text(
                  "Select this role",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: isSelected
                        ? const Color(0xFF0D32B3)
                        : const Color(0xFF0D32B3).withValues(alpha: 0.8),
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.arrow_forward,
                  size: 16,
                  color: isSelected
                      ? const Color(0xFF0D32B3)
                      : const Color(0xFF0D32B3).withValues(alpha: 0.8),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:voya/core/enums/role_enum.dart';
// import 'package:voya/features/driver_m/Theme/colors/app_colors.dart';
// import 'package:voya/features/driver_m/onboarding/presentation/widgets/onboarding_widgets.dart';

// class RoleSelectionScreen extends StatefulWidget {
//   final Function(UserRole) onSelect;

//   const RoleSelectionScreen({super.key, required this.onSelect});

//   @override
//   State<RoleSelectionScreen> createState() => _RoleSelectionPageState();
// }

// class _RoleSelectionPageState extends State<RoleSelectionScreen> {
//   UserRole? selectedRole;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ColorGradient(
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 24),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const ImageBus(),
//                 const SizedBox(height: 20),

//                 const Text(
//                   "Welcome to Voya",
//                   style: TextStyle(
//                     fontSize: 35,
//                     fontFamily: 'Lobster',
//                     fontWeight: FontWeight.bold,
//                     color: AppColors.white,
//                   ),
//                 ),

//                 const SizedBox(height: 10),

//                 const Text(
//                   "Choose your role to continue",
//                   style: TextStyle(color: AppColors.white),
//                 ),

//                 const SizedBox(height: 30),

//                 /// Passenger
//                 _buildRoleCard(
//                   role: UserRole.passenger,
//                   icon: Icons.people,
//                   title: "I’m a Passenger",
//                   subtitle: "Find and book rides",
//                   color: AppColors.iconBackground,
//                 ),

//                 const SizedBox(height: 25),

//                 /// Driver
//                 _buildRoleCard(
//                   role: UserRole.driver,
//                   icon: Icons.local_taxi,
//                   title: "I’m a Driver",
//                   subtitle: "Offer rides and earn",
//                   color: AppColors.primary,
//                 ),

//                 const SizedBox(height: 40),

//                 /// Continue Button
//                 ElevatedButton(
//                   onPressed: () {
//                     if (selectedRole != null) {
//                       widget.onSelect(selectedRole!);
//                     } else {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                           content: Text("Please select a role first"),
//                         ),
//                       );
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.white,
//                     foregroundColor: AppColors.primary,
//                     minimumSize: const Size(double.infinity, 55),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                   ),
//                   child: const Text(
//                     "Continue",
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildRoleCard({
//     required UserRole role,
//     required IconData icon,
//     required String title,
//     required String subtitle,
//     required Color color,
//   }) {
//     final bool isSelected = selectedRole == role;

//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           selectedRole = role;
//         });
//       },
//       child: Container(
//         padding: const EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           color: Colors.white.withValues(alpha: 0.1),
//           borderRadius: BorderRadius.circular(20),
//           border: Border.all(
//             color: isSelected ? Colors.white : Colors.transparent,
//             width: 2,
//           ),
//         ),
//         child: Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(color: color, shape: BoxShape.circle),
//               child: Icon(icon, color: Colors.white),
//             ),
//             const SizedBox(width: 20),

//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: const TextStyle(
//                     color: AppColors.white,
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text(subtitle, style: const TextStyle(color: AppColors.white)),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
