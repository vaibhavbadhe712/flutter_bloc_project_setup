// lib/presentation/routes/app_router.dart - Updated
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../pages/home/home_page.dart';
import '../pages/user_detail/user_detail_page.dart';
import '../pages/trip_logs/trip_logs_page.dart';

class AppRouter {
  static const String home = '/';
  static const String userDetail = '/user-detail';
  static const String tripLogs = '/trip-logs';
  
  static final GoRouter router = GoRouter(
    initialLocation: home,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: home,
        name: 'home',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '$userDetail/:userId',
        name: 'userDetail',
        builder: (context, state) {
          final userIdString = state.pathParameters['userId']!;
          final userId = int.parse(userIdString);
          return UserDetailPage(userId: userId);
        },
      ),
      GoRoute(
        path: '$tripLogs/:tripId',
        name: 'tripLogs',
        builder: (context, state) {
          final tripId = state.pathParameters['tripId']!;
          return TripLogsPage(tripId: tripId);
        },
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(
        title: const Text('Page Not Found'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              'Page not found!',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'The page "${state.uri}" does not exist.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go(home),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
}

// Extension for easier navigation
extension AppRouterExtension on BuildContext {
  void goToUserDetail(int userId) {
    go('${AppRouter.userDetail}/$userId');
  }
  
  void goToHome() {
    go(AppRouter.home);
  }
  
  void goToTripLogs(String tripId) {
    go('${AppRouter.tripLogs}/$tripId');
  }
  
  void pushUserDetail(int userId) {
    push('${AppRouter.userDetail}/$userId');
  }
  
  void pushTripLogs(String tripId) {
    push('${AppRouter.tripLogs}/$tripId');
  }
}

