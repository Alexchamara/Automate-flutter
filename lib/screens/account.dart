import 'package:flutter/material.dart';

import 'Register.dart';
import 'login.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              //Account benifites lables
              Container(
                child: const Column(
                  children: [
                    Options(
                        icon_i: Icon(Icons.sell_outlined),
                        cardLable: 'First time free adverts'),
                    Options(
                        icon_i: Icon(Icons.photo_album_outlined),
                        cardLable: 'Up to 20 photos for an advert'),
                    Options(
                        icon_i: Icon(Icons.report_gmailerrorred),
                        cardLable: 'Advert reports and analytics'),
                    Options(
                        icon_i: Icon(Icons.list),
                        cardLable: 'Unlimited re-listings'),
                    Options(
                        icon_i: Icon(Icons.message_outlined),
                        cardLable: 'Instant messaging with buyers'),
                    Options(
                        icon_i: Icon(Icons.perm_media_outlined),
                        cardLable: 'Social media marketing'),
                  ],
                ),
              ),

              Column(
                children: [
                  //Login button
                  Container(
                    width: 290,
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10.0),
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
                      height: false ? 50 : 50,
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                            const LoginPage(),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              const begin = Offset(1.0, 0.0);
                              const end = Offset(0.0, 0.0);
                              const curve = Curves.easeOutQuint;

                              var tween = Tween(begin: begin, end: end)
                                  .chain(CurveTween(curve: curve));
                              var slideAnimation = animation.drive(tween);

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
                      child: Text(
                        'Log in',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                      ),
                    ),
                  ),
                  Container(
                    width: 290,
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10.0),
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
                      height: false ? 50 : 50,
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const RegisterPage(),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              const begin = Offset(1.0, 0.0);
                              const end = Offset(0.0, 0.0);
                              const curve = Curves.easeOutQuint;

                              var tween = Tween(begin: begin, end: end)
                                  .chain(CurveTween(curve: curve));
                              var slideAnimation = animation.drive(tween);

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
                      child: Text(
                        'Register',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//Lables for the options
class Options extends StatelessWidget {
  final Icon icon_i;
  final String cardLable;

  const Options({super.key, required this.icon_i, required this.cardLable});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: icon_i,
              color: Theme.of(context).primaryColor?.withOpacity(0.5),
              iconSize: 20.0,
            ),
            Text(cardLable,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontSize: 12.0)),
          ],
        ),
      ],
    );
  }
}
