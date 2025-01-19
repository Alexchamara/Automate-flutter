import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../layout.dart';
import '../../providers/authProvider.dart';
import '../login.dart';

class UserDashoard extends StatelessWidget {
  const UserDashoard({super.key});

  static final String id = 'UserDashoard';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pushNamed(context, Layout.id);
          },
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              leading: Icon(Icons.ads_click),
              title: Text('My Ads'),
              onTap: () {
                Navigator.pushNamed(context, 'myAds');
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              leading: Icon(Icons.favorite),
              title: Text('Favourites'),
              onTap: () {
                Navigator.pushNamed(context, 'favourites');
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              leading: Icon(Icons.message),
              title: Text('My Messages'),
              onTap: () {
                Navigator.pushNamed(context, 'myMessages');
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              leading: Icon(Icons.person),
              title: Text('Personal Details'),
              onTap: () {
                Navigator.pushNamed(context, 'personalDetails');
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              leading: Icon(Icons.security),
              title: Text('Account Security'),
              onTap: () {
                Navigator.pushNamed(context, 'accountSecurity');
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
                leading: Icon(Icons.logout),
                title: Text('Log out'),
                onTap: () async {
                  try {
                    await Provider.of<AuthProvider>(context, listen: false)
                        .logOut();
                    Navigator.pushNamedAndRemoveUntil(
                        context, LoginPage.id, (route) => false);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Logout failed: ${e.toString()}')),
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }
}
