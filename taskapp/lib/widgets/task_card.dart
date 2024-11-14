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
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(task.title),
        subtitle: Text(task.description),
        trailing: Row(
          mainAxisSize: MainAxisSize.min, children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: onUpdate,   ),
            IconButton(
              icon: const Icon(
                Icons.delete,
                color: AppColors.red,
              ),
              onPressed: onDelete,  ),
          ],
        ),
        onTap: onUpdate,   ),
    );
  }
}
