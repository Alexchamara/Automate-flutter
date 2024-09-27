import 'package:automate/screens/account.dart';
import 'package:automate/screens/chat.dart';
import 'package:automate/screens/createAds.dart';
import 'package:automate/screens/home.dart';
import 'package:automate/screens/mytests.dart';
import 'package:automate/screens/search.dart';
import 'package:flutter/material.dart';

// Layout class
class Layout extends StatefulWidget {
  static final String id = 'Layout';
  final VoidCallback toggleTheme;

  const Layout({super.key, required this.toggleTheme});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0; // Store the selected index
  final PageController _pageController = PageController();

  // List of pages
  final List<Widget> _pages = [
    const HomePage(),
    const SearchPage(),
    const ChatPage(), // Changed to correct page (assumed)
    const AccountPage(),
  ];

  // Function to handle the bottom navigation bar item tap
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOut,
      );
    });
  }

  // Dispose the controller
  @override
  void dispose() {
    _pageController.dispose(); // Don't forget to dispose the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          // If the orientation is portrait
          return SafeArea(
            child: Scaffold(
              // Scaffold key
              key: _scaffoldKey,

              // AppBar
              appBar: AppBar(
                elevation: 10.0,
                automaticallyImplyLeading: false,
                title: const Text(
                  'Automate',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                backgroundColor: Theme.of(context).primaryColor,
                actions: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 10.0, 0),
                    child: IconButton(
                      icon: const Icon(Icons.dark_mode_sharp),
                      onPressed: widget.toggleTheme,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),

              // PageView
              body: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                children: _pages,
              ),

              // FloatingActionButton
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const CreateAds(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        const begin = 0.0;
                        const end = 1.0;
                        const curve = Curves.ease;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));
                        var scaleAnimation = animation.drive(tween);

                        return ScaleTransition(
                          scale: scaleAnimation,
                          child: child,
                        );
                      },
                    ),
                  );
                },
                backgroundColor: Theme.of(context).primaryColor,
                elevation: 6.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  side: const BorderSide(color: Colors.white),
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,

              // BottomNavigationBar
              bottomNavigationBar: BottomAppBar(
                shape: const CircularNotchedRectangle(),
                notchMargin: 6.0,
                child: SizedBox(
                  height: 56.0,
                  child: BottomNavigationBar(
                    currentIndex: _selectedIndex,
                    onTap: _onItemTapped,
                    items: const [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home, size: 24),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.search, size: 24),
                        label: 'Search',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.chat, size: 24),
                        label: 'Chat',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.account_circle, size: 24),
                        label: 'Account',
                      ),
                    ],
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: Theme.of(context).primaryColor,
                    unselectedItemColor: Colors.grey,
                    selectedFontSize: 12,
                    unselectedFontSize: 12,
                  ),
                ),
              ),
            ),
          );
        } else {
          // If the orientation is landscape
          return SafeArea(
            child: Scaffold(
              // Scaffold key
              key: _scaffoldKey,

              // AppBar
              appBar: AppBar(
                elevation: 10.0,
                title: const Text(
                  'Automate',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                backgroundColor: Theme.of(context).primaryColor,

                // Leading icon
                leading: IconButton(
                  icon: const Icon(Icons.menu, color: Colors.white),
                  onPressed: () {
                    _scaffoldKey.currentState?.openDrawer();
                  },
                ),
              ),

              // Drawer
              drawer: Drawer(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                child: Column(
                  children: <Widget>[
                    // Drawer header
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,

                      // Drawer header
                      child: DrawerHeader(
                        decoration: const BoxDecoration(
                          color: Color(0xFFFF3B3F),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 10.0,
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Automate',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                            const Spacer(),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: IconButton(
                                icon: const Icon(Icons.dark_mode_sharp),
                                onPressed: widget.toggleTheme,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Drawer items
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ListTile(
                              leading: Icon(
                                Icons.home,
                                size: 24,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.color,
                              ),
                              title: Text(
                                'Home',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              onTap: () {
                                setState(() {
                                  _selectedIndex = 0;
                                });
                                Navigator.pop(context);
                              },
                            ),

                            // Create Ads
                            ListTile(
                              leading: Icon(
                                Icons.create_outlined,
                                size: 24,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.color,
                              ),
                              title: Text(
                                'Create Ads',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              onTap: () {
                                setState(() {
                                  _selectedIndex = 0;
                                });
                                Navigator.pop(context);
                              },
                            ),

                            // Search
                            ListTile(
                              leading: Icon(
                                Icons.search,
                                size: 24,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.color,
                              ),
                              title: Text(
                                'Search',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              onTap: () {
                                setState(() {
                                  _selectedIndex = 1;
                                });
                                Navigator.pop(context);
                              },
                            ),

                            // Chat
                            ListTile(
                              leading: Icon(
                                Icons.chat,
                                size: 24,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.color,
                              ),
                              title: Text(
                                'Chat',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              onTap: () {
                                setState(() {
                                  _selectedIndex = 2;
                                });
                                Navigator.pop(context);
                              },
                            ),

                            // Account
                            ListTile(
                              leading: Icon(
                                Icons.account_circle,
                                size: 24,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.color,
                              ),
                              title: Text(
                                'Account',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              onTap: () {
                                setState(() {
                                  _selectedIndex = 3;
                                });
                                Navigator.pop(context);
                              },
                            ),

                            //Log out
                            ListTile(
                              leading: Icon(
                                Icons.logout,
                                size: 24,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.color,
                              ),
                              title: Text(
                                'Log out',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              onTap: () {
                                setState(() {});
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Body with AnimatedSwitcher
              body: SafeArea(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                  child: _pages[_selectedIndex],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
