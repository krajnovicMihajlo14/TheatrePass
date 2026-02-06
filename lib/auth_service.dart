import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  AuthService._();

  static final AuthService instance = AuthService._();

  static const _isLoggedInKey = 'is_logged_in';

  final ValueNotifier<bool?> isLoggedIn = ValueNotifier<bool?>(null);

  Future<void> init() async {
    if (isLoggedIn.value != null) return;
    final prefs = await SharedPreferences.getInstance();
    isLoggedIn.value = prefs.getBool(_isLoggedInKey) ?? false;
  }

  Future<void> login({required String login, required String password}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, true);
    isLoggedIn.value = true;
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
    isLoggedIn.value = true;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, false);
    isLoggedIn.value = false;
  }
}
