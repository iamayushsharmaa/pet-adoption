import 'package:bloc/bloc.dart';

import '../../../../core/datasource/pet_local_model.dart';
import '../../domain/usecases/get_favorite_pet.dart';
import '../../domain/usecases/toggle_favorite.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final GetFavoritePets getFavoritePets;
  final ToggleFavorite toggleFavorite;

  FavoritesBloc({
    required this.getFavoritePets,
    required this.toggleFavorite,
  }) : super(FavoritesInitial()) {
    on<LoadFavorites>(_onLoadFavorites);
    on<ToggleFavoritePet>(_onToggleFavorite);
  }

  Future<void> _onLoadFavorites(
      LoadFavorites event,
      Emitter<FavoritesState> emit,
      ) async {
    emit(FavoritesLoading());
    try {
      final favorites = await getFavoritePets();
      emit(FavoritesLoaded(favorites));
    } catch (e) {
      emit(FavoritesError('Failed to load favorites'));
    }
  }

  Future<void> _onToggleFavorite(
      ToggleFavoritePet event,
      Emitter<FavoritesState> emit,
      ) async {
    await toggleFavorite(event.pet);

    // Refresh the list after toggling
    final favorites = await getFavoritePets();
    emit(FavoritesLoaded(favorites));
  }
}
