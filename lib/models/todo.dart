import 'dart:convert';

class Todo {
  final int id;
  final String todo;
  bool completed;
  final int userId;

  Todo({
    required this.id,
    required this.todo,
    this.completed = false,
    required this.userId,
  });

  @override
  bool operator ==(covariant other) =>
      identical(this, other) ||
      (other is Todo &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          todo == other.todo &&
          completed == other.completed &&
          userId == other.userId);

  @override
  int get hashCode =>
      id.hashCode ^ todo.hashCode ^ completed.hashCode ^ userId.hashCode;

  @override
  String toString() {
    return jsonEncode(toMap());
  }

  Todo copyWith({
    int? id,
    String? todo,
    bool? completed,
    int? userId,
  }) {
    return Todo(
      id: id ?? this.id,
      todo: todo ?? this.todo,
      completed: completed ?? this.completed,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'todo': todo,
      'completed': completed,
      'userId': userId,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      todo: map['todo'],
      completed: map['completed'],
      userId: map['userId'],
    );
  }

  factory Todo.fromString(String? task) {
    return Todo.fromMap(jsonDecode(task ?? "{}"));
  }
}
