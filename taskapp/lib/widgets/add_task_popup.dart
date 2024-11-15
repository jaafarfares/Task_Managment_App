import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:taskapp/utils/colors.dart';
import 'package:taskapp/widgets/custom_button.dart';
import 'package:taskapp/widgets/custom_text_field.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../models/task/task_model.dart';
import '../viewmodels/task_viewmodel.dart';

void showAddTaskPopup(BuildContext context, WidgetRef ref, String userId) {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      title: const Center(
        child: Text(
          'Add Task',
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
          ],
        ),
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: CustomButton(
                text: 'Cancel',
                onPressed: () => context.pop(),
                color: AppColors.grey,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: CustomButton(
                text: 'Add',
                onPressed: () {
                  if (titleController.text.isNotEmpty &&
                      descriptionController.text.isNotEmpty) {
                    ref
                        .read(taskViewModelProvider(userId).notifier)
                        .createTask(
                          TaskModel(
                            id: userId,
                            title: titleController.text,
                            description: descriptionController.text,
                            completed: false,
                            userId: userId,
                          ),
                        )
                        .then((_) {
                      showTopSnackBar(
                        Overlay.of(context),
                        const CustomSnackBar.success(
                          message: 'Task added successfully!',
                        ),
                      );
                      context.pop();
                    }).catchError((error) {
                      showTopSnackBar(
                        Overlay.of(context),
                        const CustomSnackBar.error(
                          message: 'Failed to add task. Please try again.',
                        ),
                      );
                    });
                  } else {
                    showTopSnackBar(
                      Overlay.of(context),
                      const CustomSnackBar.error(
                        message: 'Both fields must be filled in.',
                      ),
                    );
                  }
                },
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
