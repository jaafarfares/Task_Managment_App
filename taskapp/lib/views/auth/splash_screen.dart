import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../viewmodels/auth_viewmodel.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authViewModelProvider);
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (user != null) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/tasks',
          (route) => false, 
        );
      } else {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/login',
          (route) => false, 
        );
      }
    });

    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
