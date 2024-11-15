import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:taskapp/utils/colors.dart';
import 'package:taskapp/widgets/custom_button.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../viewmodels/task_viewmodel.dart';

void showDeleteTaskPopup(BuildContext context, WidgetRef ref, String taskId,
    String userId, String taskTitle) {
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
              'Delete Task',
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
                Text(
                  'Are you sure you want to delete the task "$taskTitle"?',
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
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
                    text: 'Delete',
                    onPressed: () {
                      ref
                          .read(taskViewModelProvider(userId).notifier)
                          .deleteTask(taskId)
                          .then((_) {
                        showTopSnackBar(
                          Overlay.of(context),
                          CustomSnackBar.success(
                            message: 'Task deleted successfully!',
                          ),
                        );
                        onPressed: () => context.pop();
                      }).catchError((error) {
                        showTopSnackBar(
                          Overlay.of(context),
                          CustomSnackBar.error(
                            message: 'Failed to delete task. Please try again.',
                          ),
                        );
                      });
                    },
                    color: AppColors.red,
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
