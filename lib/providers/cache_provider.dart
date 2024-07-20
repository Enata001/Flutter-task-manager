import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/todo.dart';
import '../utils/constants.dart';

class CacheProvider extends ChangeNotifier {
  final SharedPreferences sharedPreferences;
  List<Todo>? _allTasks;

  List<Todo>? get allTasks => _allTasks;

  CacheProvider({required this.sharedPreferences});

  getTasks() {
    var results = sharedPreferences.getStringList(Constants.userTasks) ?? [];
    print('from cache');
    var tasks = results.map((todo) {
      print(todo);
      return Todo.fromString(todo);
    }).toList();
    _allTasks = tasks;
    notifyListeners();
  }

  saveTasks(List<Todo> tasks) async {
    final results = tasks.map((todo) => todo.toString()).toList();
    await sharedPreferences.setStringList(Constants.userTasks, results ?? []);
    _allTasks = tasks;
    notifyListeners();
  }
  addOnlineTasks(List<Todo> tasks) async {
    final results = tasks.map((todo) => todo.toString()).toList();
    await sharedPreferences.setStringList(Constants.userTasks, results ?? []);
    _allTasks?.addAll(tasks);
    notifyListeners();
  }

  clearTasks() async {
    _allTasks?.clear();
    await sharedPreferences.clear();
    
    notifyListeners();
  }
}
