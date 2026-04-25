import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:voya/features/driver_m/home/presentation/screens/bottom_nav.dart';

class AddCar extends StatefulWidget {
  const AddCar({super.key});

  @override
  State<AddCar> createState() => _AddCarState();
}

class _AddCarState extends State<AddCar> {
  final TextEditingController nameController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  File? _image;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildTextField("Car Name and Model", nameController),
                    _buildTextField("Car License", null),
                    _buildTextField("Car License Plate", null),

                    Row(
                      children: [
                        Expanded(child: _buildTextField("Color", null)),
                        const SizedBox(width: 10),
                        Expanded(child: _buildTextField("Seats", null)),
                      ],
                    ),

                    const SizedBox(height: 20),

                    _buildAmenitiesSection(),

                    const SizedBox(height: 20),

                    _buildImageUploadSection(),

                    const SizedBox(height: 20),

                    _buildTextField("Notes", null),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CustomBottomNavBar(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        child: const Text(
                          "Add",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),

                    // 👇 المسافة اللي تحت الزرار
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, TextEditingController? controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildAmenitiesSection() {
    final amenities = [
      "WIFI",
      "Aircondition",
      "TV",
      "USB charger",
      "Music",
      "Adjustable seats",
      "Restroom",
      "Sunroof",
      "GPS",
      "Heated seats",
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Amenities",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: amenities.map((a) => Chip(label: Text(a))).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildImageUploadSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          _image != null
              ? Image.file(_image!, height: 150)
              : const Icon(Icons.cloud_upload, size: 50, color: Colors.blue),

          const SizedBox(height: 10),

          const Text("Drop file here OR"),

          const SizedBox(height: 10),

          ElevatedButton(
            onPressed: _pickImage,
            child: const Text("Upload Image"),
          ),
        ],
      ),
    );
  }
}
