import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskapp/utils/colors.dart';
import 'package:taskapp/widgets/custom_button.dart';
import 'package:taskapp/widgets/custom_text_field.dart';
import '../models/task/task_model.dart';
import '../viewmodels/task_viewmodel.dart';

void showUpdateTaskPopup(
    BuildContext context, WidgetRef ref, TaskModel task, String userId) {
  final titleController = TextEditingController(text: task.title);
  final descriptionController = TextEditingController(text: task.description);
  bool completed = task.completed;

  showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Center(
            child: Text(
              'Update Task',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          content: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 6.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextField(
                  controller: titleController,
                  label: 'Title',
                  hintText: 'Enter task title',
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: descriptionController,
                  label: 'Description',
                  hintText: 'Enter task description',
                  keyboardType: TextInputType.multiline,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Completed',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    DropdownButton<bool>(
                      value: completed,
                      onChanged: (bool? value) {
                        setState(() {
                          completed = value ?? false;
                        });
                      },
                      items: const [
                        DropdownMenuItem(
                          value: true,
                          child: Text('Yes'),
                        ),
                        DropdownMenuItem(
                          value: false,
                          child: Text('No'),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: 'Cancel',
                    onPressed: () => Navigator.pop(context),
                    color: AppColors.grey,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomButton(
                    text: 'Update',
                    onPressed: () {
                      final updatedTask = TaskModel(
                        id: task.id,
                        title: titleController.text,
                        description: descriptionController.text,
                        completed: completed,
                        userId: task.userId,
                      );
                      ref
                          .read(taskViewModelProvider(userId).notifier)
                          .updateTask(updatedTask);
                      Navigator.pop(context);
                    },
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    ),
  );
}
