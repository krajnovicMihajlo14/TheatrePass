import 'package:flutter/material.dart';
import 'home_page.dart';
import 'fixtures_page.dart';
import 'profile_page.dart';
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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _index = 0;
  PageController? _controller;

  static const _titles = ['Home', 'Fixtures', 'Profile'];
  final _pages = const [
    HomePage(),
    FixturesPage(),
    ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
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

    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_index]),
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        children: _pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        height: kBottomNavigationBarHeight,
        onDestinationSelected: (index) {
          setState(() => _index = index);
          controller.jumpToPage(index);
        },
        destinations: const [
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.sports_soccer),
            icon: Icon(Icons.sports_soccer_outlined),
            label: 'Fixtures',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.person),
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
