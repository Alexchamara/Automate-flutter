import 'package:flutter/material.dart';

import '../layout.dart';
import 'Register.dart';
import 'account.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static final String id = 'LoginPage';

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
                      Text(
                        'Welcome to',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                      const SizedBox(height: 10.0),
                      MaterialButton(onPressed: (){
                        Navigator.pushNamed(context, MainLayoyt.id);
                      },
                        child: Text(
                          'Automate',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Text('Log in to manage your account',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                              fontSize: 14.0, fontWeight: FontWeight.bold)),

                      // Form
                      Container(
                        // color: Colors.red[100],
                        padding: const EdgeInsets.symmetric(
                            vertical: 30.0, horizontal: 20.0),
                        child: Column(
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Email',
                                hintText: 'Enter your email',
                                hintStyle: const TextStyle(
                                    color: Colors.grey, fontSize: 14.0),
                                labelStyle: const TextStyle(
                                    color: Colors.grey, fontSize: 14.0),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            const PasswordField(
                              labelText: 'Password',
                              hintText: 'Enter your password',
                            ),
                            const SizedBox(height: 10.0),
                            //Register btn
                            const SizedBox(height: 10.0),
                            Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(3),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      blurRadius: 5,
                                      offset: const Offset(0, 5)),
                                ],
                              ),
                              child: MaterialButton(
                                height: 50,
                                minWidth: MediaQuery.of(context).size.width,
                                onPressed: () {},
                                color: Theme.of(context).primaryColor,
                                child: Text(
                                  'Log in',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                  ),
                                ),
                              ),
                            ),

                            //Back Btn
                            const SizedBox(height: 10.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('I have an account',
                                    style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                        ?.copyWith(fontSize: 14.0)
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, RegisterPage.id);
                                  },
                                  child: Text('Log in',
                                      style: TextStyle(color: Theme.of(context).primaryColor)
                                  ),
                                ),
                              ],
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
    );
  }
}