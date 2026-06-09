// 10.1 / 10.2 – Login screen (mock + real API)
import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/notification_service.dart';
import 'home_screen_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final AuthService _auth = AuthService();
  final NotificationService _notifications = NotificationService();

  bool _isLoading = false;
  bool _obscure = true;
  bool _useRealApi = false;

  @override
  void dispose() {
    _usernameCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    try {
      Map<String, dynamic> result;
      if (_useRealApi) {
        // 10.2 – Real API
        result = await _auth.login(
          username: _usernameCtrl.text.trim(),
          password: _passwordCtrl.text.trim(),
        );
      } else {
        // 10.1 – Mock login
        result = await _auth.mockLogin(
          email: _usernameCtrl.text.trim(),
          password: _passwordCtrl.text.trim(),
        );
      }

      if (!mounted) return;

      if (result['success'] == true) {
        // 10.5 – Show local notification
        await _notifications.showLoginSuccessNotification(
          username: result['username'] as String,
        );
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) =>
                HomeScreenAuth(username: result['username'] as String),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result['message'] as String? ?? 'Login failed'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 48),
                const Icon(Icons.lock, size: 72, color: Colors.indigo),
                const SizedBox(height: 16),
                Text(
                  'Welcome Back',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Sign in to continue',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 32),

                // Toggle real vs mock
                SwitchListTile(
                  title: const Text('Use Real API (dummyjson.com)'),
                  subtitle: Text(_useRealApi
                      ? 'Username: emilys / Password: emilyspass'
                      : 'Mock: test@example.com / password123'),
                  value: _useRealApi,
                  onChanged: (v) => setState(() => _useRealApi = v),
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _usernameCtrl,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText:
                        _useRealApi ? 'Username' : 'Email',
                    prefixIcon: const Icon(Icons.person_outline),
                    border: const OutlineInputBorder(),
                  ),
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? 'Required'
                      : null,
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _passwordCtrl,
                  obscureText: _obscure,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock_outline),
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                          _obscure ? Icons.visibility_off : Icons.visibility),
                      onPressed: () =>
                          setState(() => _obscure = !_obscure),
                    ),
                  ),
                  onFieldSubmitted: (_) => _login(),
                  validator: (v) => (v == null || v.isEmpty)
                      ? 'Required'
                      : null,
                ),
                const SizedBox(height: 24),

                FilledButton(
                  onPressed: _isLoading ? null : _login,
                  style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16)),
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white),
                        )
                      : const Text('Login', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
