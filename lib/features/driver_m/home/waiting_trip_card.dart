import 'package:flutter/material.dart';

class WaitingTripCard extends StatelessWidget {
  const WaitingTripCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.circle, size: 12, color: Colors.blue),
                        SizedBox(width: 8),
                        Text("New York"),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: Text("|"),
                    ),
                    Row(
                      children: [
                        Icon(Icons.circle, size: 12, color: Colors.blue),
                        SizedBox(width: 8),
                        Text("Boston"),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 16),
                    SizedBox(width: 5),
                    Text("Feb 20"),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.attach_money, size: 16),
                    SizedBox(width: 5),
                    Text("\$150"),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.people, size: 20),
                      SizedBox(width: 5),
                      Text("4 Available seats"),
                    ],
                  ),
                  Text(
                    "\$600",
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
