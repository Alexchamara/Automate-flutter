import 'package:flutter/material.dart';

class Personal extends StatefulWidget {
  const Personal({super.key});

  @override
  State<Personal> createState() => _PersonalState();
}

class _PersonalState extends State<Personal> {
  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          // Full Name
          TextFormField(
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

          // Submit Button
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
              onPressed: () {},
              color: Theme.of(context).primaryColor,
              child: Text(
                'Change Password',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );  }
}

