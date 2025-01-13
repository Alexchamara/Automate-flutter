import 'package:flutter/material.dart';

class Security extends StatefulWidget {
  const Security({super.key});

  @override
  State<Security> createState() => _SecurityState();
}

class _SecurityState extends State<Security> {
  @override
  Widget build(BuildContext context) {
    return  Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          // Old Password
          const PasswordField(
            labelText: 'Old Password',
            hintText: 'Enter your old password',
          ),

          const SizedBox(height: 10.0),
          // Password
          const PasswordField(
            labelText: 'Password',
            hintText: 'Enter your password',

          ),

          const SizedBox(height: 10.0),
          // Confirm Password
          const PasswordField(
            labelText: 'Confirm Password',
            hintText: 'Confirm your password',

          ),

          const SizedBox(height: 10.0),

          // Register Button
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
    );
  }
}

// PasswordField widget
class PasswordField extends StatefulWidget {
  final String labelText;
  final String hintText;

  const PasswordField({
    Key? key,
    required this.labelText,
    required this.hintText,
  }) : super(key: key);

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _obscureText,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14.0),
        labelStyle: const TextStyle(color: Colors.grey, fontSize: 14.0),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        return null;
      },
    );
  }
}
