import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  AuthService._();

  static final AuthService instance = AuthService._();

  static const _isLoggedInKey = 'is_logged_in';
  static const _isAdminKey = 'is_admin';

  final ValueNotifier<bool?> isLoggedIn = ValueNotifier<bool?>(null);
  final ValueNotifier<bool?> isAdmin = ValueNotifier<bool?>(null);

  Future<void> init() async {
    if (isLoggedIn.value != null) return;
    final prefs = await SharedPreferences.getInstance();
    isLoggedIn.value = prefs.getBool(_isLoggedInKey) ?? false;
    isAdmin.value = prefs.getBool(_isAdminKey) ?? false;
  }

  Future<void> login({required String login, required String password}) async {
    final prefs = await SharedPreferences.getInstance();
    
    // Check for admin credentials
    final isAdminUser = login.trim().toLowerCase() == 'admin' && password == 'admin';
    
    await prefs.setBool(_isLoggedInKey, true);
    await prefs.setBool(_isAdminKey, isAdminUser);
    
    isLoggedIn.value = true;
    isAdmin.value = isAdminUser;
  }

  Future<void> register({
    required String username,
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, true);
    await prefs.setBool(_isAdminKey, false);
    isLoggedIn.value = true;
    isAdmin.value = false;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, false);
    await prefs.setBool(_isAdminKey, false);
    isLoggedIn.value = false;
    isAdmin.value = false;
  }
}
