// lib/layout.dart
import 'package:automate/screens/home.dart';
import 'package:flutter/material.dart';

class MainLayoyt extends StatefulWidget {
  static final String id = 'MainLayoyt';
  final VoidCallback toggleTheme;
  final Color titleColor;
  final LinearGradient titleGradient;

  const MainLayoyt({super.key, required this.toggleTheme, required this.titleColor, required this.titleGradient});

  @override
  _MainLayoytState createState() => _MainLayoytState();
}

class _MainLayoytState extends State<MainLayoyt> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    const Center(child: Text('Search Page')),
    const Center(child: Text('Chat Page')),
    const Center(child: Text('Account Page')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarTitle(color: widget.titleColor, titleGradient: widget.titleGradient),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 10.0, 0),
            child: IconButton(
              icon: Icon(Icons.brightness_6),
              onPressed: widget.toggleTheme,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: _pages[_selectedIndex],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Action for the Post button
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.amber,
        elevation: 6.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
            side: BorderSide(color: Colors.white)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 6.0,
        child: SizedBox(
          height: 56.0,
          child: BottomNavigationBar(
            selectedIconTheme: IconThemeData(color: Colors.red),
            selectedItemColor: Colors.red,
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
            selectedFontSize: 12,
            unselectedFontSize: 12,
          ),
        ),
      ),
    );
  }
}

class AppBarTitle extends StatelessWidget {
  final Color color;
  final LinearGradient titleGradient;

  const AppBarTitle({super.key, required this.color, required this.titleGradient});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => titleGradient.createShader(bounds),
      child: Text(
        'Automate',
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}