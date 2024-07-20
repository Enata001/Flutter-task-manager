import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/providers/cache_provider.dart';
import 'package:task_manager/services/todo_service.dart';
import 'package:task_manager/utils/constants.dart';

import '../models/todo.dart';
import 'auth_provider.dart';

class ToDoProvider extends ChangeNotifier {
  CacheProvider? cacheProvider;
  final SharedPreferences sharedPreferences;

  ToDoProvider({required this.sharedPreferences}) {
    cacheProvider = CacheProvider(sharedPreferences: sharedPreferences);
    cacheProvider?.getTasks();
    loadTasks();
  }

  final List<Todo> _allTasks = [];

  List<Todo> get cachedData => cacheProvider?.allTasks ?? [];

  List<Todo> get allTasks => _allTasks;

  List<Todo> get completedTasks =>
      _allTasks.where((e) => e.completed == true).toList();

  List<Todo> get pendingTasks =>
      _allTasks.where((e) => e.completed == false).toList();

  Future getAllTasks() async {
    final authProvider = AuthProvider(sharedPreferences: sharedPreferences);
    final bool downloaded =
        cacheProvider?.sharedPreferences.getBool(Constants.isDownloaded) ?? false;
    if (downloaded == false) {
      final result =
          await TodoService().fetchTodos(authProvider.user?.id ?? 1);
      await cacheProvider?.addOnlineTasks(result);
      await cacheProvider?.sharedPreferences.setBool(Constants.isDownloaded, true);
    notifyListeners();
    }
  }
  loadTasks(){
    _allTasks.addAll(cachedData);
    notifyListeners();
  }

  void addTask(Todo task) async {
    _allTasks.add(task);
    await cacheProvider?.saveTasks(_allTasks);
    notifyListeners();
  }

  void deleteTask(int id) async {
    _allTasks.removeWhere((e) => e.id == id);
    await cacheProvider?.saveTasks(_allTasks);
    notifyListeners();
  }

  void updateTask(Todo task) async {
    Todo existingTask = _allTasks.firstWhere((e) => e.id == task.id);
    int index = _allTasks.indexWhere((e) => e.id == task.id);
    _allTasks.remove(existingTask);
    _allTasks.insert(index, task);
    await cacheProvider?.saveTasks(_allTasks);
    notifyListeners();
  }

  void changeStatus(int id, bool isChecked) async {
    _allTasks.firstWhere((e) => e.id == id).copyWith(completed: isChecked);
    await cacheProvider?.saveTasks(_allTasks);
    notifyListeners();
  }

  Future clear({VoidCallback? onSuccess}) async {
    await cacheProvider?.clearTasks();
    _allTasks.clear();
    onSuccess?.call();
  }

}
