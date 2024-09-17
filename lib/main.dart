// lib/main.dart
import 'package:flutter/material.dart';
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
  ThemeMode _themeMode = ThemeMode.light;
  Color _titleColor = Colors.white;
  LinearGradient titleGradient = const LinearGradient(colors:
  [Colors.black, Colors.red],
    tileMode: TileMode.mirror,
  );

  void _toggleTheme() {
    setState(() {
      _themeMode =(_themeMode == ThemeMode.light) ? ThemeMode.dark : ThemeMode.light;
      _titleColor = (_themeMode == ThemeMode.light) ?  Colors.black : Colors.white;
      titleGradient = (_themeMode == ThemeMode.light) ? const LinearGradient(colors: [Colors.black, Colors.red], tileMode: TileMode.mirror) : const LinearGradient(colors: [Colors.red, Colors.white], tileMode: TileMode.mirror);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: _themeMode,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      initialRoute: MainLayoyt.id,
      routes: {
        MainLayoyt.id: (context) => MainLayoyt(toggleTheme: _toggleTheme, titleColor: _titleColor, titleGradient: titleGradient),
      },
    );
  }
}