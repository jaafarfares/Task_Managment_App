import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskapp/app/providers.dart';
import '../models/task/task_model.dart';
import '../services/task_service.dart';

class TaskViewModel extends StateNotifier<List<TaskModel>> {
  final TaskService _taskService;
  final String userId;

  TaskViewModel(this._taskService, this.userId) : super([]) {
    loadTasks();
  }

  void loadTasks() {
    _taskService.getTasks(userId).listen((tasks) {
      state = tasks;
    });
  }

  Future<void> createTask(TaskModel task) async {
    await _taskService.addTask(task);
  }

  Future<void> deleteTask(String taskId) async {
    await _taskService.deleteTask(taskId);
  }

 Future<void> updateTask(TaskModel updatedTask) async {
  try {
    await _taskService.updateTask(updatedTask);
  } catch (e) {
    throw Exception('Failed to update task');
  }
}

}

final taskViewModelProvider =
    StateNotifierProvider.family<TaskViewModel, List<TaskModel>, String>(
  (ref, userId) => TaskViewModel(ref.read(taskServiceProvider), userId),
);
