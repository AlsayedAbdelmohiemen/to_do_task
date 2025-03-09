import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  bool isCompleted;

  Task({
    String? id,
    required this.title,
    required this.description,
    this.isCompleted = false,
  }) : id = id ?? const Uuid().v4();
}