// import 'package:flutter/material.dart';

// class ProfileScreenUI extends StatelessWidget {
//   const ProfileScreenUI({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         /// صورة البروفايل
//         Stack(
//           alignment: Alignment.center,
//           children: [
//             const CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),
//             Positioned(
//               bottom: 0,
//               right: MediaQuery.of(context).size.width / 2 - 50,
//               child: const Icon(Icons.camera_alt),
//             ),
//           ],
//         ),

//         const SizedBox(height: 10),

//         /// الاسم
//         const Text(
//           "Thomas Anderson",
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),

//         const SizedBox(height: 20),

//         /// Contact Information
//         Container(
//           margin: const EdgeInsets.symmetric(horizontal: 16),
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             border: Border.all(),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Column(
//             children: [
//               /// العنوان + أيقونات
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: const [
//                   Text(
//                     "Contact Information",
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   Row(
//                     children: [
//                       Icon(Icons.delete),
//                       SizedBox(width: 10),
//                       Icon(Icons.edit),
//                     ],
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 10),

//               const Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text("thomas.anderson@gmail.com"),
//               ),

//               const SizedBox(height: 5),

//               const Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text("01207201864"),
//               ),
//             ],
//           ),
//         ),

//         const SizedBox(height: 20),

//         /// Vehicles information
//         Container(
//           margin: const EdgeInsets.symmetric(horizontal: 16),
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             border: Border.all(),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Column(
//             children: const [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "Vehicles information",
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   Icon(Icons.keyboard_arrow_down),
//                 ],
//               ),

//               SizedBox(height: 10),

//               ListTile(
//                 contentPadding: EdgeInsets.zero,
//                 title: Text("Toyota Camry 2022"),
//               ),

//               ListTile(
//                 contentPadding: EdgeInsets.zero,
//                 leading: Icon(Icons.add),
//                 title: Text("Add new one"),
//               ),
//             ],
//           ),
//         ),

//         const SizedBox(height: 20),

//         /// Logout
//         TextButton.icon(
//           icon: const Icon(Icons.logout),
//           label: const Text("Logout"),
//           onPressed: () {},
//         ),

//         const SizedBox(height: 20),
//       ],
//     );
//   }
// }
///////////////////////////////////////////////////////
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});

//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   File? _image;
//   final ImagePicker _picker = ImagePicker();

//   Future<void> _pickImage() async {
//     final XFile? pickedFile = await _picker.pickImage(
//       source: ImageSource.gallery,
//     );
//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           children: [
//             const SizedBox(height: 50),
//             // صورة البروفايل والكاميرا
//             Stack(
//               children: [
//                 CircleAvatar(
//                   radius: 50,
//                   backgroundImage: _image != null ? FileImage(_image!) : null,
//                   child: _image == null
//                       ? const Icon(Icons.person, size: 50)
//                       : null,
//                 ),
//                 Positioned(
//                   bottom: 0,
//                   right: 0,
//                   child: GestureDetector(
//                     onTap: _pickImage, // تفعيل الكاميرا
//                     child: const CircleAvatar(
//                       radius: 15,
//                       backgroundColor: Colors.white,
//                       child: Icon(Icons.camera_alt, size: 18),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const Text(
//               "Thomas Anderson",
//               style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 20),

//             // بطاقة Contact Info
//             _buildCard("Contact Information", [
//               _buildRow(
//                 Icons.email_outlined,
//                 "Email",
//                 "thomas.anderson@gmail.com",
//               ),
//               _buildRow(Icons.phone, "Phone", "01207201864"),
//             ]),

//             // بطاقة Personal Info
//             _buildCard("Personal Info", [
//               _buildRow(Icons.lock_outline, "Password", "***************"),
//               _buildRow(Icons.badge_outlined, "ID", "30***********6"),
//             ]),

//             // زر Vehicles Information
//             Container(
//               margin: const EdgeInsets.symmetric(vertical: 10),
//               padding: const EdgeInsets.all(15),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: const Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text("Vehicles information"),
//                   Icon(Icons.keyboard_arrow_down),
//                 ],
//               ),
//             ),

//             const Spacer(),

//             // زر Logout
//             TextButton.icon(
//               onPressed: () {
//                 Navigator.pushNamed(context, '/choicewho');
//               },
//               icon: const Icon(Icons.logout, color: Colors.red),
//               label: const Text(
//                 "Logout",
//                 style: TextStyle(color: Colors.red, fontSize: 18),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCard(String title, List<Widget> children) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 15),
//       padding: const EdgeInsets.all(15),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
//               const Row(
//                 children: [
//                   Icon(Icons.delete, size: 18, color: Colors.pink),
//                   SizedBox(width: 10),
//                   Icon(Icons.edit, size: 18, color: Colors.blue),
//                 ],
//               ),
//             ],
//           ),
//           const Divider(),
//           ...children,
//         ],
//       ),
//     );
//   }

//   Widget _buildRow(IconData icon, String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         children: [
//           Icon(icon, size: 20),
//           const SizedBox(width: 10),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(label, style: const TextStyle(fontSize: 12)),
//               Text(value),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// #هيتعدل تاني#

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Vehicles information"),
                Icon(Icons.keyboard_arrow_down),
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
