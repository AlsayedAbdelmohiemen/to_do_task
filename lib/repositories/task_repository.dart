import 'package:hive/hive.dart';
import '../data_model/task_model.dart';

class TaskRepository {
  final Box<Task> taskBox;

  TaskRepository({required this.taskBox});

  List<Task> getAllTasks() {
    return List<Task>.from(taskBox.values);
  }

  Future<void> addTask(Task task) async {
    await taskBox.put(task.id, task);
  }

  Future<void> updateTask(Task task) async {
    await taskBox.put(task.id, task);
  }

  Future<void> deleteTask(String taskId) async {
    await taskBox.delete(taskId);
  }
}