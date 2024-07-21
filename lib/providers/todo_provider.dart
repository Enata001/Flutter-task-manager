import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/providers/cache_provider.dart';
import '../models/todo.dart';
import '../services/todo_service.dart';
import 'auth_provider.dart';

class ToDoProvider extends ChangeNotifier {
  final CacheProvider cacheProvider;

  ToDoProvider({required this.cacheProvider}) {
    _allTasks.addAll(allTasks);
  }

  final List<Todo> _allTasks = [];

  List<Todo> get allTasks => cacheProvider.allTasks ?? [];

  List<Todo> get completedTasks =>
      allTasks.where((e) => e.completed == true).toList();

  List<Todo> get pendingTasks =>
      allTasks.where((e) => e.completed == false).toList();

  bool get isDownloaded => cacheProvider.isDownloaded;

  void addTask(Todo task) async {
    _allTasks.add(task);
    await cacheProvider.saveTasks(_allTasks);
  }

  void deleteTask(int id) async {
    _allTasks.removeWhere((e) => e.id == id);
    await cacheProvider.saveTasks(_allTasks);

  }

  void updateTask(Todo task) async {
    Todo existingTask = _allTasks.firstWhere((e) => e.id == task.id);
    int index = _allTasks.indexWhere((e) => e.id == task.id);
    _allTasks.remove(existingTask);
    _allTasks.insert(index, task);
    await cacheProvider.saveTasks(_allTasks);

  }

  void changeStatus(int id, bool isChecked) async {
    _allTasks.firstWhere((e) => e.id == id).copyWith(completed: isChecked);

    await cacheProvider.saveTasks(_allTasks);
  }

  Future clear({VoidCallback? onSuccess}) async {
    onSuccess?.call();
    await cacheProvider.clearTasks();

  }

  Future getAllTasks() async {
    final authProvider =
        AuthProvider(sharedPreferences: cacheProvider.sharedPreferences);

    if (isDownloaded == false) {
      final result = await TodoService().fetchTodos(authProvider.user?.id ?? 1);
      await cacheProvider.addOnlineTasks(result);
    }
  }
}
