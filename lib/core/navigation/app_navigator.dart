import 'dart:developer';

import 'package:flutter/material.dart';

class AppNavigator {
  // Global navigator key - add this to your MaterialApp
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  // Get the current context from navigator
  static BuildContext? get currentContext => navigatorKey.currentContext;

  // Logout method - navigates to login and clears stack
  static void logout() {
    final context = currentContext;
    log('${context == null}');
    if (context != null) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/login', // Replace with your login route
        (route) => false, // This clears all previous routes
      );
    }
  }

  // Alternative logout with different route clearing
  static void logoutToWelcome() {
    final context = currentContext;
    if (context != null) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/welcome', // Replace with your welcome/onboarding route
        (route) => false,
      );
    }
  }

  // Logout with replacement (no animation)
  static void logoutReplace() {
    final context = currentContext;
    if (context != null) {
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  // General navigation helper methods
  static void navigateTo(String routeName) {
    final context = currentContext;
    if (context != null) {
      Navigator.of(context).pushNamed(routeName);
    }
  }

  static void navigateAndClearStack(String routeName) {
    final context = currentContext;
    if (context != null) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        routeName,
        (route) => false,
      );
    }
  }

  static void goBack() {
    final context = currentContext;
    if (context != null && Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }
}
