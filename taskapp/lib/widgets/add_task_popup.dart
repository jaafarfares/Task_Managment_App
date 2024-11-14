import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskapp/utils/colors.dart';
import 'package:taskapp/widgets/custom_button.dart';
import 'package:taskapp/widgets/custom_text_field.dart';
import '../models/task/task_model.dart';
import '../viewmodels/task_viewmodel.dart';

// Function to show the add task popup
void showAddTaskPopup(BuildContext context, WidgetRef ref, String userId) {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Rounded corners
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
                // CustomTextField for Title
                CustomTextField(
                  controller: titleController,
                  label: 'Title',
                  hintText: 'Enter task title',
                ),
                const SizedBox(height: 10), // Spacing between fields

                // CustomTextField for Description
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
            // Wrap buttons in a Row to align them side by side and expand to full width
            Row(
              children: [
                // Cancel Button using CustomButton (Expanded to take full width)
                Expanded(
                  child: CustomButton(
                    text: 'Cancel',
                    onPressed: () => Navigator.pop(context),
                    color: AppColors.grey, // Use grey for cancel button
                  ),
                ),
                const SizedBox(width: 10), // Space between buttons

                // Add Button using CustomButton (Expanded to take full width)
                Expanded(
                  child: CustomButton(
                    text: 'Add',
                    onPressed: () {
                      // Check if title and description are not empty
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
                            );
                        Navigator.pop(context);
                      } else {
                        // Show an error message if fields are empty
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Both fields must be filled in'),
                            backgroundColor: AppColors.red,
                          ),
                        );
                      }
                    },
                    color: AppColors.primaryColor, // Use blue for add button
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




