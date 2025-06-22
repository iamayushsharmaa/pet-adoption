import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:petadoption/config/widget_tree.dart';
import 'package:petadoption/features/detailscreen/presentation/screens/detail_screen.dart';
import 'package:petadoption/features/history/data/local/history_local_service.dart';
import 'package:petadoption/features/history/domain/repository/history_repository_impl.dart';
import 'package:petadoption/features/history/presentation/bloc/adopt_bloc.dart';

import '../core/entities/pet_entity.dart';
import '../core/network/dio_client.dart';
import '../features/favorite/data/local/favorite_local_service.dart';
import '../features/favorite/domain/repository/favorites_repository_impl.dart';
import '../features/favorite/domain/usecases/get_favorite_pet.dart';
import '../features/favorite/domain/usecases/toggle_favorite.dart';
import '../features/favorite/presentation/bloc/favorite_bloc.dart';
import '../features/favorite/presentation/screens/favorites.dart';
import '../features/history/domain/usecases/get_adopted_history.dart';
import '../features/history/domain/usecases/mark_pet_adopted.dart';
import '../features/history/presentation/screens/history.dart';
import '../features/home/data/model/pet_model.dart';
import '../features/home/data/remote/pet_api_service.dart';
import '../features/home/domain/repository/pet_repository_impl.dart';
import '../features/home/domain/usecases/get_all_pets_usecases.dart';
import '../features/home/presentation/bloc/home_bloc.dart';
import '../features/home/presentation/screens/home.dart';

GoRouter createRouter() {
  final initialLocation = '/home';
  final dioInstance = DioClient.create();

  return GoRouter(
    debugLogDiagnostics: true,
    initialLocation: initialLocation,
    redirect: (context, state) {
      if (state.uri.path == '/') return '/home';
      return null;
    },
    routes: [
      GoRoute(
        path: '/detail',
        name: 'detail',
        builder: (context, state) {
          final pet = state.extra as PetEntity;

          final favoritesRepo = FavoritesRepositoryImpl(
            FavoritesLocalService(),
          );
          final adoptionRepo = HistoryRepositoryImpl(HistoryLocalService());

          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => FavoritesBloc(
                  getFavoritePets: GetFavoritePets(favoritesRepo),
                  toggleFavorite: ToggleFavorite(favoritesRepo),
                ),
              ),
              BlocProvider(
                create: (_) => AdoptionBloc(
                  getAdoptedHistory: GetAdoptedHistory(adoptionRepo),
                  markPetAsAdopted: MarkPetAsAdopted(adoptionRepo),
                ),
                child: Detail(pet: pet),
              ),
            ],
            child: Detail(pet: pet),
          );
        },
      ),

      ShellRoute(
        builder: (context, state, child) => WidgetTree(child: child),
        routes: [
          GoRoute(
            path: '/home',
            name: 'home',
            builder: (context, state) {
              final useCase = GetAllPetsUseCase(
                PetRepositoryImpl(
                  PetApiService(dioInstance, Hive.box<PetModel>('cachedPets')),
                ),
              );

              return BlocProvider(
                create: (_) => HomeBloc(useCase)..add(LoadPets()),
                child: Home(getAllPetsUseCase: useCase),
              );
            },
          ),
          GoRoute(
            path: '/favorite',
            name: 'favorite',
            builder: (context, state) {
              final favoritesRepo = FavoritesRepositoryImpl(
                FavoritesLocalService(),
              );

              return BlocProvider(
                create: (_) => FavoritesBloc(
                  getFavoritePets: GetFavoritePets(favoritesRepo),
                  toggleFavorite: ToggleFavorite(favoritesRepo),
                )..add(LoadFavorites()),
                child: Favorites(), // your screen widget
              );
            },
          ),
          GoRoute(
            path: '/history',
            name: 'history',
            builder: (context, state) {
              final repo = HistoryRepositoryImpl(HistoryLocalService());

              return BlocProvider(
                create: (_) => AdoptionBloc(
                  getAdoptedHistory: GetAdoptedHistory(repo),
                  markPetAsAdopted: MarkPetAsAdopted(repo),
                )..add(LoadAdoptedPets()),
                child: const History(),
              );
            },
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text('Page not found: ${state.uri}'))),
  );
}
