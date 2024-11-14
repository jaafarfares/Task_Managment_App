import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../services/auth_service.dart';
import '../services/task_service.dart';

final authServiceProvider = Provider((ref) => AuthService());
final taskServiceProvider = Provider((ref) => TaskService());
