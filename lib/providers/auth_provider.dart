import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/models/userdata.dart';
import 'package:task_manager/utils/constants.dart';
import 'package:task_manager/utils/extensions.dart';

class AuthProvider extends ChangeNotifier {
  final SharedPreferences sharedPreferences;

  AuthProvider({required this.sharedPreferences});

  Userdata? get user => sharedPreferences.getUserdata();


  Future saveUserinfo({required Userdata user}) async {
    String stringUserInfo = user.toString();
    await sharedPreferences.setString(Constants.userData, stringUserInfo);
    notifyListeners();
  }

  bool get isLoggedIn => sharedPreferences.containsKey(Constants.userData);
}
