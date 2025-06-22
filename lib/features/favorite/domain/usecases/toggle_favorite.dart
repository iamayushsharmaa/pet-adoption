import '../../../../core/datasource/pet_local_model.dart';
import '../../data/repository/favorites_repository.dart';

class ToggleFavorite {
  final FavoritesRepository repository;

  ToggleFavorite(this.repository);

  Future<void> call(PetLocalModel pet) => repository.toggleFavorite(pet);
}
