import 'package:flutter/material.dart';

class ProfileScreenUI extends StatelessWidget {
  const ProfileScreenUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// صورة البروفايل
        Stack(
          alignment: Alignment.center,
          children: [
            const CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),
            Positioned(
              bottom: 0,
              right: MediaQuery.of(context).size.width / 2 - 50,
              child: const Icon(Icons.camera_alt),
            ),
          ],
        ),

        const SizedBox(height: 10),

        /// الاسم
        const Text(
          "Thomas Anderson",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 20),

        /// Contact Information
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              /// العنوان + أيقونات
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Contact Information",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Icon(Icons.delete),
                      SizedBox(width: 10),
                      Icon(Icons.edit),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 10),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text("thomas.anderson@gmail.com"),
              ),

              const SizedBox(height: 5),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text("01207201864"),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        /// Vehicles information
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: const [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Vehicles information",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.keyboard_arrow_down),
                ],
              ),

              SizedBox(height: 10),

              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text("Toyota Camry 2022"),
              ),

              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.add),
                title: Text("Add new one"),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        /// Logout
        TextButton.icon(
          icon: const Icon(Icons.logout),
          label: const Text("Logout"),
          onPressed: () {},
        ),

        const SizedBox(height: 20),
      ],
    );
  }
}
