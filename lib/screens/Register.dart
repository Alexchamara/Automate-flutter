import 'package:flutter/material.dart';

import '../layout.dart';
import 'login.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  static final String id = 'RegisterPage';

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
                        // Navigator.pushNamed(context, MainLayoyt.id);
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
                      Text('Register to manage your account',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  fontSize: 14.0, fontWeight: FontWeight.bold)),

                      // Form
                      Container(
                        // color: Colors.red[100],
                        padding: const EdgeInsets.symmetric(
                            vertical: 30.0, horizontal: 20.0
                        ),
                        child: Column(
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Full Name',
                                hintText: 'Enter your full name',
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
                            const PasswordField(
                              labelText: 'Confirm Password',
                              hintText: 'Confirm your password',
                            ),

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
                                  'Register',
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
                                Text('Don\'t have an account?',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(fontSize: 14.0)
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, LoginPage.id);
                                  },
                                  child: Text('Register',
                                      style: TextStyle(color: Theme.of(context).primaryColor)
                                  ),
                                ),
                              ],
                            ),
                            //Back btn
                            // MaterialButton(
                            //   height: 50,
                            //   minWidth: MediaQuery.of(context).size.width,
                            //   onPressed: () {
                            //     Navigator.push(
                            //       context,
                            //       PageRouteBuilder(
                            //         pageBuilder: (context, animation,
                            //                 secondaryAnimation) =>
                            //             const AccountPage(),
                            //         transitionsBuilder: (context, animation,
                            //             secondaryAnimation, child) {
                            //           const begin = Offset(1.0, 0.0);
                            //           const end = Offset(0.0, 0.0);
                            //           const curve = Curves.easeOutQuint;
                            //
                            //           var tween = Tween(begin: begin, end: end)
                            //               .chain(CurveTween(curve: curve));
                            //           var slideAnimation =
                            //               animation.drive(tween);
                            //
                            //           return SlideTransition(
                            //             position: slideAnimation,
                            //             child: child,
                            //           );
                            //         },
                            //         transitionDuration: const Duration(
                            //             seconds: 1), // Slow-motion effect
                            //       ),
                            //     );
                            //   },
                            //   color: Theme.of(context).primaryColor,
                            //   child: Text(
                            //     'Back',
                            //     style: Theme.of(context)
                            //         .textTheme
                            //         .bodyLarge
                            //         ?.copyWith(
                            //           color: Theme.of(context)
                            //               .scaffoldBackgroundColor,
                            //         ),
                            //   ),
                            // ),
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