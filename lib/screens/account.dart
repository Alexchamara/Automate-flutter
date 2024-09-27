import 'package:flutter/material.dart';

import '../layout.dart';
import 'Register.dart';
import 'login.dart';

// AccountPage
class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return const AccountPortrait();
        } else {
          return const AccountLandscape();
        }
      },
    );
  }
}

//Account portrait
class AccountPortrait extends StatelessWidget {
  const AccountPortrait({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: SingleChildScrollView(
          child: Column(
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
                  icon_i: Icon(Icons.list), cardLable: 'Unlimited re-listings'),
              Options(
                  icon_i: Icon(Icons.message_outlined),
                  cardLable: 'Instant messaging with buyers'),
              Options(
                  icon_i: Icon(Icons.perm_media_outlined),
                  cardLable: 'Social media marketing'),

              // Buttons - Login and Register
              Column(
                children: [
                  //Login button
                  AccountBtns(
                    buttonText: 'Log in',
                    navigateTo: LoginPage(),
                  ),

                  //Register button
                  AccountBtns(
                    buttonText: 'Register',
                    navigateTo: RegisterPage(),
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

//Account landscape
class AccountLandscape extends StatelessWidget {
  const AccountLandscape({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: ListView(
          children: const [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Options(
                    icon_i: Icon(Icons.sell_outlined),
                    cardLable: 'First time free adverts',
                  ),
                ),
                Flexible(
                  child: Options(
                    icon_i: Icon(Icons.photo_album_outlined),
                    cardLable: 'Up to 20 photos for an advert',
                  ),
                ),
              ],
            ),
            SizedBox(height: 5), // Minimal height between rows
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Options(
                    icon_i: Icon(Icons.report_gmailerrorred),
                    cardLable: 'Advert reports and analytics',
                  ),
                ),
                Flexible(
                  child: Options(
                    icon_i: Icon(Icons.list),
                    cardLable: 'Unlimited re-listings',
                  ),
                ),
              ],
            ),
            SizedBox(height: 5), // Minimal height between rows
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Options(
                    icon_i: Icon(Icons.message_outlined),
                    cardLable: 'Instant messaging with buyers',
                  ),
                ),
                Flexible(
                  child: Options(
                    icon_i: Icon(Icons.perm_media_outlined),
                    cardLable: 'Social media marketing',
                  ),
                ),
              ],
            ),
            SizedBox(height: 5), // Minimal height between rows

            // Buttons - Login and Register
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //Login button
                AccountBtns(
                  buttonText: 'Log in',
                  navigateTo: LoginPage(),
                ),

                //Register button
                AccountBtns(
                  buttonText: 'Register',
                  navigateTo: RegisterPage(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//Options
class Options extends StatelessWidget {
  final Icon icon_i;
  final String cardLable;

  const Options({super.key, required this.icon_i, required this.cardLable});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () {},
            icon: icon_i,
            color: Theme.of(context).primaryColor?.withOpacity(0.7),
            iconSize: 20.0,
          ),
          const SizedBox(width: 8), // Space between icon and text
          Flexible(
            child: Text(
              cardLable,
              style:
                  Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 14.0),
            ),
          ),
        ],
      ),
    );
  }
}

//Account buttons widget
class AccountBtns extends StatelessWidget {
  final String buttonText;
  final Widget navigateTo;

  const AccountBtns({
    super.key,
    required this.buttonText, // Text to display on the button
    required this.navigateTo, // The page to navigate to
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 290,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10.0),
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
        height: 50, // Fixed height
        onPressed: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  navigateTo, // Custom page to navigate to
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
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
              transitionDuration: const Duration(seconds: 1), // Transition time
            ),
          );
        },
        child: Text(
          buttonText, // Customizable text
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
        ),
      ),
    );
  }
}




//For register page & login page
// AccountPageTitle widget
class AccountPageTitle extends StatelessWidget {
  const AccountPageTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Welcome to',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        const SizedBox(height: 10.0),
        MaterialButton(
          onPressed: () {
            Navigator.pushNamed(context, Layout.id);
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
                ?.copyWith(fontSize: 14.0, fontWeight: FontWeight.bold)),
      ],
    );
  }
}

// AccountBtns widget - Submit Btn
class SwitchBtn extends StatelessWidget {
  final String textFeild;
  final String btnName;
  final String navigateTo;

  const SwitchBtn({
    Key? key,
    required this.textFeild,
    required this.btnName,
    required this.navigateTo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          textFeild,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 14.0),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => navigateTo == LoginPage.id ? const LoginPage() : const RegisterPage(),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  const begin = Offset(1.0, 0.0);
                  const end = Offset.zero;
                  const curve = Curves.easeOutQuint;

                  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                  var offsetAnimation = animation.drive(tween);

                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                },
              ),
            );
          },
          child: Text(
            btnName,
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
      ],
    );
  }
}