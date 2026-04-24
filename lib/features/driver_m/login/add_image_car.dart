import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CarImageUploader extends StatefulWidget {
  @override
  _CarImageUploaderState createState() => _CarImageUploaderState();
}

class _CarImageUploaderState extends State<CarImageUploader> {
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
    return Column(
      children: [
        const Text(
          " Image of your car",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          child: _image == null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.cloud_upload,
                      size: 50,
                      color: Colors.blue,
                    ),
                    const Text("Drag file here"),
                    const Text("OR"),
                    ElevatedButton(
                      onPressed: _pickImage,
                      child: const Text("Upload image"),
                    ),
                  ],
                )
              : Image.file(_image!, fit: BoxFit.cover),
        ),
      ],
    );
  }
}
