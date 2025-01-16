import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/authProvider.dart';

import 'package:automate/screens/dashboards/adminDashboard.dart';
import 'package:automate/screens/dashboards/userDashboard.dart';
import '../controllers/auth_controller.dart';
import '../layout.dart';
import '../models/user.dart';
import 'Register.dart';
import 'account.dart';

// LoginPage
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static final String id = 'LoginPage';

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              elevation: 10.0,
              title: const Text(
                'Log in',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                color: Colors.white,
                onPressed: () {
                  Navigator.pushNamed(context, Layout.id);
                },
              ),
            ),
            body: orientation == Orientation.portrait
                ? const LoginPortrait()
                : const LoginLandscape(),
          ),
        );
      },
    );
  }
}

// LoginPortrait widget
class LoginPortrait extends StatelessWidget {
  const LoginPortrait({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: Center(
              child: Column(
                children: [
                  // AccountPageTitle
                  const AccountPageTitle(),

                  const SizedBox(height: 30.0),

                  // Form
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 30.0, horizontal: 20.0),
                      child: Column(
                        children: [
                          // LoginForm
                          const LoginForm(),
                          SwitchBtn(
                            textFeild: 'I have an account',
                            btnName: 'Register',
                            navigateTo: RegisterPage.id,
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// LoginLandscape widget
class LoginLandscape extends StatelessWidget {
  const LoginLandscape({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 30.0),
                  child: Column(
                    children: [
                      const AccountPageTitle(),
                      SwitchBtn(
                        textFeild: 'I have an account',
                        btnName: 'Register',
                        navigateTo: RegisterPage.id,
                      ),
                    ],
                  ),
                ),

                // Form
                const Expanded(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
                    child: LoginForm(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//LoginForm
class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  String error = "";
  bool _obscureText = true;

  void setError(String message) {
    setState(() {
      error = message;
    });
  }

  void handleLogin() async {
    try {
      User user =
          await Auth.login(_emailController.text, _passwordController.text);
      Provider.of<AuthProvider>(context, listen: false).setUser(user);

      if (user.role == 'admin') {
        Navigator.pushNamed(context, AdminDashboard.id);
      } else {
        Navigator.pushNamed(context, UserDashoard.id);
      }
    } catch (e) {
      setError(e.toString());
      _passwordController.clear();
      print(e);
    }
  }

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
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

          // Password
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
              hintText: 'Enter your password',
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
          ),

          const SizedBox(height: 10.0),

          // Login Button
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
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  handleLogin();
                }
              },
              color: Theme.of(context).primaryColor,
              child: Text(
                'Log in',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
              ),
            ),
          ),
          if (error.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                error,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.redAccent,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
