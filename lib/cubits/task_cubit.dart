import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import '../data_model/task_model.dart';

class TaskCubit extends Cubit<List<Task>> {
  final Box<Task> taskBox;

  TaskCubit({required this.taskBox}) : super(taskBox.values.toList());

  void addTask(Task task) {
    taskBox.put(task.id, task);
    emit(taskBox.values.toList());
  }

  void updateTask(Task updatedTask) {
    taskBox.put(updatedTask.id, updatedTask);
    emit(taskBox.values.toList());
  }

  void toggleTaskCompletion(String taskId) {
    final task = taskBox.get(taskId);
    if (task != null) {
      task.isCompleted = !task.isCompleted;
      taskBox.put(taskId, task);
      emit(taskBox.values.toList());
    }
  }

  void deleteTask(String taskId) {
    taskBox.delete(taskId);
    emit(taskBox.values.toList());
  }
}
