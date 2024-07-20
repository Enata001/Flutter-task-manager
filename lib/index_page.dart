import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/features/home/screens/home_screen.dart';
import 'package:task_manager/providers/cache_provider.dart';
import 'package:task_manager/utils/constants.dart';
import 'package:task_manager/utils/dimensions.dart';
import 'features/auth/screens/auth_screen.dart';

class IndexPage extends StatefulWidget {
  final SharedPreferences pref;

  const IndexPage({super.key, required this.pref});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initializeDependencies(widget.pref),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return const AuthCheck();
        }

        // Splash Screen
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/tasks-app.png'),
                const SizedBox(
                  height: Dimensions.smallSpace,
                ),
                CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.secondary,
                  strokeCap: StrokeCap.round,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<bool> initializeDependencies(SharedPreferences pref) async {
    bool finished = await Future.delayed(
        const Duration(
          seconds: 2,
        ), () {
      bool isDone = pref.containsKey(Constants.userData);

      return isDone;
    });
    return finished;
  }
}

class AuthCheck extends StatelessWidget {
  const AuthCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CacheProvider>(builder: (context, value, child) {
      final user = value.sharedPreferences.containsKey(Constants.userData);
      if(user) {
        return const HomeScreen();
      } else {
        return const AuthScreen();
      }
    },
    );
  }
}
