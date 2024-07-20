import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/features/auth/screens/auth_screen.dart';
import 'package:task_manager/features/home/screens/home_screen.dart';

import '../index_page.dart';

class Navigation {
  const Navigation._();

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static const index = "/index";
  static const login = "/login";
  static const home = "/home";

  static goTo(String routeName, [dynamic args]) {
    return navigatorKey.currentState?.pushNamed(routeName, arguments: args);
  }

  static skipTo(String routeName, [dynamic args]) {
    return navigatorKey.currentState
        ?.pushNamedAndRemoveUntil(routeName, (route) => false, arguments: args);
  }

  static close() {
    return navigatorKey.currentState?.pop();
  }

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case index:
        return OpenRoute(widget: IndexPage(pref: settings.arguments as SharedPreferences,));
      case home:
        return OpenRoute(widget: const HomeScreen());
      case login:
        return OpenRoute(widget: const AuthScreen());
      default:
        return OpenRoute(
            widget: ErrorScreen(
          settings: settings,
        ));
    }
  }
}

class OpenRoute extends PageRouteBuilder {
  final Widget widget;

  OpenRoute({
    required this.widget,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => widget,
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              SlideTransition(
            position:
                Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero)
                    .animate(animation),
            child: child,
          ),
        );
}

class ErrorScreen extends StatelessWidget {
  final RouteSettings settings;

  const ErrorScreen({super.key, required this.settings});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("${settings.name} page does not exist"),
      ),
    );
  }
}
