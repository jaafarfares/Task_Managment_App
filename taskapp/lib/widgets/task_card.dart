import 'package:flutter/material.dart';
import 'package:taskapp/utils/colors.dart';
import '../models/task/task_model.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;
  final VoidCallback onDelete;
  final VoidCallback onUpdate;

  const TaskCard({
    super.key,
    required this.task,
    required this.onDelete,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: const BorderSide(
          color: AppColors.primaryColor, 
          width: 1.5, 
        ),
      ),
      color: AppColors.white,
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        title: Text(
          task.title!,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
            color:
                AppColors.black, 
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            task.description!,
            style: const TextStyle(
              fontSize: 14.0,
              color: AppColors.black,
            ),
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.primaryColor
                    .withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.edit,
                  color: AppColors.primaryColor,
                ),
                onPressed: onUpdate,
              ),
            ),
            const SizedBox(width: 10), 
           
            Container(
              decoration: BoxDecoration(
                color: AppColors.red
                    .withOpacity(0.1), 
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: AppColors.red,
                ),
                onPressed: onDelete,
              ),
            ),
          ],
        ),
        onTap: onUpdate,
      ),
    );
  }
}
