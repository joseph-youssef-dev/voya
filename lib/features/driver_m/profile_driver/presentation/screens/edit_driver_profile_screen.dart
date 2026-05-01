import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:voya/core/shared/custom_header.dart';
import 'package:voya/features/driver_m/profile_driver/data/models/driver_profile_model.dart';
import 'package:voya/features/driver_m/profile_driver/logic/cubit/driver_profile_cubit.dart';
import 'package:voya/features/driver_m/profile_driver/logic/cubit/driver_profile_state.dart';

class EditDriverProfileScreen extends StatefulWidget {
  final DriverProfileModel profile;
  final DriverProfileCubit cubit;

  const EditDriverProfileScreen({
    super.key,
    required this.profile,
    required this.cubit,
  });

  @override
  State<EditDriverProfileScreen> createState() =>
      _EditDriverProfileScreenState();
}

class _EditDriverProfileScreenState extends State<EditDriverProfileScreen> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _birthDateController;
  late TextEditingController _phoneController;
  late TextEditingController _townController;
  String? _imagePath;

  bool _isPickerActive = false;

  @override
  void initState() {
    super.initState();
    final names = widget.profile.fullName.trim().split(' ');
    final firstName = names.isNotEmpty ? names.first : '';
    final lastName = names.length > 1 ? names.sublist(1).join(' ') : '';

    _firstNameController = TextEditingController(text: firstName);
    _lastNameController = TextEditingController(text: lastName);
    _birthDateController = TextEditingController(
      text: widget.profile.birthDate.split('T')[0],
    );
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
                      const SizedBox(height: 10),
                      Center(
                        child: InkWell(
                          onTap: () async {
                            if (_isPickerActive) return;
                            
                            setState(() {
                              _isPickerActive = true;
                            });

                            try {
                              final picker = ImagePicker();
                              final XFile? image = await picker.pickImage(
                                source: ImageSource.gallery,
                                imageQuality: 70, // ضغط الصورة لتقليل حجمها وتجنب الكراش
                                maxWidth: 800,
                                maxHeight: 800,
                              );
                              if (image != null && mounted) {
                                setState(() {
                                  _imagePath = image.path;
                                });
                              }
                            } catch (e) {
                              debugPrint('❌ Image Picker Error: $e');
                            } finally {
                              if (mounted) {
                                setState(() {
                                  _isPickerActive = false;
                                });
                              }
                            }
                          },
                          child: Stack(
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
                                  child: _imagePath != null
                                      ? Image.file(
                                          File(_imagePath!),
                                          fit: BoxFit.cover,
                                        )
                                      : (widget.profile.profileImage != null
                                            ? Image.network(
                                                widget.profile.profileImage!.startsWith('http')
                                                    ? widget.profile.profileImage!
                                                    : 'http://voya.runasp.net${widget.profile.profileImage!.startsWith('/') ? '' : '/'}${widget.profile.profileImage!}',
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error, stackTrace) =>
                                                    const Icon(Icons.person, color: Colors.grey, size: 50),
                                              )
                                            : const Icon(
                                                Icons.person,
                                                size: 50,
                                                color: Colors.grey,
                                              )),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF0D32B3),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      _buildTextField('First Name', _firstNameController),
                      const SizedBox(height: 16),
                      _buildTextField('Last Name', _lastNameController),
                      const SizedBox(height: 16),
                      _buildTextField(
                        'Birth Date',
                        _birthDateController,
                        readOnly: true,
                        onTap: () async {
                          DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate:
                                DateTime.tryParse(_birthDateController.text) ??
                                DateTime(2000),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );
                          if (picked != null) {
                            setState(() {
                              _birthDateController.text =
                                  "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      _buildTextField('Phone Number', _phoneController),
                      const SizedBox(height: 16),
                      _buildTextField('Town', _townController),
                      const SizedBox(height: 30),
                      BlocConsumer<DriverProfileCubit, DriverProfileState>(
                        listener: (context, state) {
                          if (state is DriverProfileUpdateSuccess) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(state.message),
                                backgroundColor: Colors.green,
                              ),
                            );
                            Navigator.pop(context);
                          } else if (state is DriverProfileUpdateFailure) {
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
                          }
                        },
                        builder: (context, state) {
                          if (state is DriverProfileUpdateLoading) {
                            return const CircularProgressIndicator(
                              color: Color(0xFF0D32B3),
                            );
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
                                debugPrint(
                                  '🛠️ Saving Profile: ${_firstNameController.text} ${_lastNameController.text}, Date: ${_birthDateController.text}, Phone: ${_phoneController.text}, Town: ${_townController.text}, Image: $_imagePath',
                                );
                                widget.cubit.updateProfile(
                                  firstName: _firstNameController.text,
                                  lastName: _lastNameController.text,
                                  birthDate: _birthDateController.text,
                                  phone: _phoneController.text,
                                  town: _townController.text,
                                  ssn: widget.profile.ssn,
                                  profileImagePath: _imagePath,
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

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    bool readOnly = false,
    VoidCallback? onTap,
  }) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
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
