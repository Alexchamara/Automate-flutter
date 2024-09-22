import 'package:flutter/material.dart';

import '../layout.dart';
import 'account.dart';

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
                      Text(
                        'Automate',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
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
                            vertical: 30.0, horizontal: 20.0),
                        child: Column(
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Full Name',
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
                                labelText: 'Password',
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
                                labelText: 'Confirm Password',
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

                            //Register btn
                            const SizedBox(height: 10.0),
                            MaterialButton(
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

                            //Back Btn
                            const SizedBox(height: 10.0),
                            MaterialButton(
                              height: 50,
                              minWidth: MediaQuery.of(context).size.width,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        const AccountPage(),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      const begin = Offset(1.0, 0.0);
                                      const end = Offset(0.0, 0.0);
                                      const curve = Curves.easeOutQuint;

                                      var tween = Tween(begin: begin, end: end)
                                          .chain(CurveTween(curve: curve));
                                      var slideAnimation =
                                          animation.drive(tween);

                                      return SlideTransition(
                                        position: slideAnimation,
                                        child: child,
                                      );
                                    },
                                    transitionDuration: const Duration(
                                        seconds: 1), // Slow-motion effect
                                  ),
                                );
                              },
                              color: Theme.of(context).primaryColor,
                              child: Text(
                                'Back',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                    ),
                              ),
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
