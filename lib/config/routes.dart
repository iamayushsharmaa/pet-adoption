import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:petadoption/config/widget_tree.dart';
import 'package:petadoption/features/search/screens/search.dart';

import '../core/network/dio_client.dart';
import '../features/favorite/presentation/screens/favorites.dart';
import '../features/history/presentation/screens/history.dart';
import '../features/home/data/model/pet_model.dart';
import '../features/home/data/remote/pet_api_service.dart';
import '../features/home/domain/repository/pet_repository_impl.dart';
import '../features/home/domain/usecases/get_all_pets_usecases.dart';
import '../features/home/presentation/screens/home.dart';

GoRouter createRouter() {
  final initialLocation = '/home';
  final dioInstance = DioClient.create();

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
            builder: (context, state) => Home(
              getAllPetsUseCase: GetAllPetsUseCase(
                PetRepositoryImpl(
                  PetApiService(dioInstance, Hive.box<PetModel>('cachedPets')),
                ),
              ),
            ),
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
