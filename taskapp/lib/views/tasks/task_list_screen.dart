import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:taskapp/viewmodels/auth_viewmodel.dart';
import 'package:taskapp/viewmodels/task_viewmodel.dart';
import 'package:taskapp/widgets/custom_button.dart';
import 'package:taskapp/widgets/task_card.dart';
import 'package:taskapp/widgets/add_task_popup.dart';
import 'package:taskapp/widgets/delete_task_popup.dart';
import 'package:taskapp/widgets/update_task_popup.dart';

class TaskListScreen extends ConsumerWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authViewModelProvider);
    if (user == null) {
      return const Center(child: Text("Please sign in"));
    }

    final userId = user.id;
    final tasks = ref.watch(taskViewModelProvider(userId!));
    return Scaffold(
      appBar: AppBar(
        title: Text('weclome back ${user.name}'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomButton(
              text: 'Add New Task',
              onPressed: () {
                showAddTaskPopup(context, ref, userId);
              },
            ),
          ),
          Expanded(
            child: tasks.isEmpty
                ? const Center(child: Text('No tasks available'))
                : ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      return TaskCard(
                        task: task,
                        onDelete: () {
                          showDeleteTaskPopup(
                              context, ref, task.id!, task.title!, userId);
                        },
                        onUpdate: () {
                          showUpdateTaskPopup(context, ref, task, userId);
                        },
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 8.0, left: 66, right: 66, bottom: 33),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: CustomButton(
                text: 'Log Out',
                color: Colors.red,
                onPressed: () async {
                  try {
                    await ref.read(authViewModelProvider.notifier).signOut();
                   context.go('/login');

                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Sign out failed: $e')),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
