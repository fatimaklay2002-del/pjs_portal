import 'package:flutter/material.dart';

class AppNavigator {
  static final GlobalKey<NavigatorState> navigatorKey =
  GlobalKey<NavigatorState>();

  static BuildContext? get context => navigatorKey.currentContext;

  static Future<T?> push<T>(Widget screen) {
    return navigatorKey.currentState!.push<T>(
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  static void pop() => navigatorKey.currentState?.pop();
}