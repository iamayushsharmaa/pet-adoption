import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:petadoption/config/widget_tree.dart';
import 'package:petadoption/features/search/screens/search.dart';

import '../features/favorite/presentation/screens/favorites.dart';
import '../features/history/presentation/screens/history.dart';
import '../features/home/presentation/screens/home.dart';

GoRouter createRouter() {
  final initialLocation = '/home';

  return GoRouter(
    debugLogDiagnostics: true,
    initialLocation: initialLocation,
    routes: [
      GoRoute(
        path: '/search',
        name: 'search',
        builder: (context, state) => Search(),
      ),
      ShellRoute(
        builder: (context, state, child) => WidgetTree(child: child),
        routes: [
          GoRoute(
            path: '/home',
            name: 'home',
            builder: (context, state) => Home(),
          ),
          GoRoute(
            path: '/favorite',
            name: 'favorite',
            builder: (context, state) => Favorites(),
          ),
          GoRoute(
            path: '/history',
            name: 'history',
            builder: (context, state) => History(),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text('Page not found: ${state.uri}'))),
  );
}
