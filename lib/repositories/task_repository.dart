import 'package:hive/hive.dart';
import '../data_model/task_model.dart';

class TaskRepository {
  final Box<Task> taskBox;

  TaskRepository({required this.taskBox});

  List<Task> getAllTasks() => taskBox.values.toList();

  void addTask(Task task) => taskBox.put(task.id, task);

  void updateTask(Task task) => taskBox.put(task.id, task);

  void deleteTask(String taskId) => taskBox.delete(taskId);
}