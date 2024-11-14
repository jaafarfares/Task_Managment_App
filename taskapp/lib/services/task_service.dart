import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task/task_model.dart';

class TaskService {
  final CollectionReference tasksCollection = FirebaseFirestore.instance.collection('tasks');

  Future<void> addTask(TaskModel task) async {
    await tasksCollection.add(task.toJson());
  }

  Stream<List<TaskModel>> getTasks(String userId) {
    return tasksCollection
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => TaskModel.fromDocument(doc)).toList();
    });
  }

  Future<void> updateTask(TaskModel task) async {
    await tasksCollection.doc(task.id).update(task.toJson());
  }

  Future<void> deleteTask(String taskId) async {
    await tasksCollection.doc(taskId).delete();
  }
}
