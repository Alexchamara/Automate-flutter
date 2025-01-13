import 'package:flutter/material.dart';

class UserDashoard extends StatelessWidget {
  const UserDashoard({super.key});

  static final String id = 'UserDashoard';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Dashboard'),
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
              onTap: () {
                // Handle log out
              },
            ),
          ),
        ],
      ),
    );
  }
}
