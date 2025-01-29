import 'package:flutter/material.dart';
import '../../../components/adminDashboard/userCard.dart';
import '../../../controllers/admin_controller.dart';
import '../../../models/user.dart';

class MangeUsers extends StatefulWidget {
  const MangeUsers({super.key});

  @override
  _MangeUsersState createState() => _MangeUsersState();
}

class _MangeUsersState extends State<MangeUsers> {
  late Future<List<User>> _usersFuture;

  @override
  void initState() {
    super.initState();
    _usersFuture = AdminController.getAllUsersExcludingAdmins();
  }

  void _activateUser(int userId) async {
    await AdminController.activateUser(userId);
    setState(() {
      _usersFuture = AdminController.getAllUsersExcludingAdmins();
    });
  }

  void _deactivateUser(int userId) async {
    await AdminController.deactivateUser(userId);
    setState(() {
      _usersFuture = AdminController.getAllUsersExcludingAdmins();
    });
  }

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
            Expanded(
              child: FutureBuilder<List<User>>(
                future: _usersFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No users found.'));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final user = snapshot.data![index];
                        return UserCard(
                          userId: user.id.toString(),
                          name: user.name,
                          email: user.email,
                          mobile: user.mobile,
                          role: user.role,
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}