import 'package:flutter/material.dart';
import 'dart:ui';

import 'auth_service.dart';
import 'auth_styles.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/oldtraffordpic.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: AuthStyles.backgroundBlurSigma,
          sigmaY: AuthStyles.backgroundBlurSigma,
        ),
        child: Container(
          color: Colors.black.withOpacity(AuthStyles.backgroundOverlayOpacity),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // User info section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AuthStyles.panelBorderRadius),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: AuthStyles.panelBlurSigma,
                          sigmaY: AuthStyles.panelBlurSigma,
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: AuthStyles.panelDecoration,
                          child: Row(
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).cardColor,
                                  border: Border.all(
                                    color: Theme.of(context).colorScheme.primary,
                                    width: 3,
                                  ),
                                  image: const DecorationImage(
                                    image: NetworkImage(
                                      "https://cdn.pixabay.com/photo/2017/11/10/05/48/user-2935527_1280.png",
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "User",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      "user@email.com",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Menu section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AuthStyles.panelBorderRadius),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: AuthStyles.panelBlurSigma,
                          sigmaY: AuthStyles.panelBlurSigma,
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: AuthStyles.panelDecoration,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "General",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 10),
                              CustomListTile(
                                icon: Icons.confirmation_num_outlined,
                                text: "My Tickets",
                                onTap: () {},
                              ),
                              CustomListTile(
                                icon: Icons.settings_outlined,
                                text: "Settings",
                                onTap: () {},
                              ),
                              CustomListTile(
                                icon: Icons.help_outline,
                                text: "Help & Support",
                                onTap: () {},
                              ),
                              const SizedBox(height: 16),
                              const Divider(),
                              const SizedBox(height: 16),
                              const Text(
                                "Account",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 10),
                              CustomListTile(
                                icon: Icons.logout,
                                text: "Log Out",
                                textColor: Colors.red,
                                onTap: () async {
                                  await AuthService.instance.logout();
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
    this.textColor,
  });

  final IconData icon;
  final String text;
  final VoidCallback onTap;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(
        text,
        style: TextStyle(
          color: textColor ?? Colors.black87,
          fontSize: 16,
        ),
      ),
      leading: Icon(
        icon,
        color: textColor ?? Colors.black87,
        size: 24,
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: Colors.black54,
        size: 16,
      ),
    );
  }
}
