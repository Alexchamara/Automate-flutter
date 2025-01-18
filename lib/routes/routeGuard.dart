import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:automate/providers/authProvider.dart';
import 'package:automate/screens/login.dart';

class RouteGuard extends StatelessWidget {
  final Widget child;

  const RouteGuard({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    if (!authProvider.authenticated()) {
      // Redirect to login page if not authenticated
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, LoginPage.id);
      });
      return Container(); // Return an empty container while redirecting
    }

    return child; // Return the requested page if authenticated
  }
}