import 'package:flutter/material.dart';
import 'package:freelance_task/core/routing/app_routes.dart';
import 'package:freelance_task/core/routing/routes_keys.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> parentKey = GlobalKey<NavigatorState>();

abstract class AppRouter {
  static final router = GoRouter(
    navigatorKey: parentKey,
    routes: appRoutes,
    initialLocation: RoutesKeys.kHome,
  );
}
