import '../../data/local/favorite_local_service.dart';
import '../../data/repository/favorites_repository.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesLocalService localService;

  FavoritesRepositoryImpl(this.localService);

  @override
  Future<List<String>> getFavoritePetIds() async {
    return localService.getFavoriteIds();
  }

  @override
  Future<void> toggleFavorite(String id) async {
    localService.toggleFavorite(id);
  }
}
