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
              const SizedBox(height: 40),

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
                    fontSize: 32,
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
                  fontSize: 16,
                  height: 1.5,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 40),

              // Cards
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildRoleCard(
                        role: UserRole.driver,
                        icon: Icons.drive_eta,
                        title: "I am a Driver",
                        description:
                            "Join our fleet of professional architects of movement. Set your schedule and earn on your terms.",
                      ),
                      const SizedBox(height: 20),
                      _buildRoleCard(
                        role: UserRole.passenger,
                        icon: Icons.location_on,
                        title: "I am a Passenger",
                        description:
                            "Experience premium transportation tailored to your needs. Fast, reliable, and exceptionally smooth.",
                      ),
                    ],
                  ),
                ),
              ),

              // Bottom Section
              const SizedBox(height: 20),
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
              const SizedBox(height: 50),
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
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? const Color(0xFF0D32B3) : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isSelected ? 0.08 : 0.04),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Color(0xFFEBF1FF),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: const Color(0xFF0D32B3), size: 28),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E2432),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF5A6B87),
                height: 1.5,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Text(
                  "Select this role",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isSelected
                        ? const Color(0xFF0D32B3)
                        : const Color(0xFF0D32B3).withOpacity(0.8),
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.arrow_forward,
                  size: 16,
                  color: isSelected
                      ? const Color(0xFF0D32B3)
                      : const Color(0xFF0D32B3).withOpacity(0.8),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
