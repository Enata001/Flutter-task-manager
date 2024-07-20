import 'package:task_manager/models/todo.dart';

class UserTasks {
  final int id;
  final List<Todo>? tasks;


  const UserTasks({
    required this.id,
    this.tasks,
  });

  @override
  bool operator ==(covariant other) =>
      identical(this, other) ||
      (other is UserTasks &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          tasks == other.tasks);

  @override
  int get hashCode => id.hashCode ^ tasks.hashCode;

  @override
  String toString() {
    return 'UserTasks{ id: $id, tasks: $tasks,}';
  }

  UserTasks copyWith({
    int? id,
    List<Todo>? tasks,
  }) {
    return UserTasks(
      id: id ?? this.id,
      tasks: tasks ?? this.tasks,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tasks': tasks,
    };
  }

  factory UserTasks.fromMap(Map<String, dynamic> map) {
    return UserTasks(
      id: map['id'],
      tasks: map['tasks'],
    );
  }

}
