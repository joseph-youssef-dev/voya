import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:voya/features/driver/profile_driver/presentation/screens/add_car.dart';
import 'package:voya/features/driver/profile_driver/presentation/screens/car_info_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
    return Container(
      color: Colors.grey[50],
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const SizedBox(height: 20),

          // صورة البروفايل
          Stack(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: _image != null ? FileImage(_image!) : null,
                child: _image == null
                    ? const Icon(Icons.person, size: 50)
                    : null,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: _pickImage,
                  child: const CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.camera_alt, size: 18),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          const Text(
            "Thomas Anderson",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          // Contact Info
          _buildCard("Contact Information", [
            _buildRow(
              Icons.email_outlined,
              "Email",
              "thomas.anderson@gmail.com",
            ),
            _buildRow(Icons.phone, "Phone", "01207201864"),
          ]),

          // Personal Info
          _buildCard("Personal Info", [
            _buildRow(Icons.lock_outline, "Password", "***************"),
            _buildRow(Icons.badge_outlined, "ID", "30***********6"),
          ]),

          // Vehicles
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Vehicles information"),

                PopupMenuButton<String>(
                  icon: const Icon(Icons.keyboard_arrow_down),
                  onSelected: (value) {
                    if (value == "info") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CarDetailsPage(),
                        ),
                      );
                    } else if (value == "add") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddCar()),
                      );
                    }
                  },
                  itemBuilder: (context) => const [
                    PopupMenuItem(
                      value: "info",
                      child: Text("information Car"),
                    ),
                    PopupMenuItem(value: "add", child: Text("+ Add new car")),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // Logout
          TextButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, '/choicewho');
            },
            icon: const Icon(Icons.logout, color: Colors.red),
            label: const Text(
              "Logout",
              style: TextStyle(color: Colors.red, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(String title, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              const Row(
                children: [
                  Icon(Icons.delete, size: 18, color: Colors.pink),
                  SizedBox(width: 10),
                  Icon(Icons.edit, size: 18, color: Colors.blue),
                ],
              ),
            ],
          ),
          const Divider(),
          ...children,
        ],
      ),
    );
  }

  Widget _buildRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 12)),
              Text(value),
            ],
          ),
        ],
      ),
    );
  }
}
