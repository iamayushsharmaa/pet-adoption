import '../../../../core/datasource/pet_local_model.dart';
import '../../data/local/favorite_local_service.dart';
import '../../data/repository/favorites_repository.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesLocalService localService;

  FavoritesRepositoryImpl(this.localService);

  @override
  Future<List<PetLocalModel>> getFavoritePets() async {
    return localService.getFavoritePets();
  }

  @override
  Future<void> toggleFavorite(PetLocalModel pet) async {
    localService.toggleFavorite(pet);
  }
}