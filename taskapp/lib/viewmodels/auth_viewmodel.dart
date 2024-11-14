import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskapp/app/providers.dart';
import '../services/auth_service.dart';
import '../models/user/user_model.dart';

class AuthViewModel extends StateNotifier<UserModel?> {
  final AuthService _authService;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false; 

  AuthViewModel(this._authService) : super(null) {
    _authService.authStateChanges().listen((user) {
      state = user; 
    });
  }

  String? get currentUserId => state?.id;

  Future<void> signUp(String name, String email, String password) async {
    try {
      isLoading = true; 
      state = await _authService.signUp(name, email, password);
    } catch (e) {
      throw Exception('Sign up failed: $e');
    } finally {
      isLoading = false;
    }
  }

  Future<void> signIn(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      throw 'Please enter email and password';
    }

    try {
      isLoading = true; 
      state = await _authService.signIn(email, password);

      if (state != null) {
        Navigator.pushReplacementNamed(context, '/tasks');
      }
    } catch (e) {
      throw Exception('Sign in failed: $e');
    } finally {
      isLoading = false; 
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
    state = null;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

final authViewModelProvider = StateNotifierProvider<AuthViewModel, UserModel?>(
  (ref) => AuthViewModel(ref.read(authServiceProvider)),
);

