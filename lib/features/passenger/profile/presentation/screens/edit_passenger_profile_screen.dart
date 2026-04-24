import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:voya/core/shared/custom_header.dart';
import 'package:voya/features/passenger/profile/data/models/passenger_profile_model.dart';
import 'package:voya/features/passenger/profile/logic/cubit/profile_cubit.dart';
import 'package:voya/features/passenger/profile/logic/cubit/profile_state.dart';
import 'package:flutter/foundation.dart';

class EditPassengerProfileScreen extends StatefulWidget {
  final PassengerProfileModel profile;
  final ProfileCubit cubit;

  const EditPassengerProfileScreen({
    super.key,
    required this.profile,
    required this.cubit,
  });

  @override
  State<EditPassengerProfileScreen> createState() =>
      _EditPassengerProfileScreenState();
}

class _EditPassengerProfileScreenState extends State<EditPassengerProfileScreen> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _birthDateController;
  late TextEditingController _phoneController;
  late TextEditingController _townController;

  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.profile.firstName);
    _lastNameController = TextEditingController(text: widget.profile.lastName);
    _birthDateController = TextEditingController(text: widget.profile.birthDate);
    _phoneController = TextEditingController(text: widget.profile.phone);
    _townController = TextEditingController(text: widget.profile.town);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _birthDateController.dispose();
    _phoneController.dispose();
    _townController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.cubit,
      child: Scaffold(
        backgroundColor: const Color(0xFFF9FAFF),
        body: SafeArea(
          child: Column(
            children: [
              const CustomHeader(title: 'Edit Profile'),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: _pickImage,
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey[200],
                                border: Border.all(
                                  color: const Color(0xFF0D32B3),
                                  width: 2,
                                ),
                              ),
                              child: ClipOval(
                                child: _imageFile != null
                                    ? Image.file(_imageFile!, fit: BoxFit.cover)
                                    : (widget.profile.profileImage != null
                                        ? Image.network(widget.profile.profileImage!, fit: BoxFit.cover)
                                        : const Icon(Icons.person, size: 50, color: Colors.grey)),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                color: Color(0xFF0D32B3),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.camera_alt, color: Colors.white, size: 16),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      _buildTextField('First Name', _firstNameController),
                      const SizedBox(height: 16),
                      _buildTextField('Last Name', _lastNameController),
                      const SizedBox(height: 16),
                      _buildTextField('Birth Date', _birthDateController),
                      const SizedBox(height: 16),
                      _buildTextField('Phone Number', _phoneController),
                      const SizedBox(height: 16),
                      _buildTextField('Town', _townController),
                      const SizedBox(height: 30),
                      BlocConsumer<ProfileCubit, ProfileState>(
                        listener: (context, state) {
                          if (state is ProfileUpdateSuccess) {
                            debugPrint('✅ Update Success: ${state.message}');
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(state.message),
                                backgroundColor: Colors.green,
                              ),
                            );
                            Navigator.pop(context);
                          } else if (state is ProfileUpdateFailure) {
                            debugPrint('❌ Update Failure: ${state.errorMessage}');
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  state.errorMessage,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                backgroundColor: Colors.red,
                                duration: const Duration(seconds: 5),
                              ),
                            );
                          } else if (state is ProfileUpdateLoading) {
                            debugPrint('⏳ Update Loading...');
                          }
                        },
                        builder: (context, state) {
                          if (state is ProfileUpdateLoading) {
                            return const CircularProgressIndicator(color: Color(0xFF0D32B3));
                          }
                          return SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF0D32B3),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              onPressed: () {
                                widget.cubit.updateProfile(
                                  firstName: _firstNameController.text,
                                  lastName: _lastNameController.text,
                                  birthDate: _birthDateController.text,
                                  phone: _phoneController.text,
                                  town: _townController.text,
                                  profileImagePath: _imageFile?.path,
                                );
                              },
                              child: const Text(
                                'Save Changes',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Color(0xFF0D32B3)),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
