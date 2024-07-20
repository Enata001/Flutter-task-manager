import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/providers/auth_provider.dart';
import 'package:task_manager/providers/cache_provider.dart';
import 'package:task_manager/providers/todo_provider.dart';

import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<AuthProvider>(
        create: (context) => AuthProvider(sharedPreferences: prefs),
      ),
      ChangeNotifierProvider<CacheProvider>(
        create: (context) => CacheProvider(sharedPreferences: prefs),
      ),
      ChangeNotifierProxyProvider<CacheProvider,ToDoProvider>(
        update: (context,cache,prevTodo) => ToDoProvider(sharedPreferences: prefs),
        create: (context) => ToDoProvider(sharedPreferences: prefs),
      ),
    ],
    child: MyApp(sharedPreferences: prefs),
  ));
}
