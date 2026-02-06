import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'my_home_page.dart';

class StartupGate extends StatelessWidget {
  const StartupGate({super.key});

  static const _isLoggedInKey = 'is_logged_in';

  Future<bool> _loadIsLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _loadIsLoggedIn(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final isLoggedIn = snapshot.data ?? false;
        if (isLoggedIn) {
          return const MyHomePage(title: 'Theatre Pass');
        }

        return const MyHomePage(title: 'Theatre Pass', initialIndex: 0);
      },
    );
  }
}
