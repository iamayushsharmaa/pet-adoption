import '../../data/repository/favorites_repository.dart';

class GetFavoritePetIds {
  final FavoritesRepository repository;
  GetFavoritePetIds(this.repository);

  Future<List<String>> call() => repository.getFavoritePetIds();
}
