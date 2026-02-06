import 'package:flutter/material.dart';

import 'auth_service.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Profile'),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () async {
              await AuthService.instance.logout();
            },
            child: const Text('Log out'),
          ),
        ],
      ),
    );
  }
}
