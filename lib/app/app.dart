import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/index_page.dart';
import 'package:task_manager/utils/theme.dart';

import '../utils/navigation.dart';

class MyApp extends StatelessWidget {
  final SharedPreferences? sharedPreferences;
  const MyApp({super.key,this.sharedPreferences});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Manager',
      theme: lightTheme.copyWith(
        textTheme: Theme.of(context).textTheme.apply(
              fontFamily: GoogleFonts.aBeeZee().fontFamily,
              displayColor: Colors.black,
            ),
      ),
      home: IndexPage(pref: sharedPreferences!),
      onGenerateRoute: Navigation.onGenerateRoute,
      navigatorKey: Navigation.navigatorKey,
    );
  }
}
