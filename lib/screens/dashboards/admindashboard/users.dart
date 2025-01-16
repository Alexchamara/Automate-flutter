import 'package:flutter/material.dart';

import '../../../components/adminDashboard/userCard.dart';

class MangeUsers extends StatelessWidget {
  const MangeUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Manage Users',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Manage Users',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            const Text(
              'Please fill in the form below to manage users.',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20.0),
            UserCard(
              userId: '1',
              name: 'John Doe',
              email: ' [email protected]',
              mobile: '0712345678',
              role: 'Admin',
              isActive: true,
              createdAt: '2021-09-01 12:00:00',
              onActivate: () {},
              onDeactivate: () {},
            ),
          ],
        ),
      ),
    );
  }
}
