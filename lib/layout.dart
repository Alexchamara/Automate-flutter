// lib/layout.dart
import 'package:automate/screens/account.dart';
import 'package:automate/screens/home.dart';
import 'package:automate/screens/search.dart';
import 'package:automate/screens/test.dart';
import 'package:flutter/material.dart';

class MainLayoyt extends StatefulWidget {
  static final String id = 'MainLayoyt';
  final VoidCallback toggleTheme;

  const MainLayoyt({super.key, required this.toggleTheme});

  @override
  _MainLayoytState createState() => _MainLayoytState();
}

class _MainLayoytState extends State<MainLayoyt> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const SearchPage(),
    const Center(child: Text('Chat Page')),
    const AccountPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        // App bar
        appBar: AppBar(
          elevation: 10.0,
          title: const Text(
            'Automate',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Theme.of(context).primaryColor, // Red background
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10.0, 0),
              child: IconButton(
                icon: const Icon(Icons.dark_mode_sharp),
                onPressed: widget.toggleTheme,
                color: Colors.white, // Icon color
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: _pages[_selectedIndex],
        ),

        //Create Ad btn
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Action for the Post button
          },
          backgroundColor: Theme.of(context).primaryColor, // Red FAB
          elevation: 6.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
              side: const BorderSide(color: Colors.white)),
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

        // Bottom navigation bar
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 6.0,
          child: SizedBox(
            height: 56.0,
            child: BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home, size: 24),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search, size: 24),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.chat, size: 24),
                  label: 'Chat',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle, size: 24),
                  label: 'Account',
                ),
              ],
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Theme.of(context).primaryColor, // Red for selected item
              unselectedItemColor: Colors.grey, // Gray for unselected items
              selectedFontSize: 12,
              unselectedFontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}