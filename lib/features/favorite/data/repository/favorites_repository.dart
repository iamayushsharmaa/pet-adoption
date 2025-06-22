abstract class FavoritesRepository {
  Future<List<String>> getFavoritePetIds();

  Future<void> toggleFavorite(String id);
}
