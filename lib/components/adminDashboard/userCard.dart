import 'package:flutter/material.dart';
import '../../../controllers/admin_controller.dart';

class UserCard extends StatelessWidget {
  final String userId;
  final String name;
  final String email;
  final String mobile;
  final String role;

  const UserCard({
    required this.userId,
    required this.name,
    required this.email,
    required this.mobile,
    required this.role,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('User ID: $userId',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(role, style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 8.0),
            Text('Name: $name'),
            const SizedBox(height: 8.0),
            Text('Email: $email'),
            const SizedBox(height: 8.0),
            Text('Mobile: $mobile'),
            const SizedBox(height: 8.0),
            // Text('Active: ${isActive ? "Yes" : "No"}'),
            // const SizedBox(height: 8.0),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     ElevatedButton(
            //       onPressed: onActivate,
            //       style: ElevatedButton.styleFrom(
            //         backgroundColor: Colors.green,
            //       ),
            //       child: const Text('Activate',
            //           style: TextStyle(color: Colors.white)),
            //     ),
            //     const SizedBox(width: 8.0),
            //     ElevatedButton(
            //       onPressed: onDeactivate,
            //       style: ElevatedButton.styleFrom(
            //         backgroundColor: Colors.red,
            //       ),
            //       child: const Text('Deactivate',
            //           style: TextStyle(color: Colors.white)),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}