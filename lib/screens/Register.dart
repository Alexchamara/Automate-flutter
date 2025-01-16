import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/auth_controller.dart';
import '../layout.dart';
import '../models/user.dart';
import '../providers/authProvider.dart';
import 'account.dart';
import 'dashboards/userDashboard.dart';
import 'login.dart';

// RegisterPage
class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  static final String id = 'RegisterPage';

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
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
                ? const RegisterPortrait()
                : const RegisterLandscape(),
          ),
        );
      },
    );
  }
}

// RegisterPortrait widget
class RegisterPortrait extends StatelessWidget {
  const RegisterPortrait({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: Center(
                  child: Column(
                    children: [
                      // AccountPageTitle
                      const AccountPageTitle(),

                      // Form
                      Container(
                        // color: Colors.red[100],
                        padding: const EdgeInsets.symmetric(
                            vertical: 30.0, horizontal: 20.0),
                        child: Column(
                          children: [
                            // RegisterForm
                            const RegisterForm(),

                            SwitchBtn(
                              textFeild: 'Already have an account?',
                              btnName: 'Log in',
                              navigateTo: LoginPage.id,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// RegisterLandscape widget
class RegisterLandscape extends StatelessWidget {
  const RegisterLandscape({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
            child: Column(
              children: [
                const AccountPageTitle(),
                SwitchBtn(
                  textFeild: 'Already have an account?',
                  btnName: 'Log in',
                  navigateTo: LoginPage.id,
                ),
              ],
            ),
          ),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
              child: SingleChildScrollView(
                child: RegisterForm(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// RegisterForm widget
// RegisterForm widget
class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String error = "";
  bool _obscureText = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void setError(String message) {
    setState(() {
      error = message;
    });
  }

  void handleRegister() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      setError("Passwords do not match");
      return;
    }

    try {
      User user = await Auth.register(
        _nameController.text,
        _emailController.text,
        _passwordController.text,
        _confirmPasswordController.text, // Pass the confirmation password
      );
      Provider.of<AuthProvider>(context, listen: false).setUser(user);
      Navigator.pushNamed(context, UserDashoard.id);
    } catch (e) {
      setError(e.toString());
      // _confirmPasswordController.clear();
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
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
          // Confirm Password
          TextFormField(
            controller: _confirmPasswordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Confirm Password',
              hintText: 'Confirm your password',
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
                return 'Please confirm your password';
              }
              return null;
            },
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
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  handleRegister();
                }
              },
              color: Theme.of(context).primaryColor,
              child: Text(
                'Register',
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
