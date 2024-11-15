import 'package:go_router/go_router.dart';
import 'package:taskapp/views/auth/splash_screen.dart';
import 'package:taskapp/views/auth/login_screen.dart';
import 'package:taskapp/views/auth/register_screen.dart';
import 'package:taskapp/views/tasks/task_list_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/tasks',
      builder: (context, state) => const TaskListScreen(),
    ),
  ],
);
