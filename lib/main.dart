import 'package:automate/screens/product_detail.dart';
import 'package:automate/screens/search.dart';
import 'package:flutter/material.dart';
import 'package:automate/screens/Register.dart';
import 'package:automate/screens/login.dart';
import 'layout.dart';


void main() {
  runApp(const AutomateApp());
}

// Main application widget
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedTheme(
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
          initialRoute: Layout.id,

          // Define routes
          routes: {
            Layout.id: (context) => Layout(toggleTheme: _toggleTheme),
            RegisterPage.id: (context) => const RegisterPage(),
            LoginPage.id: (context) => const LoginPage(),
            ProductDetailPage.id: (context) => const ProductDetailPage(),
            SearchPage.id: (context) => const SearchPage(),
          },
        ),
      ),
    );
  }

  // Light theme
  final ThemeData _lightTheme = ThemeData(
  // Bright red primary color
    primaryColor: const Color(0xFFFF3B3F),

    // Light background
    scaffoldBackgroundColor: const Color(0xFFF9F9F9),

    // Red AppBar in light mode
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFFF3B3F),
      titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
    ),

    // Black text in light mode
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
    ),

    // Red FAB in light mode
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFFFF3B3F),
    ),
  );


  // Dark theme
  final ThemeData _darkTheme = ThemeData(
    // Same red in dark mode
    primaryColor: const Color(0xFFFF3B3F),

    // Dark background 121212
    scaffoldBackgroundColor: const Color(0xFF1C1C1C),

    // Dark red AppBar in dark mode
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFD32F2F),
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
    ),

    // White text in dark mode
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
    ),

    // Red FAB in dark mode
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFFFF3B3F),
    ),
  );
}