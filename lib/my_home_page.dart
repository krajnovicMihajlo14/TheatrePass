import 'package:flutter/material.dart';
import 'dart:ui';

import 'auth_service.dart';
import 'admin_page.dart';
import 'cart_page.dart';
import 'fixtures_page.dart';
import 'home_page.dart';
import 'login_page.dart';
import 'profile_page.dart';

class MyHomePage extends StatefulWidget {
  static const String routeName = '/MyHomePage';

  const MyHomePage({super.key, required this.title, this.initialIndex = 0});

  final String title;
  final int initialIndex;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _index = 0;
  PageController? _controller;

  static const _titles = ['Home', 'Fixtures', 'Cart', 'Profile', 'Admin'];

  @override
  void initState() {
    super.initState();
    AuthService.instance.init();
    _index = widget.initialIndex;
    _controller = PageController(initialPage: _index);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller ??= PageController(initialPage: _index);

    return ValueListenableBuilder<bool?>(
      valueListenable: AuthService.instance.isAdmin,
      builder: (context, isAdmin, _) {
        final showAdminTab = isAdmin == true;
        
        final pages = <Widget>[
          const HomePage(),
          const FixturesPage(),
          const CartPage(),
          ValueListenableBuilder<bool?>(
            valueListenable: AuthService.instance.isLoggedIn,
            builder: (context, loggedIn, _) {
              if (loggedIn == true) {
                return const ProfilePage();
              }
              return LoginForm(
                onSuccess: () {
                  if (!mounted) return;
                  setState(() {});
                },
              );
            },
          ),
          if (showAdminTab) const AdminPage(),
        ];

        final destinations = <NavigationDestination>[
          const NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          const NavigationDestination(
            selectedIcon: Icon(Icons.sports_soccer),
            icon: Icon(Icons.sports_soccer_outlined),
            label: 'Fixtures',
          ),
          const NavigationDestination(
            selectedIcon: Icon(Icons.shopping_cart),
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Cart',
          ),
          const NavigationDestination(
            selectedIcon: Icon(Icons.person),
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
          if (showAdminTab)
            const NavigationDestination(
              selectedIcon: Icon(Icons.admin_panel_settings),
              icon: Icon(Icons.admin_panel_settings_outlined),
              label: 'Admin',
            ),
        ];

        return Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/oldtraffordpic.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                title: Text(_titles[_index < pages.length ? _index : 0]),
              ),
              body: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: controller,
                children: pages,
              ),
              bottomNavigationBar: NavigationBar(
                selectedIndex: _index < destinations.length ? _index : 0,
                height: kBottomNavigationBarHeight,
                onDestinationSelected: (index) {
                  setState(() => _index = index);
                  controller.jumpToPage(index);
                },
                destinations: destinations,
              ),
            ),
          ),
        );
      },
    );
  }
}
