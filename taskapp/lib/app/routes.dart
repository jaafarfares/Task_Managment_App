import 'package:flutter/material.dart';
import 'package:taskapp/views/auth/splash_screen.dart';
import 'package:taskapp/views/auth/login_screen.dart';
import 'package:taskapp/views/auth/register_screen.dart';
import 'package:taskapp/views/tasks/task_list_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const SplashScreen(),
  '/login': (context) => const LoginScreen(),
  '/register': (context) => const RegisterScreen(),
  '/tasks': (context) => const TaskListScreen(),
};

