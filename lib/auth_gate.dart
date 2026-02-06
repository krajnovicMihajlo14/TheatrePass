import 'package:flutter/material.dart';

import 'auth_service.dart';
import 'login_page.dart';
import 'my_home_page.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  void initState() {
    super.initState();
    AuthService.instance.init();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool?>(
      valueListenable: AuthService.instance.isLoggedIn,
      builder: (context, isLoggedIn, _) {
        if (isLoggedIn == null) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (!isLoggedIn) {
          return const LoginPage();
        }

        return const MyHomePage(title: 'Theatre Pass');
      },
    );
  }
}
