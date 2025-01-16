import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  static final String id = 'AdminDashboard';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard',
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold)),
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
          children: [
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                children: const [
                  DashboardCard(
                    title: 'Total Adverts',
                    count: '100',
                    color: Colors.blue,
                  ),
                  DashboardCard(
                    title: 'Pending Ads',
                    count: '20',
                    color: Colors.orange,
                  ),
                  DashboardCard(
                    title: 'Active Ads',
                    count: '30',
                    color: Colors.red,
                  ),
                  DashboardCard(
                    title: 'Total Users',
                    count: '50',
                    color: Colors.green,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: const Icon(Icons.ads_click),
                    title: const Text('Advertisements'),
                    onTap: () {
                      Navigator.pushNamed(context, 'manageAdverts');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.people),
                    title: const Text('Users'),
                    onTap: () {
                      Navigator.pushNamed(context, 'manageUsers');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.admin_panel_settings),
                    title: const Text('Admin'),
                    onTap: () {
                      Navigator.pushNamed(context, 'addAdmin');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('Personal Details'),
                    onTap: () {
                      Navigator.pushNamed(context, 'personalDetails');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.security),
                    title: const Text('Account Security'),
                    onTap: () {
                      Navigator.pushNamed(context, 'accountSecurity');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Logout'),
                    onTap: () {
                      Navigator.pushNamed(context, 'login');
                    },
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

// Information Card
class DashboardCard extends StatelessWidget {
  final String title;
  final String count;
  final Color color;

  const DashboardCard({
    required this.title,
    required this.count,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            Center(
              child: Text(
                count,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 34.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
