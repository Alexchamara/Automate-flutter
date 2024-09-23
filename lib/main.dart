import 'package:automate/screens/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:automate/screens/Register.dart';
import 'package:automate/screens/login.dart';
import 'layout.dart';

void main() {
  runApp(const AutomateApp());
}

class AutomateApp extends StatefulWidget {
  const AutomateApp({super.key});

  @override
  _AutomateAppState createState() => _AutomateAppState();
}

class _AutomateAppState extends State<AutomateApp> {
  // Initial theme mode set to light
  ThemeMode _themeMode = ThemeMode.light;

  // Function to toggle between light and dark theme
  void _toggleTheme() {
    setState(() {
      // Toggle theme mode
      _themeMode = (_themeMode == ThemeMode.light) ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedTheme(
      duration: const Duration(milliseconds: 500), // Smooth transition duration
      data: _themeMode == ThemeMode.light ? _lightTheme : _darkTheme,
      child: MaterialApp(
        // Set the theme mode
        themeMode: _themeMode,

        // Define light theme
        theme: _lightTheme,

        // Define dark theme
        darkTheme: _darkTheme,

        // Initial route of the application
        initialRoute: MainLayoyt.id,

        // Define routes
        routes: {
          MainLayoyt.id: (context) => MainLayoyt(toggleTheme: _toggleTheme),
          RegisterPage.id: (context) => RegisterPage(),
          LoginPage.id: (context) => LoginPage(),
          ProductDetailPage.id: (context) => ProductDetailPage(),
        },
      ),
    );
  }

  final ThemeData _lightTheme = ThemeData(
    primaryColor: const Color(0xFFFF3B3F), // Bright red
    scaffoldBackgroundColor: const Color(0xFFF9F9F9), // Light background
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFFF3B3F), // Red AppBar in light mode
      titleTextStyle: TextStyle(color: Colors.black, fontSize: 20), // Title black in light mode
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black), // Black text in light mode
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFFFF3B3F), // Red FAB in light mode
    ),
  );

  final ThemeData _darkTheme = ThemeData(
    primaryColor: const Color(0xFFFF3B3F), // Same red in dark mode
    scaffoldBackgroundColor: const Color(0xFF1C1C1C), // Dark background 121212
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFD32F2F), // Slightly darker red for dark mode
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20), // Title white in dark mode
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white), // White text in dark mode
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFFFF3B3F), // Red FAB in dark mode
    ),
  );
}