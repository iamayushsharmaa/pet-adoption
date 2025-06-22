import '../../data/repository/favorites_repository.dart';

class ToggleFavorite {
  final FavoritesRepository repository;

  ToggleFavorite(this.repository);

  Future<void> call(String id) => repository.toggleFavorite(id);
}
