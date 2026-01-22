import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/app/navigation/route_paths.dart';
import 'package:myapp/shared/screens/error_page.dart';
import 'package:myapp/shared/screens/under_development.dart';

/// App router configuration
class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/login',
    debugLogDiagnostics: true,
    routes: [
      // Auth routes
      GoRoute(
        path: RoutePaths.login,
        name: 'login',
        builder: (context, state) =>
            const UnderDevelopmentScreen(titleKey: 'login'),
      ),
      // Error route
      GoRoute(
        path: RoutePaths.error,
        name: 'error',
        builder: (context, state) {
          final error = state.extra as String? ?? 'unknownError';
          return ErrorPage(error: error);
        },
      ),
    ],
    errorBuilder: (context, state) =>
        ErrorPage(error: state.error?.toString() ?? 'unknownError'),
  );

  /// Navigation methods
  static void goToLogin(BuildContext context) {
    context.go(RoutePaths.login);
  }

  /// Navigate to home
  static void goToHome(BuildContext context) {
    context.go(RoutePaths.home);
  }

  static void goToError(BuildContext context, {required String error}) {
    context.go(RoutePaths.error, extra: error);
  }

  static void pop(BuildContext context) {
    context.pop();
  }

  static void popUntil(BuildContext context, String routeName) {
    context.go('/$routeName');
  }

  static String getCurrentLocation(BuildContext context) =>
      GoRouterState.of(context).uri.toString();
}
