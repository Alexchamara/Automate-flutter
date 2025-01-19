import 'package:flutter/material.dart';
import '../../controllers/auth_controller.dart';
import '../../models/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Personal extends StatefulWidget {
  const Personal({super.key});

  @override
  State<Personal> createState() => _PersonalState();
}

class _PersonalState extends State<Personal> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserDetails();
  }

  Future<void> _loadUserDetails() async {
    const storage = FlutterSecureStorage();
    String? name = await storage.read(key: "name");
    String? email = await storage.read(key: "email");
    String? mobile = await storage.read(key: "mobile");

    setState(() {
      _nameController.text = name ?? '';
      _emailController.text = email ?? '';
      _mobileController.text = mobile ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          // Full Name
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Full Name',
              hintText: 'Enter your full name',
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 14.0),
              labelStyle: const TextStyle(color: Colors.grey, fontSize: 14.0),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your full name';
              }
              return null;
            },
          ),
          const SizedBox(height: 10.0),
          // Email
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              hintText: 'Enter your email',
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 14.0),
              labelStyle: const TextStyle(color: Colors.grey, fontSize: 14.0),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
              if (!emailRegex.hasMatch(value)) {
                return 'Please enter a valid email address';
              }
              return null;
            },
          ),
          const SizedBox(height: 10.0),
          // Mobile
          TextFormField(
            controller: _mobileController,
            decoration: InputDecoration(
              labelText: 'Mobile',
              hintText: 'Enter your mobile number',
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 14.0),
              labelStyle: const TextStyle(color: Colors.grey, fontSize: 14.0),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your mobile number';
              }
              final mobileRegex = RegExp(r'^[0-9]{10}$');
              if (!mobileRegex.hasMatch(value)) {
                return 'Please enter a valid mobile number';
              }
              return null;
            },
          ),
          const SizedBox(height: 10.0),
          // Update Button
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(3),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 5,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: MaterialButton(
              height: 50,
              minWidth: MediaQuery.of(context).size.width,
              onPressed: _updateUserDetails,
              color: Theme.of(context).primaryColor,
              child: Text(
                'Update Details',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _updateUserDetails() async {
    bool? confirm = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Update'),
          content: Text('Are you sure you want to update your details?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text('Confirm'),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      try {
        await Auth.updateUserDetails(
          _nameController.text,
          _emailController.text,
          _mobileController.text,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Details updated successfully')),
        );
        // Clear all the fields
        _nameController.clear();
        _emailController.clear();
        _mobileController.clear();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Update failed: ${e.toString()}')),
        );
      }
    }
  }
}