import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/todo.dart';
import '../utils/constants.dart';

class CacheProvider extends ChangeNotifier {
  final SharedPreferences sharedPreferences;
  List<Todo>? _allTasks;

  List<Todo>? get allTasks => _allTasks;

  bool? _isDownloaded;

  bool get isDownloaded => _isDownloaded ?? false;

  CacheProvider({required this.sharedPreferences}) {
    _isDownloaded = sharedPreferences.getBool(Constants.isDownloaded) ?? false;
    notifyListeners();
    getTasks();
  }

  getTasks() {
    var results = sharedPreferences.getStringList(Constants.userTasks) ?? [];
    var tasks = results.map((todo) {
      return Todo.fromString(todo);
    }).toList();
    _allTasks = tasks;
    notifyListeners();
  }

  saveTasks(List<Todo> tasks) async {
    final results = tasks.map((todo) => todo.toString()).toList();
    await sharedPreferences.setStringList(Constants.userTasks, results);
    _allTasks = tasks;
    notifyListeners();
  }

  addOnlineTasks(List<Todo> tasks) async {
    final results = tasks.map((todo) => todo.toString()).toList();
    await sharedPreferences.setStringList(Constants.userTasks, results);
    _allTasks?.addAll(tasks);
    _isDownloaded =true;
    await sharedPreferences.setBool(Constants.isDownloaded, _isDownloaded!);
    notifyListeners();
  }

  clearTasks() async {
    _allTasks?.clear();
    _isDownloaded = false;
    await sharedPreferences.clear();
    notifyListeners();
  }
}
