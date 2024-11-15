import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:taskapp/app/providers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskapp/utils/helper_functions.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../services/auth_service.dart';
import '../models/user/user_model.dart';

class AuthViewModel extends StateNotifier<UserModel?> {
  final AuthService _authService;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  AuthViewModel(this._authService) : super(null) {
    _loadUserFromStorage();
    _authService.authStateChanges().listen((user) {
      if (user != null) {
        state = user;
        _saveUserToStorage(user);
      } else {
        state = null;
        _clearUserFromStorage();
      }
    });
  }

  String? get currentUserId => state?.id;
  Future<void> signUp(BuildContext context) async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(message: 'Please fill in all the fields'),
      );
      return;
    }

    if (!isValidEmail(email)) {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(message: 'Please enter a valid email'),
      );
      return;
    }

    if (!isValidPassword(password)) {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
            message: 'Password must be at least 6 characters long'),
      );
      return;
    }

    try {
      isLoading = true;
      state = await _authService.signUp(name, email, password);

      if (state != null) {
        emailController.clear();
        passwordController.clear();
        nameController.clear();
        await signOut();

        showTopSnackBar(
          Overlay.of(context),
          const CustomSnackBar.success(message: 'Sign up successful! Please log in.'),
        );

       context.go('/login');

      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = getFirebaseAuthErrorMessage(e);
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(message: errorMessage),
      );
    } catch (e) {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
            message: 'An unexpected error occurred. Please try again.'),
      );
    } finally {
      isLoading = false;
    }
  }

  Future<void> signIn(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(message: 'Please enter both email and password'),
      );
      return;
    }

    if (!isValidEmail(email)) {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(message: 'Please enter a valid email'),
      );
      return;
    }

    if (!isValidPassword(password)) {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
            message: 'Password must be at least 6 characters long'),
      );
      return;
    }

    try {
      isLoading = true;
      state = await _authService.signIn(email, password);

      if (state != null) {
       context.go('/tasks');

        emailController.clear();
        passwordController.clear();
        _saveUserToStorage(state!);

        showTopSnackBar(
          Overlay.of(context),
          const CustomSnackBar.success(message: 'Login success!'),
        );
      } else {
        showTopSnackBar(
          Overlay.of(context),
          const CustomSnackBar.error(message: 'Sign in failed. Please try again.'),
        );
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = getFirebaseAuthErrorMessage(e);
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(message: errorMessage),
      );
    } catch (e) {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
            message: 'An unexpected error occurred. Please try again.'),
      );
    } finally {
      isLoading = false;
    }
  }
  Future<void> signOut() async {
    await _authService.signOut();
    state = null;
    _clearUserFromStorage();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _loadUserFromStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');
    if (userId != null) {
      state = await _authService.getUserFromFirestore(userId);
    }
  }

  Future<void> _saveUserToStorage(UserModel user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userId', user.id!);
  }

  Future<void> _clearUserFromStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('userId');
  }
}

final authViewModelProvider = StateNotifierProvider<AuthViewModel, UserModel?>(
  (ref) => AuthViewModel(ref.read(authServiceProvider)),
);
