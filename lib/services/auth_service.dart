import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _tokenKey = 'auth_token';
  static const String _usernameKey = 'auth_username';

  // 10.2 – Real API login via dummyjson.com
  Future<Map<String, dynamic>> login({
    required String username,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('https://dummyjson.com/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    final data = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 200) {
      final token = data['accessToken'] as String;
      final uname = data['username'] as String;
      await _saveSession(token: token, username: uname);
      return {'success': true, 'token': token, 'username': uname};
    }

    return {'success': false, 'message': data['message'] ?? 'Login failed'};
  }

  // 10.1 – Mock login (simulated delay + fake token)
  Future<Map<String, dynamic>> mockLogin({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
    if (email == 'test@example.com' && password == 'password123') {
      const token = 'mock_token_abc123';
      await _saveSession(token: token, username: email);
      return {'success': true, 'token': token, 'username': email};
    }
    return {'success': false, 'message': 'Invalid credentials'};
  }

  // 10.3 – Save session to SharedPreferences
  Future<void> _saveSession({
    required String token,
    required String username,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    await prefs.setString(_usernameKey, username);
  }

  // 10.3 – Load saved token
  Future<String?> getSavedToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<String?> getSavedUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_usernameKey);
  }

  // 10.3 – Logout / clear session
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_usernameKey);
  }
}
