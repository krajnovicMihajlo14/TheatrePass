import 'package:flutter/material.dart';
import 'login_page.dart';
import 'my_home_page.dart';
import 'register_page.dart';
import 'startup_gate.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Theatre Pass',
      theme: AppTheme.darkTheme,
      home: const StartupGate(),
      routes: {
        LoginPage.routeName: (context) => const LoginPage(),
        MyHomePage.routeName: (context) => const MyHomePage(title: 'Theatre Pass'),
        RegisterPage.routeName: (context) => const RegisterPage(),
      },
    );
  }
}
